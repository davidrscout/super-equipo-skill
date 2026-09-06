# super-equipo — una empresa de ingeniería dentro de Claude Code

Skill de [Claude Code](https://claude.com/claude-code) que monta un **equipo profesional completo
de especialistas**, cada uno con **contexto limpio y aislado**, orquestados como una empresa real:

1. el **arquitecto** fija los contratos de interfaz,
2. los **leads de área** implementan su parte en paralelo,
3. un **revisor adversarial** audita lo que no escribió,
4. un **integrador** lo une y re-ejecuta todo hasta verlo correr de verdad.

No es un prompt improvisado por encargo: el roster **existe como plantilla fija de 234
agentes permanentes** de Claude Code, cada uno con su charter completo (experiencia, método,
checklist de excelencia, verificación obligatoria, trampas y deslinde de solapes) cargado de serie
como system prompt.

## Dos niveles

| Nivel | Nombre | Cuántos | Qué es |
|---|---|---|---|
| Lead de área | `equipo-<area>` | 24 | Dueño del área: elige entre tecnologías, reparte y responde del conjunto |
| Especialista | `equipo-<area>-<slug>` | 210 | Dueño de UNA tecnología, con el fondo que el lead no puede tener en todas |

La diferencia no es de rango, es de profundidad. `equipo-bases-de-datos` sabe elegir entre
Postgres y Mongo. `equipo-bases-de-datos-postgresql` sabe por qué tu índice parcial no se usa
cuando el parámetro llega como `text` en vez de `varchar`.

Así que se contrata al **especialista** cuando el trabajo es de una tecnología concreta, y al
**lead** cuando aún hay que decidir cuál — ningún especialista de Postgres te va a recomendar
Mongo.

## Por qué

- **Especialización real, hasta el fondo.** No "alguien de backend", sino quien lleva años
  peleando con el GIL, o con el borrow checker, o con los timeouts de `asyncio`. Un charter que
  sirve para diez tecnologías no es de ninguna.
- **Aislamiento de contexto.** Cada especialista arranca fresco, sin arrastrar el hilo del
  orquestador ni el razonamiento de otros dominios. Un contexto limpio piensa mejor.
- **Cobertura total.** 234 miembros fijos + auto-extensión: si el encargo toca un área o una
  tecnología nueva, se ficha un miembro **permanente** siguiendo la plantilla, no se improvisa.

## El roster

**Transversales de proceso**

| Rol | Agente | Especialistas |
|---|---|---|
| Arquitecto jefe / Tech Lead (diseño + contratos + grafo de deps) | `equipo-arquitecto` | 5 |
| Integrador (une, re-ejecuta todo, no se fía de autoinformes) | `equipo-integrador` | — |
| Revisor adversarial (solo lee y ejecuta; busca fallos, no aprueba) | `equipo-revisor` | 5 sabores |

**Leads de área**, con su número de especialistas:

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

Ejemplo de un área por dentro — **Backend** (14 especialistas):

```
equipo-backend                    el lead: elige lenguaje, reparte, responde del area
├── equipo-backend-python         Flask/FastAPI/Django, Celery, SQLAlchemy, asyncio
├── equipo-backend-node           Express/Fastify/NestJS, TS estricto, event loop
├── equipo-backend-go             goroutines, channels, context, gateways
├── equipo-backend-rust           Axum/Actix, ownership, p99 sin GC
├── equipo-backend-jvm            Spring Boot/Ktor, tuning de JVM y GC
├── equipo-backend-dotnet         ASP.NET Core, Minimal APIs, EF Core
├── equipo-backend-php            Laravel/Symfony, Composer, PSR
├── equipo-backend-ruby           Rails, ActiveRecord y sus limites a escala
├── equipo-backend-cpp            extensiones nativas, memoria manual
├── equipo-backend-elixir         Phoenix/OTP, supervision, tiempo real
├── equipo-backend-api-design     versionado, paginacion, OpenAPI, compatibilidad
├── equipo-backend-colas          RabbitMQ, Redis Streams, Kafka, dead-letter
├── equipo-backend-auth           OAuth2/OIDC, JWT vs sesion, MFA, multi-tenant
└── equipo-backend-caching        Redis/Memcached, invalidacion, thundering herd
```

**El listado completo de los 210, con alcance y nombre exacto, está en
[`skills/super-equipo/references/roster.md`](skills/super-equipo/references/roster.md).**

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

Copia `skills/super-equipo/` a `~/.claude/skills/` y los 234 `agents/equipo-*.md` a
`~/.claude/agents/`. Ambas cosas son **necesarias**: sin los agentes, la skill no tiene equipo
al que contratar.

Reinicia Claude Code. Comprueba con `/skills` que aparece `super-equipo` y con `/agents` que están
los `equipo-*`.

> **Coste de contexto — léelo antes de instalar.** Claude Code carga la `description` de todos
> los agentes en el system prompt de **cada** sesión, uses el super-equipo o no. Con 234 agentes
> son del orden de 100 KB permanentes. Si te importa más el contexto que la cobertura, instala
> solo los leads y las áreas que uses:
>
> ```bash
> ./install.sh --solo-leads                  # los 24 leads, sin especialistas
> ./install.sh --areas backend,frontend,qa   # leads + solo los especialistas de esas areas
> ```

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
| Pequeño (1 tecnología, acotado) | 1–2 especialistas + un `equipo-revisor-*` |
| Mediano (2–3 áreas) | Contratos breves + el especialista de cada tecnología en paralelo + revisor |
| Grande / multi-dominio | Organización completa vía `Workflow`, fases 1→6: leads que reparten entre los suyos |

Tener 210 especialistas no es licencia para contratarlos a todos: un encargo de tres tecnologías
son tres especialistas, no treinta.

## Estructura del repo

```
skills/super-equipo/
  SKILL.md                      # el orquestador: reglas, roster, fases, deslindes
  references/
    roster.md                   # los 210 especialistas con su alcance y nombre exacto
    organigrama.md              # roles y cadena de mando
    orquestacion.md             # esqueletos de Workflow, paralelo vs pipeline, presupuesto
    plantilla-agente.md         # estructura obligatoria para fichar un LEAD de area nueva
    plantilla-especialista.md   # estructura obligatoria para fichar un ESPECIALISTA
agents/
  equipo-<area>.md              # los 24 leads
  equipo-<area>-<slug>.md       # los 210 especialistas
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
