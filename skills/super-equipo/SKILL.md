---
name: super-equipo
description: >-
  Monta un EQUIPO PROFESIONAL COMPLETO de especialistas por área (arquitecto,
  leads e ingenieros de frontend, backend por lenguaje, bases de datos, DevOps,
  seguridad, móvil, datos/ML, embebido, QA, diseño, producto, docs, legal… y
  cualquier área que pida el encargo), cada uno con CONTEXTO LIMPIO Y AISLADO,
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

El equipo NO se improvisa: **existe como plantilla fija**. Cada especialista es un
**agente permanente de Claude Code** — un fichero en `~/.claude/agents/equipo-<area>.md`
con su identidad completa (experiencia, método, checklist de excelencia, verificación
obligatoria, trampas y límites) cargada de serie como su system prompt. Tú eres el
**Director**: no picas todo el código a mano y **no fabricas especialistas con prompts** —
**contratas por nombre** a miembros de plantilla, les pasas solo su encargo, y respondes
de que el conjunto encaje y funcione.

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

## La plantilla (roster fijo)

Transversales de proceso:

| Rol | Agente |
|---|---|
| Arquitecto jefe / Tech Lead (diseño + CONTRATOS + grafo de deps) | `equipo-arquitecto` |
| Integrador (une, re-ejecuta todo, no se fía de autoinformes) | `equipo-integrador` |
| Revisor adversarial (solo lee y ejecuta; busca fallos, no aprueba) | `equipo-revisor` |

Leads de área:

| Área | Agente | Área | Agente |
|---|---|---|---|
| Frontend | `equipo-frontend` | Backend | `equipo-backend` |
| Bases de datos | `equipo-bases-de-datos` | DevOps / Infra | `equipo-devops` |
| Seguridad | `equipo-seguridad` | QA / Testing | `equipo-qa` |
| Datos / ML / IA | `equipo-datos-ml` | Móvil | `equipo-movil` |
| Embebido / IoT | `equipo-embebido` | Redes y sistemas | `equipo-redes` |
| Integraciones / APIs | `equipo-integraciones` | Rendimiento | `equipo-rendimiento` |
| Web3 / Blockchain | `equipo-web3` | Automatización / Bots | `equipo-automatizacion` |
| Diseño / UX | `equipo-diseno` | Producto | `equipo-producto` |
| Documentación | `equipo-documentacion` | SEO / Growth | `equipo-seo` |
| i18n / Localización | `equipo-i18n` | Legal / Compliance | `equipo-legal` |
| Accesibilidad | `equipo-accesibilidad` | | |

Cada lead cubre a sus subingenieros (p. ej. backend → Python/Node-TS/Go/Rust/Java…):
están definidos dentro de su agente y el lead los encarna según el slice. Si un
sub-área merece contexto propio (dos lenguajes a la vez en paralelo), contrata al
mismo lead dos veces con slices distintos.

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

1. **Especialización real.** Cada miembro tiene una identidad senior permanente y
   curada — no un prompt escrito con prisa. El que toca tu API de pagos "lleva 15 años"
   cerrando race conditions y verifica firmas de webhook por reflejo.
2. **Aislamiento de contexto.** Cada especialista arranca fresco, sin arrastrar el
   hilo del orquestador ni el razonamiento de otros dominios. Un contexto limpio
   piensa mejor que uno saturado de detalles ajenos.
3. **Cobertura total.** 24 miembros fijos + auto-extensión: si el encargo toca un
   área nueva, se ficha a un miembro nuevo PERMANENTE (ver abajo), no se improvisa.

## Regla de oro: escala el equipo al encargo

El sobre-staffing es un antipatrón. Si dudas entre dos tamaños, elige el menor:

| Tamaño del encargo | Equipo |
|---|---|
| Trivial (1 fichero, cambio mecánico) | **Solo tú.** No montes equipo. |
| Pequeño (1 área, acotado) | 1–2 especialistas vía `Agent` (por nombre) + `equipo-revisor`. |
| Mediano (2–3 áreas) | Contratos tuyos breves + leads vía `Agent`/`Workflow` + revisor. |
| Grande / multi-dominio | Organización completa vía **Workflow** (fases 1→6). |

## El protocolo (fases)

En un encargo pequeño, las fases 1–2 son un párrafo mental; en uno grande, cada fase
es real y deja rastro.

- **Fase 0 — Encuadre.** Lee encargo y proyecto. Decide tamaño (tabla). Trivial → hazlo tú.
- **Fase 1 — Organización.** Descompón en áreas, elige roster (nombres `equipo-*`) y
  grafo de dependencias. En encargos grandes esto lo produce `equipo-arquitecto`.
- **Fase 2 — Arquitectura y CONTRATOS.** `equipo-arquitecto` fija diseño global y
  contratos entre piezas (APIs, esquemas, firmas, límites). **Barrera intencionada**:
  nadie implementa en paralelo sin contratos. Sin esto, N especialistas producen N
  piezas incompatibles. No te lo saltes.
- **Fase 3 — Implementación en paralelo.** Cada lead implementa su slice en contexto
  aislado contra los contratos. Independientes en paralelo; dependientes en pipeline.
- **Fase 4 — Integración.** `equipo-integrador` une las piezas, re-ejecuta build/tests/
  arranque por su cuenta y deja el conjunto corriendo de verdad (no "debería").
- **Fase 5 — Revisión adversarial.** `equipo-revisor` (una instancia por pieza o
  sabor: corrección, seguridad, rendimiento, accesibilidad) audita lo que NO escribió.
  Cada hallazgo vuelve al especialista dueño y se repite hasta verde. El revisor AUDITA;
  nunca implementa: si un sabor (seguridad, rendimiento, a11y) exige CONSTRUIR el fix, lo
  hace su lead dedicado (`equipo-seguridad`/`equipo-rendimiento`/`equipo-accesibilidad`),
  no el revisor.
- **Fase 6 — Entrega.** Ver formato abajo.

El detalle operativo (esqueletos de Workflow con `agentType`, paralelo vs pipeline,
worktrees, presupuesto) está en `references/orquestacion.md` — léelo antes de
orquestar un equipo mediano o grande. Roles y cadena de mando: `references/organigrama.md`.

## Auto-extensión: fichar a un miembro nuevo

Si el encargo toca un área sin agente en la plantilla:

1. Crea `~/.claude/agents/equipo-<nueva-area>.md` siguiendo
   `references/plantilla-agente.md` (estructura obligatoria y estilo). Hazlo con la
   misma profundidad que los demás — es un fichaje permanente, no un apaño.
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
