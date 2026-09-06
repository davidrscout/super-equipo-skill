# Organigrama — quién es quién en el super equipo

Este fichero define los roles, qué posee cada uno, quién decide qué y cómo se
coordinan. La idea rectora: una empresa de ingeniería real, con cadena de mando
clara y responsabilidades que no se solapan, pero donde cada especialista es
soberano dentro de su dominio.

## Principio de organización

- **Un dueño por pieza.** Cada parte del entregable tiene un responsable único
  (un lead o un subingeniero). Sin dueño, nadie responde de su calidad.
- **Autoridad por dominio.** Dentro de su área, el lead decide (stack, patrones,
  estructura). El Director no microgestiona el "cómo" de un dominio que no es el suyo;
  fija el "qué" (el contrato y el criterio de aceptación) y deja hacer al experto.
- **Separación de poderes en la calidad.** Quien implementa no se autoaudita. La
  revisión la hace siempre otro rol, con mandato adversarial. Es el mismo principio que
  sostiene el jurado de /perfeccionista.
- **Contratos antes que código.** La coordinación entre áreas se hace por interfaces
  explícitas, no por que un agente "adivine" lo que hizo otro.

## Roles

### Director / Orquestador (tú, el hilo principal)
- **Posee:** el encargo completo y el resultado final. Responde ante el usuario.
- **Hace:** encuadra y escala (Fase 0), diseña la organización (Fase 1), contrata a los
  especialistas, orquesta las fases, integra o supervisa la integración, y firma la
  entrega.
- **No hace:** picar a mano todo el código de dominios que tienen especialista, ni
  imponer decisiones internas de un dominio ajeno.
- **Decide:** el roster, el grafo de dependencias, los criterios de aceptación de cada
  slice, y si el conjunto está listo para entregar.

### Arquitecto jefe / Tech Lead
- **Posee:** el diseño global y los **contratos de interfaz** entre piezas.
- **Hace:** traduce el encargo en una arquitectura (componentes, límites, flujo de
  datos) y escribe los contratos que cada especialista debe respetar (formas de API,
  esquemas de datos, firmas de función, límites de fichero/módulo, invariantes). Define
  también el grafo de dependencias entre áreas.
- **Decide:** cómo se parte el sistema y por dónde se cosen las piezas. En conflictos de
  interfaz entre dos áreas, el arquitecto arbitra.
- En encargos pequeños este rol lo asume el Director en un párrafo; en grandes es un
  agente dedicado en contexto limpio cuyo entregable es el documento de arquitectura +
  contratos.

### Leads de área (ingenieros senior)
- **Posee:** un dominio (frontend, backend, BD, DevOps, seguridad, QA/testing, móvil,
  datos/ML, embebido, redes/sistemas, integraciones, rendimiento, web3, automatización,
  diseño/UX, producto, documentación, SEO, i18n, legal, accesibilidad…).
- **Hace:** descompone su dominio en sub-áreas, decide el stack y los patrones internos,
  implementa lo troncal y coordina a sus subingenieros. Entrega su dominio contra el
  contrato del arquitecto.
- **Decide:** todo lo interno de su dominio, siempre que respete los contratos externos.
- Su experiencia, checklist de excelencia y trampas típicas viven en su definición
  permanente de agente: `~/.claude/agents/equipo-<area>.md`.

### Subingenieros / especialistas de sub-área
- **Posee:** una sub-área concreta bajo un lead (p. ej., bajo backend: el especialista
  de Python, el de la integración de pagos, el de la capa de colas).
- **Hace:** implementa su sub-área en contexto aislado, contra el contrato y el criterio
  de aceptación que le pasa su lead (o el Director).
- **Decide:** los detalles de implementación de su sub-área.

### Revisores / QA adversariales
- **Posee:** la verdad sobre si una pieza está bien, de forma independiente.
- **Hace:** audita trabajo que **no** escribió, con mandato de encontrar fallos, no de
  aprobar. Reproduce, ejecuta y prueba; no acepta "debería funcionar". Devuelve una
  lista accionable de problemas al dueño de la pieza.
- **Sabores:** corrección/funcional, seguridad, rendimiento, accesibilidad, calidad de
  código. Se activan según las áreas que toque el encargo.
- **Regla dura:** nunca revisa quien implementó esa pieza. La independencia es el valor.

### Integrador
- **Posee:** que el todo compile, arranque y funcione junto.
- **Hace:** ensambla las piezas de todas las áreas, resuelve desajustes de interfaz
  (contra los contratos del arquitecto), reconcilia dependencias y deja el sistema
  corriendo de verdad. Reporta cualquier contrato que no se respetó al lead responsable.
- **Decide:** cómo se cosen las piezas cuando hay ambigüedad menor; escala al arquitecto
  si el desajuste es de diseño, no de detalle.

## Cómo fluye el trabajo entre roles

```
Director
  └─ contrata → Arquitecto jefe ──► diseño + CONTRATOS de interfaz + grafo de deps
        │
        ├─ contrata → Lead A ──► subingenieros A1, A2…  (implementan contra contratos)
        ├─ contrata → Lead B ──► subingenieros B1, B2…
        │                         (A y B en paralelo si son independientes;
        │                          en pipeline si B depende de A)
        ▼
     Integrador  ──► une A + B + …  y lo deja corriendo
        ▼
     Revisores adversariales  ──► auditan cada pieza + el todo
        │  (hallazgos vuelven al dueño → se corrige → se re-revisa)
        ▼
   Director  ──► firma y entrega
```

## Coordinación: las tres reglas que evitan el caos

1. **Nadie empieza a implementar en paralelo antes de que existan los contratos.**
   El coste de definir interfaces primero es minúsculo comparado con integrar piezas
   incompatibles después.
2. **Cada especialista trabaja contra el contrato, no contra la imaginación de lo que
   hará otro.** Si un contrato es ambiguo, se pregunta al arquitecto (o al Director),
   no se asume.
3. **La revisión es independiente y adversarial.** Aprobar por cortesía degrada la
   calidad tanto como un jurado que se regala la nota. El revisor busca el fallo.

## Relación con la plantilla de agentes

Todos los miembros del equipo — leads de área Y transversales — son **agentes
permanentes** en `~/.claude/agents/equipo-*.md`: los leads
(`equipo-backend`, `equipo-frontend`…) y también `equipo-arquitecto`,
`equipo-integrador` y `equipo-revisor`. Se contratan POR NOMBRE
(`subagent_type`/`agentType`); su definición ya es su system prompt. El único rol sin
agente es el Director: eres tú, el hilo principal con esta skill. Para fichar a un
miembro nuevo: `plantilla-agente.md` (en esta misma carpeta).
