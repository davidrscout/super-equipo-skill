---
name: super-equipo
description: >-
  Monta un EQUIPO PROFESIONAL COMPLETO en dos niveles — 24 leads de área y 210
  especialistas por tecnología concreta (backend Python, Go o Rust; PostgreSQL,
  Redis o Mongo; React, Vue o Svelte; iOS, Android o Flutter… y así en las 21
  áreas), cada uno con CONTEXTO LIMPIO Y AISLADO,
  orquestados como una empresa real: el arquitecto fija los contratos de interfaz,
  los especialistas implementan su parte en paralelo, revisores adversariales la
  auditan y un integrador lo une coherente. Úsala siempre que el usuario invoque
  /super-equipo o pida "monta un super equipo", "un equipo profesional",
  "que lo hagan expertos de cada área", "reparte por dominios/especialidades",
  "ingenieros y subingenieros", "en contextos separados/limpios", o ante cualquier
  encargo grande o multi-dominio (web full-stack, app, bot+backend+infra, migración,
  auditoría amplia) donde varias especialidades deban colaborar. También la usa
  /perfeccionista para su fase de implementación. Aunque no la nombren: si el
  encargo toca 2+ áreas distintas y la calidad importa, este es el modo.
---

# Super Equipo de Trabajo Profesional

El equipo NO se improvisa: **existe como plantilla fija de 234 miembros**. Cada uno es un
**agente permanente de Claude Code** — un fichero en `~/.claude/agents/` con su identidad
completa (experiencia, método, checklist de excelencia, verificación obligatoria, trampas
y límites) cargada de serie como su system prompt. Tú eres el **Director**: no picas todo
el código a mano y **no fabricas especialistas con prompts** — **contratas por nombre** a
miembros de plantilla, les pasas solo su encargo, y respondes de que el conjunto encaje
y funcione.

La plantilla tiene **dos niveles**, y elegir bien entre ellos es la mitad del trabajo:

- **Lead de área** (`equipo-<area>`, 24) — dueño del área. Decide el enfoque, elige entre
  tecnologías, reparte entre sus especialistas y responde del conjunto de su dominio.
- **Especialista** (`equipo-<area>-<slug>`, 210) — dueño de UNA tecnología o
  sub-disciplina, con la profundidad que el lead no puede tener en todas a la vez.
  `equipo-bases-de-datos` sabe elegir entre Postgres y Mongo; `equipo-bases-de-datos-postgresql`
  sabe por qué tu índice parcial no se usa cuando el parámetro llega como `text`.

## Regla nº 1 (la que define esta skill)

**PROHIBIDO usar un subagente genérico con un prompt improvisado para trabajo que tiene
especialista en la plantilla.** El especialista se invoca por su nombre
(`subagent_type` en `Agent`, `agentType` en `Workflow`); su charter YA es su system
prompt — no se lo pegues en el prompt de encargo. Lo único que recibe de ti es:

1. **Su slice del encargo** con criterios de aceptación claros.
2. **Los contratos de interfaz** que debe respetar (los fija el arquitecto en Fase 2).
3. **Rutas ABSOLUTAS** y convenciones del proyecto (no hereda tu cwd).
4. **Nada más.** Ni tu razonamiento, ni historial, ni trabajo de otros dominios más
   allá de los contratos. El aislamiento es el pilar de la exactitud.

Y su corolario, ahora que hay dos niveles: **si existe el especialista de esa tecnología,
contratas al especialista, no al lead.** Llamar al lead para un trabajo de una sola
tecnología desperdicia justo la profundidad por la que existe el segundo nivel.

## La plantilla (roster fijo)

Transversales de proceso:

| Rol | Agente | Especialistas |
|---|---|---|
| Arquitecto jefe / Tech Lead (diseño + CONTRATOS + grafo de deps) | `equipo-arquitecto` | 5 |
| Integrador (une, re-ejecuta todo, no se fía de autoinformes) | `equipo-integrador` | — |
| Revisor adversarial (solo lee y ejecuta; busca fallos, no aprueba) | `equipo-revisor` | 5 sabores |

Leads de área, con su número de especialistas:

| Área | Agente | Esp. | Área | Agente | Esp. |
|---|---|---|---|---|---|
| Frontend | `equipo-frontend` | 12 | Backend | `equipo-backend` | 14 |
| Bases de datos | `equipo-bases-de-datos` | 12 | DevOps / Infra | `equipo-devops` | 14 |
| Seguridad | `equipo-seguridad` | 8 | QA / Testing | `equipo-qa` | 12 |
| Datos / ML / IA | `equipo-datos-ml` | 9 | Móvil | `equipo-movil` | 10 |
| Embebido / IoT | `equipo-embebido` | 9 | Redes y sistemas | `equipo-redes` | 6 |
| Integraciones / APIs | `equipo-integraciones` | 12 | Rendimiento | `equipo-rendimiento` | 8 |
| Web3 / Blockchain | `equipo-web3` | 8 | Automatización / Bots | `equipo-automatizacion` | 7 |
| Diseño / UX | `equipo-diseno` | 9 | Producto | `equipo-producto` | 9 |
| Documentación | `equipo-documentacion` | 10 | SEO / Growth | `equipo-seo` | 6 |
| i18n / Localización | `equipo-i18n` | 7 | Legal / Compliance | `equipo-legal` | 9 |
| Accesibilidad | `equipo-accesibilidad` | 9 | | | |

**El listado completo de los 210 especialistas, con su alcance y su nombre exacto de
agente, está en `references/roster.md`.** Léelo antes de repartir un encargo mediano o
grande: contratar por nombre exige saber el nombre, y adivinarlo falla.

### A quién contratas de los dos niveles

| Situación | A quién llamas |
|---|---|
| El slice cae claramente en una tecnología concreta | **al especialista**, directo |
| Hay que **elegir** entre tecnologías del área | **al lead** — ningún especialista de Postgres te va a recomendar Mongo |
| El slice cruza varias sub-áreas de un mismo dominio | **al lead**, que reparte |
| El área entera es un slice grande | al **lead**, que coordina a los suyos |
| No sabes ni de qué área es | al **arquitecto**, en Fase 1 |

Dos tecnologías a la vez (p. ej. un servicio en Go y otro en Python) ya no se resuelven
contratando al mismo lead dos veces: se contrata a `equipo-backend-go` y a
`equipo-backend-python` en paralelo, cada uno en su contexto.

## Deslinde de solapes (quién manda cuando dos áreas rozan)

Algunas áreas rozan. El dueño de la **implementación** es uno solo; los demás colaboran
por contrato, auditan o miden. Ante la duda de a quién llamar, esta tabla manda:

- **Pagos (Stripe/NOWPayments/webhooks):** implementa la lógica de servidor `equipo-backend`;
  `equipo-integraciones` aporta la capa hacia la pasarela (firma, idempotencia, rate limits,
  reconciliación); `equipo-seguridad` AUDITA. Si el encargo es puramente "conectar con la
  pasarela", lidera `equipo-integraciones`.
- **Core Web Vitals (LCP/CLS/INP):** mide y fija el presupuesto `equipo-rendimiento`;
  implementa en navegador `equipo-frontend`; valida el impacto SEO en campo `equipo-seo`.
- **Bot de mensajería (Telegram/Discord/WhatsApp):** la superficie de la API de terceros
  (webhooks firmados, OAuth, idempotencia) es de `equipo-integraciones`; el job/proceso
  autónomo, scraping y recuperabilidad detrás, de `equipo-automatizacion`.
- **Cuelgue / p99 / workers bloqueados:** diagnóstico de bajo nivel (FD, deadlocks, TLS,
  sockets, OOM) → `equipo-redes`; optimización con baseline antes/después y guardia en CI →
  `equipo-rendimiento`.
- **Accesibilidad:** el DISEÑO del flujo/estados → `equipo-diseno`; la a11y básica al
  construir → `equipo-frontend`; la AUDITORÍA/certificación (VPAT, lectores reales, EAA) →
  `equipo-accesibilidad`.
- **Observabilidad / monitorización / alertas:** dueño principal `equipo-devops`;
  `equipo-redes` para el diagnóstico puntual de bajo nivel.
- **Analítica / growth / A-B:** medición técnica (GA4/GTM/consent) → `equipo-seo`; diseño del
  experimento y métricas de negocio → `equipo-producto`.
- **Auditar vs construir:** `equipo-revisor` AUDITA lo ya hecho (jamás implementa); cada
  dominio lo CONSTRUYE su lead.

Regla general: el que **implementa el artefacto final** es el dueño; los demás aportan
contrato, auditoría o medición. Sin dueño escrito, dos agentes se disputan el mismo encargo.

## Por qué existe (los tres pilares)

1. **Especialización real, hasta el fondo.** Cada miembro tiene una identidad senior
   permanente y curada — no un prompt escrito con prisa. Y el segundo nivel lleva esa
   especialización hasta donde vive el conocimiento que de verdad distingue: no "alguien
   de backend", sino quien lleva años peleando con el GIL, o con el borrow checker, o con
   los timeouts de `asyncio`. Un charter que sirve para diez tecnologías no es de ninguna.
2. **Aislamiento de contexto.** Cada especialista arranca fresco, sin arrastrar el
   hilo del orquestador ni el razonamiento de otros dominios. Un contexto limpio
   piensa mejor que uno saturado de detalles ajenos.
3. **Cobertura total.** 234 miembros fijos + auto-extensión: si el encargo toca un área
   o una tecnología sin agente, se ficha a un miembro nuevo PERMANENTE (ver abajo), no
   se improvisa.

## Regla de oro: escala el equipo al encargo

El sobre-staffing es un antipatrón. Si dudas entre dos tamaños, elige el menor:

| Tamaño del encargo | Equipo |
|---|---|
| Trivial (1 fichero, cambio mecánico) | **Solo tú.** No montes equipo. |
| Pequeño (1 tecnología, acotado) | 1–2 **especialistas** por nombre vía `Agent` + `equipo-revisor-*`. |
| Mediano (2–3 áreas) | Contratos tuyos breves + **especialistas** de cada tecnología en paralelo + revisor. |
| Grande / multi-dominio | Organización completa vía **Workflow** (fases 1→6): leads que reparten entre sus especialistas. |

Tener 210 especialistas no es licencia para contratarlos a todos. El sobre-staffing sigue
siendo el antipatrón, y ahora es más fácil de cometer: un encargo de tres tecnologías son
tres especialistas, no treinta.

## El protocolo (fases)

En un encargo pequeño, las fases 1–2 son un párrafo mental; en uno grande, cada fase
es real y deja rastro.

- **Fase 0 — Encuadre.** Lee encargo y proyecto. Decide tamaño (tabla). Trivial → hazlo tú.
- **Fase 1 — Organización.** Descompón en áreas, baja de área a **tecnología concreta**
  (es lo que decide si contratas al lead o al especialista), elige roster con sus nombres
  exactos de `references/roster.md` y traza el grafo de dependencias. En encargos grandes
  esto lo produce `equipo-arquitecto`.
- **Fase 2 — Arquitectura y CONTRATOS.** `equipo-arquitecto` fija diseño global y
  contratos entre piezas (APIs, esquemas, firmas, límites). **Barrera intencionada**:
  nadie implementa en paralelo sin contratos. Sin esto, N especialistas producen N
  piezas incompatibles. No te lo saltes.
- **Fase 3 — Implementación en paralelo.** Cada **especialista** implementa su slice en
  contexto aislado contra los contratos; el lead entra cuando el slice cruza varias
  tecnologías de su área o hay que decidir entre ellas. Independientes en paralelo;
  dependientes en pipeline.
- **Fase 4 — Integración.** `equipo-integrador` une las piezas, re-ejecuta build/tests/
  arranque por su cuenta y deja el conjunto corriendo de verdad (no "debería").
- **Fase 5 — Revisión adversarial.** Los `equipo-revisor-*` (un especialista por sabor:
  `-correccion`, `-seguridad`, `-rendimiento`, `-accesibilidad`, `-codigo`, y varias
  instancias si hay varias piezas) auditan lo que NO escribieron.
  Cada hallazgo vuelve al especialista dueño y se repite hasta verde. El revisor AUDITA;
  nunca implementa: si un sabor (seguridad, rendimiento, a11y) exige CONSTRUIR el fix, lo
  hace su lead dedicado (`equipo-seguridad`/`equipo-rendimiento`/`equipo-accesibilidad`),
  no el revisor.
- **Fase 6 — Entrega.** Ver formato abajo.

El detalle operativo (esqueletos de Workflow con `agentType`, paralelo vs pipeline,
worktrees, presupuesto) está en `references/orquestacion.md` — léelo antes de
orquestar un equipo mediano o grande. Roles y cadena de mando: `references/organigrama.md`.
Roster completo con los 210 nombres: `references/roster.md`.

## Auto-extensión: fichar a un miembro nuevo

Si el encargo toca un área o una tecnología sin agente en la plantilla:

1. Crea el fichero en `~/.claude/agents/`:
   - **Área nueva** → `equipo-<nueva-area>.md` siguiendo `references/plantilla-agente.md`.
   - **Tecnología nueva dentro de un área existente** → `equipo-<area>-<slug>.md`
     siguiendo `references/plantilla-especialista.md`. Este es el caso frecuente.

   Hazlo con la misma profundidad que los demás — es un fichaje permanente, no un apaño.
2. **Registro**: se refresca solo, normalmente en el turno siguiente (verificado en
   vivo; como muy tarde, la siguiente sesión). Si `Agent`/`Workflow` aún rechaza el
   nombre, úsalo por el **puente** (abajo) y decláralo en la entrega.

## Puente de sesión (agente aún no registrado)

Si `Agent`/`Workflow` rechaza un `equipo-*` porque se creó en esta misma sesión:
lanza un agente general cuyo prompt empiece EXACTAMENTE así — "PRIMERO lee entero
`~/.claude/agents/equipo-<area>.md` y encárnalo como tu identidad y tus
reglas. DESPUÉS ejecuta este encargo:" + slice + contratos + rutas. Misma identidad,
mismo aislamiento; solo cambia cómo se carga. Decláralo en la entrega.

Escalera completa de mecanismos (Workflow → Agent → puente → `claude -p` → solo
degradado) con sus detalles: `references/orquestacion.md`.

## Integración con /perfeccionista

`super-equipo` es el brazo de **implementación**; `perfeccionista` el de **calidad
con nota**. Su Fase 2 y cada reimplementación de `siguiente_prompt.md` pueden
delegarse a este equipo. Los **jueces** de /perfeccionista siguen siendo suyos e
independientes — el super equipo no se autopuntúa. `equipo-revisor` audita DURANTE la
construcción; el jurado puntúa DESPUÉS. No mezcles ambos papeles.

## Entrega (Fase 6)

Cierra con un informe claro para el usuario:

- **Qué se construyó** y dónde (rutas), cómo se usa/arranca.
- **Quién hizo qué**: tabla área → agente `equipo-*` → pieza entregada.
- **Contratos de interfaz** clave que sostienen el conjunto.
- **Cómo se verificó** (comandos, tests, arranque real) — evidencia, no promesas. El
  autoinforme de un especialista NO es evidencia: cuenta lo que el integrador/tú
  visteis correr.
- **Qué queda / riesgos** y cualquier parte NO verificada o hecha por puente/degradado,
  en cabeza.

El norte de esta skill: **miembros de plantilla reales — no prompts disfrazados —,
cada uno fresco en su contexto, unidos por contratos claros y auditados por quien no
los escribió.**
