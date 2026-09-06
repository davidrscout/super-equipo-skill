# super-equipo — una empresa de ingeniería dentro de Claude Code

Skill de [Claude Code](https://claude.com/claude-code) que monta un **equipo profesional completo
de especialistas**, cada uno con **contexto limpio y aislado**, orquestados como una empresa real:

1. el **arquitecto** fija los contratos de interfaz,
2. los **leads de área** implementan su parte en paralelo,
3. un **revisor adversarial** audita lo que no escribió,
4. un **integrador** lo une y re-ejecuta todo hasta verlo correr de verdad.

No es un prompt improvisado por encargo: el roster **existe como plantilla fija**. Son
**24 agentes permanentes** de Claude Code, cada uno con su charter completo (experiencia, método,
checklist de excelencia, verificación obligatoria, trampas y deslinde de solapes) cargado de serie
como system prompt.

## Por qué

- **Especialización real.** Quien toca tu API de pagos "lleva 15 años" cerrando race conditions
  y verifica firmas de webhook por reflejo. No hay que explicárselo cada vez.
- **Aislamiento de contexto.** Cada especialista arranca fresco, sin arrastrar el hilo del
  orquestador ni el razonamiento de otros dominios. Un contexto limpio piensa mejor.
- **Cobertura total.** 24 miembros fijos + auto-extensión: si el encargo toca un área nueva,
  se ficha un miembro **permanente** siguiendo la plantilla, no se improvisa.

## El roster

**Transversales de proceso**

| Rol | Agente |
|---|---|
| Arquitecto jefe / Tech Lead (diseño + contratos + grafo de deps) | `equipo-arquitecto` |
| Integrador (une, re-ejecuta todo, no se fía de autoinformes) | `equipo-integrador` |
| Revisor adversarial (solo lee y ejecuta; busca fallos, no aprueba) | `equipo-revisor` |

**Leads de área**

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

Cada lead cubre a sus subingenieros (backend → Python/Node-TS/Go/Rust/Java…), definidos dentro de
su propio charter. Si dos sub-áreas deben ir en paralelo, se contrata al mismo lead dos veces con
slices distintos.

## Instalación

```bash
git clone https://github.com/davidrscout/super-equipo-skill.git
cd super-equipo-skill
```

**Linux / macOS**

```bash
./install.sh
```

**Windows**

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
```

Copia `skills/super-equipo/` a `~/.claude/skills/` y los 24 `agents/equipo-*.md` a `~/.claude/agents/`.
Ambas cosas son **necesarias**: sin los agentes, la skill no tiene equipo al que contratar.

Reinicia Claude Code. Comprueba con `/skills` que aparece `super-equipo` y con `/agents` que están
los `equipo-*`.

## Uso

```
/super-equipo monta el backend de reservas con panel de admin y despliegue en VPS
```

O sin nombrarla — la skill se dispara sola ante encargos multi-dominio:

```
Necesito una web full-stack con pagos, panel y despliegue. Que lo hagan expertos de cada área.
```

### Escala el equipo al encargo

El sobre-staffing es un antipatrón. Ante la duda, el equipo menor:

| Tamaño del encargo | Equipo |
|---|---|
| Trivial (1 fichero, cambio mecánico) | **Ninguno.** Que lo haga Claude directamente. |
| Pequeño (1 área, acotado) | 1–2 especialistas + `equipo-revisor` |
| Mediano (2–3 áreas) | Contratos breves + leads + revisor |
| Grande / multi-dominio | Organización completa vía `Workflow`, fases 1→6 |

## Estructura del repo

```
skills/super-equipo/
  SKILL.md                      # el orquestador: reglas, roster, fases, deslindes
  references/
    organigrama.md              # roles y cadena de mando
    orquestacion.md             # esqueletos de Workflow, paralelo vs pipeline, presupuesto
    plantilla-agente.md         # estructura obligatoria para fichar un miembro nuevo
agents/
  equipo-*.md                   # los 24 charters permanentes
```

## Notas

- **Contenido en castellano.** Los charters están escritos en español; funcionan igual sobre
  bases de código en cualquier idioma, pero el razonamiento y los informes salen en castellano.
- Los charters mencionan un stack de referencia (Flask/gunicorn/nginx sobre VPS Linux, Shopify,
  bots de Telegram, Stripe/NOWPayments) como contexto concreto de ejemplo. Adáptalos a tu stack
  editando la sección de contexto de cada agente.
- `SKILL.md` menciona una integración opcional con una skill `/perfeccionista` (loop de calidad
  con nota). No está incluida aquí y la skill funciona perfectamente sin ella.
- **Coste**: un encargo grande lanza muchos subagentes en paralelo. Consume tokens en serio.
  Usa la tabla de escalado.

## Licencia

MIT — ver [LICENSE](LICENSE).
