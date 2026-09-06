# Orquestación — el motor del super equipo

Cómo se contrata a los miembros de la plantilla (`equipo-*`), cómo se coordina el
trabajo paralelo sin que las piezas choquen, y cómo se integra y revisa. Léelo antes
de orquestar un equipo mediano o grande.

## La escalera de mecanismos (aislamiento real)

Cada miembro es un **agente permanente** en `~/.claude/agents/`: los 24 leads en
`equipo-<area>.md` y los 210 especialistas en `equipo-<area>-<slug>.md`. Su definición ES
su system prompt.

**Antes de elegir mecanismo, elige nivel.** Baja cada slice de área a tecnología concreta
y contrata al **especialista** siempre que exista; deja el **lead** para cuando haya que
elegir tecnología o coordinar a varios de los suyos. Los nombres exactos están en
`roster.md`: se contrata por nombre, y un nombre adivinado falla la llamada.

Elige el mecanismo por capacidad real, en este orden:

1. **Workflow** — por defecto para equipos medianos/grandes. Cada contratación es
   `agent(slice, { agentType: 'equipo-<area>-<slug>', ... })`: fan-out en paralelo, `schema`
   para forzar el formato de entrega, `isolation:'worktree'` cuando varios escriben
   ficheros a la vez en un repo git, `budget` para escalar profundidad. Esta skill te
   instruye a usarlo (constituye el opt-in de la herramienta Workflow).
2. **Agent** — `subagent_type: 'equipo-<area>-<slug>'`, varias llamadas en el MISMO
   mensaje → corren en paralelo. Ideal para equipos pequeños (2–4 especialistas).
3. **Puente de sesión** — si el `equipo-*` no está registrado aún (se creó en esta
   sesión), agente general cuyo prompt empieza: "PRIMERO lee entero
   `~/.claude/agents/<nombre-del-agente>.md` y encárnalo como tu identidad y tus
   reglas. DESPUÉS ejecuta este encargo:" + slice + contratos + rutas. Misma identidad
   y aislamiento; se declara en la entrega.
4. **`claude -p` en terminal** — contexto limpio real, tandas de máximo 2 (cada proceso
   ~1–2 GB; PC de 16 GB). Escribe antes con Write un fichero de prompt que contenga:
   el CUERPO de la definición del agente + el encargo; pásalo por stdin:
   `claude -p --permission-mode acceptEdits --allowedTools "Read Edit Write Bash" < prompt.txt`.
   Nunca inline (revienta por comillas en Windows). Consume cupo de suscripción: si
   sale "session limit", guarda estado y avisa.
5. **Solo (degradado)** — último recurso: haces tú cada papel en secuencia, releyendo
   la definición `equipo-*.md` de cada rol y encarnándola. Sin aislamiento real;
   decláralo en la entrega.

**Instrucción literal vs. disponibilidad real.** Si una herramienta de la escalera no
existe en tu sesión, no te bloquees ni finjas: baja al mecanismo disponible más alto y
decláralo. La intención (especialistas de plantilla en contexto aislado) manda sobre el
nombre de la herramienta.

## Regla de contexto limpio (operativa)

El prompt de contratación lleva SOLO:
- su slice del encargo + criterios de aceptación,
- los contratos de interfaz que debe respetar,
- rutas ABSOLUTAS y convenciones del proyecto.

**NO lleva el charter** (ya es su system prompt), ni tu razonamiento, ni historial, ni
trabajo de otros dominios más allá de los contratos. Cada dato ajeno que cuela ensucia
el contexto y baja la exactitud.

## Paralelo vs. secuencial: el grafo de dependencias

- **Independientes → en paralelo** (`parallel` de thunks, o fan-out de `agent()`).
- **Dependientes → en pipeline.** Si B necesita lo que produce A (el frontend necesita
  la forma de la API del backend), encadénalas con `pipeline()` — cada ítem fluye por
  sus etapas sin barrera global.
- **Barrera solo cuando necesitas todo junto:** integrar, deduplicar, decidir sobre el
  conjunto. Si no, no la pongas.
- **Contratos primero (la única barrera que siempre vale la pena).** Nadie implementa
  en paralelo hasta que `equipo-arquitecto` entrega los contratos.

## Aislamiento por worktree

Cuando varios especialistas **escriben ficheros a la vez** en el mismo repo git, usa
`isolation:'worktree'` en su `agent()`: cada uno trabaja sobre una copia aislada y el
integrador reconcilia. Si devuelven contenido (y escribes tú), trabajan en ficheros
disjuntos, o el proyecto no es un repo git, no aplica (cuesta ~200–500 ms + disco).

## Esqueleto de Workflow — encargo grande (fases 1→6)

Adapta este patrón. La clave: **contratos en barrera, implementación en paralelo o
pipeline, integración en barrera, revisión en paralelo por pieza — todo con
`agentType` de plantilla.**

```javascript
export const meta = {
  name: 'super-equipo-run',
  description: 'Contratos → implementación paralela → integración → revisión adversarial',
  phases: [
    { title: 'Arquitectura' }, { title: 'Implementación' },
    { title: 'Integración' }, { title: 'Revisión' },
  ],
}

// FASE 1-2: arquitecto de plantilla → diseño + contratos + roster (barrera intencionada)
phase('Arquitectura')
const plan = await agent(ENCARGO_Y_CONTEXTO, {
  agentType: 'equipo-arquitecto', label: 'arquitecto', schema: PLAN_SCHEMA,
})
// PLAN_SCHEMA: { areas:[{agente,slice,criterios,depende_de[]}], contratos:[{nombre,definicion}] }
// El campo `agente` lleva el nombre EXACTO del roster: normalmente un especialista
// ('equipo-backend-go'), y un lead ('equipo-backend') solo cuando el slice cruza
// varias tecnologias de su area o aun hay que elegir entre ellas.

// FASE 3: cada especialista implementa su slice contra los contratos, en contexto limpio
phase('Implementación')
const piezas = await parallel(plan.areas.map(a => () =>
  agent(promptContratacion(a, plan.contratos), {   // slice + contratos + rutas. NADA más.
    agentType: a.agente,                            // p. ej. 'equipo-backend-go'
    label: `impl:${a.agente}`, phase: 'Implementación',
    isolation: 'worktree',                          // solo si escriben a la vez en un repo git
    schema: PIEZA_SCHEMA,
  })
)).then(r => r.filter(Boolean))

// FASE 4: integrador de plantilla (barrera: necesita todas las piezas)
phase('Integración')
const integracion = await agent(promptIntegracion(piezas, plan.contratos), {
  agentType: 'equipo-integrador', label: 'integrador', schema: INTEGRACION_SCHEMA,
})

// FASE 5: revisor adversarial por pieza y por sabor; nunca revisa quien implementó
phase('Revisión')
const SABORES = ['correccion', 'seguridad']   // + 'rendimiento'/'accesibilidad'/'codigo' segun la pieza
const revisiones = await parallel(plan.areas.flatMap(a => SABORES.map(s => () =>
  agent(promptRevision(a, integracion, s), {
    agentType: `equipo-revisor-${s}`, label: `review:${s}:${a.agente}`,
    phase: 'Revisión', schema: VEREDICTO_SCHEMA,
  })
))).then(r => r.filter(Boolean))

return { plan, integracion, revisiones }
```

Tras el Workflow, el Director (tú) lee `revisiones`: los hallazgos reales vuelven al
especialista dueño (otra contratación `agentType` para esa pieza) y se re-revisan
hasta verde. No cierres con hallazgos abiertos.

## Esqueleto ligero — equipo pequeño (sin Workflow)

Para 2–4 especialistas, llamadas `Agent` en el mismo mensaje (paralelas). Tú haces de
arquitecto (contratos en un párrafo) y de integrador:

```
1) Defines los contratos de interfaz (tú, breve).
2) Bajas cada slice a tecnología concreta y buscas su nombre exacto en roster.md.
3) Un Agent por especialista, MISMO mensaje: subagent_type='equipo-<area>-<slug>',
   prompt = slice + contratos + rutas.
4) Integras sus entregas y lo ejecutas de verdad.
5) Agent con subagent_type='equipo-revisor-correccion' (y '-seguridad' si hay dinero,
   datos personales o auth de por medio) audita; corriges lo que saque.
```

## Revisión e integración: lo que te toca a ti (Director)

El CÓMO revisa el revisor y el CÓMO integra el integrador viven en sus propias
definiciones (`equipo-revisor.md`, `equipo-integrador.md`). Lo que es tuyo:

- **Independencia:** jamás mandes a revisar una pieza a quien la implementó, y no
  dejes que el integrador "arregle por cortesía" violaciones de contrato — son
  hallazgos para su dueño.
- **Evidencia sobre afirmación:** el autoinforme de un especialista es una pista, no
  evidencia. La entrega se sostiene sobre lo que el integrador (y tú) visteis correr.
- **El bucle de hallazgos:** hallazgo → dueño lo corrige → re-revisión. Hasta verde.

## Presupuesto y escalado

Si el usuario fijó un objetivo de tokens (directiva "+Nk"), escala con `budget` el número
de contrataciones y revisores. Sin objetivo, dimensiona por el encargo, no por
inercia. Registra en la entrega cualquier cobertura acotada — nunca la recortes en
silencio.

## Errores de orquestación que hay que evitar

- **Especialista genérico** — un subagente sin `agentType`/`subagent_type` de plantilla
  haciendo trabajo de especialista. Es EL error que esta skill existe para impedir.
- **Pegar el charter en el prompt** — duplica identidad, ensucia contexto y desincroniza
  con la definición permanente.
- **Implementar en paralelo sin contratos** → piezas incompatibles.
- **Barreras innecesarias** → agentes rápidos esperando al lento sin motivo.
- **Ensuciar el contexto del especialista** con material de otros dominios.
- **Que revise quien implementó** → aprobación por cortesía, calidad falsa.
- **Sobre-staffing** de un encargo pequeño → lento y caro sin ganancia.
- **Marcar hecho sin ejecutar** → se ejecuta y se ve, o se declara NO verificado.
