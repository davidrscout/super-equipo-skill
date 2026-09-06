# Roster completo del super-equipo

El roster tiene **dos niveles**:

- **Lead de area** (`equipo-<area>`) — dueno del area. Fija el enfoque, reparte entre
  sus especialistas, resuelve los solapes internos y responde del conjunto de su dominio.
- **Especialista** (`equipo-<area>-<slug>`) — dueno de UNA tecnologia o sub-disciplina
  concreta, con una profundidad que el lead no puede tener en todas a la vez.

**A quien contratas:**

| Situacion | A quien llamas |
|---|---|
| El encargo cae claramente en una tecnologia concreta | **al especialista**, directo |
| Hay que elegir entre tecnologias del area, o el slice cruza varias | **al lead** del area |
| El area entera es un slice grande | al **lead**, que reparte entre sus especialistas |
| No sabes de que area es | al **arquitecto**, en Fase 1 |

Contratar al lead cuando el trabajo es de una sola tecnologia desperdicia la
profundidad del especialista. Contratar al especialista cuando aun hay que **decidir**
que tecnologia usar te ata a su sesgo: ningun especialista de Postgres te va a
recomendar Mongo.

## Transversales de proceso

| Rol | Agente | Especialistas |
|---|---|---|
| Arquitectura | `equipo-arquitecto` | 5 |
| Integracion | `equipo-integrador` | — |
| Revision adversarial | `equipo-revisor` | 5 |

## Areas y sus especialistas

### Arquitectura — lead `equipo-arquitecto` (5 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-arquitecto-distribuidos` | Sistemas distribuidos | Particionado, replicacion, consistencia, CAP, sagas, idempotencia y tolerancia a fallos parciales |
| `equipo-arquitecto-apis` | Diseno de APIs | REST/JSON, gRPC, GraphQL; recursos y verbos, paginacion, versionado, contratos y compatibilidad |
| `equipo-arquitecto-ddd` | Modelado de dominio (DDD) | Bounded contexts, agregados, invariantes, lenguaje ubicuo, mapas de contexto y capas anticorrupcion |
| `equipo-arquitecto-eventos` | Mensajeria y arquitectura de eventos | Colas vs streams, event sourcing/CQRS, orden y entrega, patron outbox y evolucion de esquemas de evento |
| `equipo-arquitecto-nfrs` | Atributos de calidad (NFRs) | Presupuestos explicitos de latencia p50/p95/p99, disponibilidad, coste y escalabilidad, y como se verifican |

### Revision adversarial — lead `equipo-revisor` (5 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-revisor-correccion` | Revision de correccion funcional | Hace la pieza lo que el contrato y los criterios de aceptacion dicen, casos limite incluidos |
| `equipo-revisor-seguridad` | Revision de seguridad | Puede un actor hostil leer, escribir o romper lo que no debe, con PoC reproducible |
| `equipo-revisor-rendimiento` | Revision de rendimiento | Aguanta el volumen real sin degradarse y donde se dobla primero, medido y no supuesto |
| `equipo-revisor-accesibilidad` | Revision de accesibilidad | Puede usarla alguien con teclado, lector de pantalla o baja vision, probado en real |
| `equipo-revisor-codigo` | Revision de calidad de codigo | Es mantenible, honesto y consistente, o es deuda disfrazada de entrega |

### Frontend / UI — lead `equipo-frontend` (12 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-frontend-react` | React | Hooks, RSC/Next.js App Router, Suspense, patrones de composicion y las APIs de React 19 |
| `equipo-frontend-vue` | Vue | Composition API, Nuxt, Pinia, reactividad y script setup |
| `equipo-frontend-svelte` | Svelte / SvelteKit | Runes, stores, SSR/SSG y el compilador como ventaja de tamano |
| `equipo-frontend-angular` | Angular | Standalone components, signals, RxJS, change detection y OnPush |
| `equipo-frontend-css` | CSS y design systems | Arquitectura CSS, tokens, Tailwind, container queries, cascade layers y CSS moderno |
| `equipo-frontend-estado` | Gestion de estado | Local vs global, server-state con TanStack Query/SWR, Redux Toolkit, Zustand y cuando no hace falta nada |
| `equipo-frontend-build` | Build y bundling | Vite, webpack, esbuild, Rollup, code-splitting, tree-shaking y source maps |
| `equipo-frontend-performance` | Rendimiento web en navegador | Core Web Vitals, presupuestos, lazy-loading, imagenes y el camino critico de render |
| `equipo-frontend-pwa` | PWA y offline | Service workers, manifest, estrategias de cache, instalabilidad y push |
| `equipo-frontend-typescript` | TypeScript en frontend | Tipado estricto, tipos de props/eventos/DOM, discriminated unions y generics utiles |
| `equipo-frontend-testing` | Testing de UI | Vitest/Jest, Testing Library, Playwright/Cypress e2e y regresion visual |
| `equipo-frontend-forms` | Formularios y validacion | Validacion cliente-servidor coherente, esquemas Zod, UX de errores y accesibilidad del formulario |

### Backend — lead `equipo-backend` (14 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-backend-python` | Backend Python | Flask/FastAPI/Django, Celery/RQ, SQLAlchemy, asyncio, empaquetado y despliegue |
| `equipo-backend-node` | Backend Node/TypeScript | Express/Fastify/NestJS, tipado estricto extremo a extremo, event loop y sus trampas |
| `equipo-backend-go` | Backend Go | Alto throughput, binarios estaticos, goroutines y channels, context, gateways y servicios de red |
| `equipo-backend-rust` | Backend Rust | Axum/Actix, ownership y borrow checker, latencia p99 sin GC, FFI y seguridad de memoria |
| `equipo-backend-jvm` | Backend Java/Kotlin | Spring Boot/Ktor, tuning de JVM, GC, sistemas empresariales y su ecosistema |
| `equipo-backend-dotnet` | Backend C#/.NET | ASP.NET Core, Minimal APIs, EF Core, async/await y despliegue en Windows y Linux |
| `equipo-backend-php` | Backend PHP | Laravel/Symfony, Composer, PSR, hosting compartido y SaaS clasicos |
| `equipo-backend-ruby` | Backend Ruby | Rails, ActiveRecord, velocidad de producto en CRUD y sus limites de rendimiento a escala |
| `equipo-backend-cpp` | Backend C/C++ | Extensiones nativas, bajo nivel, interoperabilidad y gestion manual de memoria |
| `equipo-backend-elixir` | Backend Elixir | Phoenix/OTP, arboles de supervision, sistemas concurrentes y tiempo real con WebSockets masivos |
| `equipo-backend-api-design` | Diseno de APIs REST/GraphQL | Versionado, paginacion, contratos OpenAPI/schema, errores coherentes y compatibilidad hacia atras |
| `equipo-backend-colas` | Colas y mensajeria | RabbitMQ, Redis Streams, Kafka, SQS; producer/consumer, orden, reintentos y dead-letter |
| `equipo-backend-auth` | Auth y sesiones | OAuth2/OIDC, JWT vs sesion en servidor, refresh tokens, MFA, RBAC y aislamiento multi-tenant |
| `equipo-backend-caching` | Caching de aplicacion | Redis/Memcached, invalidacion, TTLs, cache-aside, thundering herd y coherencia |

### Bases de datos — lead `equipo-bases-de-datos` (12 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-bases-de-datos-postgresql` | PostgreSQL | MVCC, JSONB, CTEs, EXPLAIN (ANALYZE, BUFFERS), extensiones, particionado declarativo y vacuum |
| `equipo-bases-de-datos-mysql` | MySQL / MariaDB | InnoDB, utf8 vs utf8mb4, modos SQL, replicacion y los gotchas del stack heredado |
| `equipo-bases-de-datos-sqlite` | SQLite | WAL mode, limites de concurrencia de escritura, un solo fichero: escritorio, bots, tests y edge |
| `equipo-bases-de-datos-mongodb` | MongoDB | Documentos con esquema flexible, agregaciones, transacciones y consistencia; y cuando NO usarlo |
| `equipo-bases-de-datos-redis` | Redis | Cache, colas, rate-limiting, locks distribuidos, sesiones, pub/sub y persistencia RDB/AOF |
| `equipo-bases-de-datos-cassandra` | Cassandra / ScyllaDB | Escala masiva write-heavy, modelado dirigido por la query, particiones y consistencia sintonizable |
| `equipo-bases-de-datos-vectoriales` | Bases vectoriales | pgvector, Qdrant, Milvus, Pinecone; metricas de distancia, indices HNSW/IVF y busqueda hibrida |
| `equipo-bases-de-datos-modelado` | Modelado de datos | Normalizacion 3NF y desnormalizacion deliberada, tipos correctos, restricciones y claves naturales vs sustitutas |
| `equipo-bases-de-datos-consultas` | Optimizacion de consultas | Lectura de planes, indices compuestos, eliminacion de N+1 y reescritura de subconsultas |
| `equipo-bases-de-datos-migraciones` | Migraciones | Alembic, Flyway, Liquibase, django-migrations, Prisma Migrate; siempre reversibles y expand/contract |
| `equipo-bases-de-datos-indices` | Indices | B-tree, GIN/GiST, parciales, de expresion, covering; y el arte de no sobre-indexar |
| `equipo-bases-de-datos-ha` | Replicacion y alta disponibilidad | Streaming replication, replicas de lectura, failover, backups verificados y PITR |

### DevOps / Infra — lead `equipo-devops` (14 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-devops-docker` | Contenedores (Docker/Podman) | Dockerfiles multi-stage, imagenes minimas, usuario no-root, capas y cache de build |
| `equipo-devops-kubernetes` | Orquestacion (Kubernetes) | Manifests/Helm/Kustomize, probes, requests/limits, HPA, ingress y rollout seguro |
| `equipo-devops-cicd` | CI/CD | GitHub Actions y GitLab CI: cache, matrices, OIDC sin claves de larga vida, gates y rollback |
| `equipo-devops-iac` | IaC (Terraform/OpenTofu, Ansible) | Estado remoto con lock, modulos, plan en PR, idempotencia y control de drift |
| `equipo-devops-aws` | AWS | EC2, S3, RDS, IAM de minimo privilegio, VPC, ALB, CloudWatch, ECS/EKS y control de coste |
| `equipo-devops-gcp` | GCP | Compute Engine, Cloud Run, Cloud SQL, GCS, IAM y Cloud Logging/Monitoring |
| `equipo-devops-azure` | Azure | App Service, AKS, Blob Storage, Key Vault y Monitor |
| `equipo-devops-observabilidad` | Observabilidad | Prometheus/Grafana/Loki/OTel, alertas con SLO y error budget, cardinalidad y paneles que se miran |
| `equipo-devops-secretos` | Gestion de secretos | Vault, SOPS+age, Secret Manager, EnvironmentFile de systemd, rotacion y deteccion de fugas |
| `equipo-devops-systemd` | systemd | Unidades de servicio, Restart=, timers, y sandboxing con ProtectSystem, PrivateTmp y NoNewPrivileges |
| `equipo-devops-nginx` | nginx | Reverse proxy, terminacion TLS, HTTP/2, cabeceras de seguridad, rate limiting y conflictos de puerto |
| `equipo-devops-hardening` | Hardening de VPS | SSH solo por clave, ufw/nftables, fail2ban, actualizaciones desatendidas y superficie minima |
| `equipo-devops-tls-dns` | TLS y DNS | Let's Encrypt con certbot/acme.sh, renovacion automatica, registros DNS, propagacion y CAA |
| `equipo-devops-backup` | Backup y recuperacion | Copias cifradas off-site con restic/borg, retencion, y la restauracion probada de verdad |

### Seguridad — lead `equipo-seguridad` (8 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-seguridad-appsec` | AppSec / OWASP Top 10 | Inyeccion (SQLi, NoSQLi, command, SSTI), XSS, CSRF, SSRF, deserializacion y sus fixes verificados |
| `equipo-seguridad-pentest` | Pentest defensivo | Verificacion adversarial contra staging con Burp, ffuf, nuclei y sqlmap, solo sobre sistemas propios |
| `equipo-seguridad-cripto` | Criptografia aplicada | argon2id/bcrypt, AES-GCM, libsodium, TLS, firma y verificacion de webhooks y tokens con CSPRNG |
| `equipo-seguridad-secretos` | Gestion de secretos | Inventario, rotacion, env vs vault, deteccion de fugas con gitleaks/trufflehog y scoping |
| `equipo-seguridad-authz` | Auth y autorizacion | Modelo de identidad, sesiones, MFA, OAuth/OIDC, JWT o por que no, y control de acceso por objeto |
| `equipo-seguridad-hardening` | Hardening de infraestructura | Sandboxing de units systemd, nginx, ufw/nftables, fail2ban, TLS y cabeceras de seguridad |
| `equipo-seguridad-compliance` | Compliance tecnico | RGPD en lo tecnico (minimizacion, supresion, retencion, cifrado en reposo) y PCI-DSS por alcance |
| `equipo-seguridad-deteccion` | Deteccion y respuesta | Logs de seguridad accionables, alertas, plan de respuesta a incidentes y rotacion de credenciales |

### QA / Testing — lead `equipo-qa` (12 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-qa-estrategia` | Estrategia de test | Piramide o trofeo segun el proyecto, riesgo por modulo, que se prueba en que nivel y criterios de salida |
| `equipo-qa-unit` | Unit testing | pytest/Jest/Vitest, AAA, un motivo de fallo por test, aislamiento y velocidad |
| `equipo-qa-integracion` | Testing de integracion | Piezas reales juntas con Testcontainers, base de datos real y limpieza entre tests |
| `equipo-qa-e2e` | End-to-end | Playwright preferido o Cypress: navegador real, datos deterministas y selectores estables |
| `equipo-qa-carga` | Testing de carga | k6, Locust, Artillery: SLOs, percentiles p95/p99, soak tests y deteccion de fugas |
| `equipo-qa-property` | Property-based testing | Hypothesis y fast-check: invariantes en vez de casos concretos, con shrinking |
| `equipo-qa-mutacion` | Cobertura y analisis de mutacion | coverage.py/c8 y mutmut/Stryker para medir si los tests detectan fallos de verdad |
| `equipo-qa-mocking` | Mocking y contract testing | responses/respx, msw, Pact; que se mockea, que no, y por que |
| `equipo-qa-fixtures` | Fixtures y datos de prueba | pytest fixtures, factory_boy/Faker, builders y setup/teardown deterministas |
| `equipo-qa-ci` | CI de tests | Matrices, paralelismo, cache, gate de merge, cuarentena de flaky tests y reportes JUnit/HTML |
| `equipo-qa-contratos` | Contratos de API y esquemas | Validacion OpenAPI/JSON Schema, snapshot testing con criterio y verificacion de idempotencia |
| `equipo-qa-visual` | Regresion visual y a11y en CI | Playwright screenshots con comparacion y axe-core como gate de merge |

### Datos / ML / IA — lead `equipo-datos-ml` (9 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-datos-ml-data-engineering` | Data Engineering (ETL/ELT) | Ingesta, transformacion, orquestacion con Airflow/Dagster/Prefect, dbt, CDC y contratos de datos |
| `equipo-datos-ml-ml-clasico` | ML clasico | Tabular: regresion, arboles y boosting (XGBoost/LightGBM/CatBoost), feature engineering y validacion cruzada |
| `equipo-datos-ml-deep-learning` | Deep Learning | PyTorch, vision, series temporales, entrenamiento en GPU y fine-tuning |
| `equipo-datos-ml-rag` | Apps LLM y RAG | Chunking, retrieval, reranking, orquestacion, agentes con tool-calling y salidas estructuradas |
| `equipo-datos-ml-mlops` | MLOps | MLflow, DVC, CI/CD de modelos, serving con FastAPI/BentoML/vLLM, monitorizacion y drift |
| `equipo-datos-ml-evaluacion` | Evaluacion de modelos | Conjuntos de test, metricas honestas, evals de LLM (LLM-as-judge, golden sets), A/B y calibracion |
| `equipo-datos-ml-prompting` | Prompt engineering | Diseno de prompts, few-shot, structured outputs, control de coste/latencia y defensa contra inyeccion |
| `equipo-datos-ml-embeddings` | Embeddings y busqueda vectorial | Eleccion de modelo, normalizacion, indices HNSW/IVF, bases vectoriales e hibrido denso+BM25 |
| `equipo-datos-ml-data-quality` | Feature stores y calidad de datos | Great Expectations/Pandera, consistencia train/serve y features versionadas |

### Movil — lead `equipo-movil` (10 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-movil-ios` | iOS / Swift | Swift, SwiftUI y UIKit, async/await, Combine, provisioning, capabilities y StoreKit |
| `equipo-movil-android` | Android / Kotlin | Kotlin, Jetpack Compose y Views, Coroutines/Flow, Hilt, Room, WorkManager y Play Billing |
| `equipo-movil-react-native` | React Native | RN y Expo (EAS Build/Update), New Architecture (Fabric/TurboModules/JSI), Hermes y puentes nativos |
| `equipo-movil-flutter` | Flutter / Dart | Widgets, Riverpod/Bloc, platform channels e Impeller |
| `equipo-movil-performance` | Rendimiento movil | Arranque en frio, jank y frames, memoria, bateria, tamano del binario y profiling con Instruments/Perfetto |
| `equipo-movil-push` | Notificaciones push | APNs con token .p8, FCM HTTP v1, payloads, deep-linking, permisos y rich/silent push |
| `equipo-movil-stores` | Publicacion en stores | App Store Connect y Play Console, firma, revision, ASO, privacy labels y staged rollout |
| `equipo-movil-offline` | Offline-first y sincronizacion | Room/SQLDelight/Core Data/WatermelonDB, cola de mutaciones y resolucion de conflictos |
| `equipo-movil-seguridad` | Seguridad movil | Keychain/Keystore, pinning, ATT, permisos runtime, ofuscacion y OWASP MASVS |
| `equipo-movil-multiplataforma` | Codigo compartido multiplataforma | Kotlin Multiplatform, modulos compartidos, contratos de API cliente y generacion de tipos |

### Embebido / IoT — lead `equipo-embebido` (9 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-embebido-c-embebido` | C/C++ embebido | El lenguaje del metal: -Wall -Wextra -Werror, MISRA-C, sin malloc dinamico, volatile y secciones criticas |
| `equipo-embebido-rtos` | RTOS | FreeRTOS, Zephyr, ThreadX: tareas, prioridades, colas, semaforos e inversion de prioridad |
| `equipo-embebido-microcontroladores` | Microcontroladores | ESP32/STM32/RP2040/nRF/Arduino: bring-up, HAL, ESP-IDF, STM32Cube, clocks y perifericos |
| `equipo-embebido-buses` | Protocolos de bus | I2C/SPI/UART/1-Wire/CAN: timing, pull-ups, clock stretching, chip-select y analizador logico |
| `equipo-embebido-radio` | Conectividad inalambrica | BLE/Wi-Fi/LoRa/Zigbee/Thread/Matter: GATT, advertising, emparejamiento, alcance y consumo |
| `equipo-embebido-energia` | Gestion de energia | Sleep modes, deep sleep, RTC wakeup, presupuesto de corriente en microamperios y vida de bateria calculada |
| `equipo-embebido-hardware` | Integracion con hardware | Datasheet y esquematico, pinout, niveles logicos 3V3 vs 5V, ruido, desacoplo y medida real |
| `equipo-embebido-nfc` | NFC / HCE | ISO 14443 A/B, NDEF, MIFARE, APDUs, Android HostApduService y los limites honestos de la tecnologia |
| `equipo-embebido-ota` | OTA, bootloader y secure boot | Particiones A/B, rollback, firma de imagen, secure boot y actualizacion en campo sin ladrillos |

### Redes y sistemas — lead `equipo-redes` (6 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-redes-tcpip` | Networking (TCP/IP, DNS, HTTP, TLS) | Handshake, congestion CUBIC/BBR, MTU/MSS/PMTUD, resolucion DNS, HTTP/1.1/2/3 y handshake TLS |
| `equipo-redes-balanceo` | Balanceo de carga y CDN | nginx, HAProxy, Envoy, Caddy; algoritmos de balanceo, health checks, sticky sessions y cache de CDN |
| `equipo-redes-concurrencia` | Concurrencia y paralelismo | Multiproceso, hilos, event loop, actores, CSP; mutex, RWLock, semaforos, GIL y deadlocks |
| `equipo-redes-so` | Sistemas operativos | Scheduler, procesos vs hilos, memoria virtual, fork/exec/wait, senales, cgroups y limites de recursos |
| `equipo-redes-sockets` | Sockets y programacion de sistemas | BSD sockets, no bloqueante, select/poll/epoll, descriptores de fichero y su agotamiento |
| `equipo-redes-diagnostico` | Diagnostico de bajo nivel | tcpdump/Wireshark, ss, strace, perf y flamegraphs, dmesg, /proc y eBPF |

### Integraciones / APIs — lead `equipo-integraciones` (12 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-integraciones-clientes-http` | Clientes REST/GraphQL de terceros | Timeouts, paginacion cursor/offset, manejo de errores, tipado de respuestas y capa anticorrupcion |
| `equipo-integraciones-webhooks` | Webhooks entrantes | Verificacion de firma, 2xx rapido mas procesado asincrono, deduplicacion y replay |
| `equipo-integraciones-stripe` | Pagos con tarjeta (Stripe) | Checkout/PaymentIntents, stripe-signature, ciclo de vida del pago, reembolsos y disputas |
| `equipo-integraciones-cripto` | Pagos cripto | NOWPayments y similares: invoices, IPN con HMAC, confirmaciones, subpagos y reconciliacion |
| `equipo-integraciones-mensajeria` | APIs de mensajeria y bots | Telegram con secret_token vs getUpdates, Discord, WhatsApp Cloud API: plantillas y limites |
| `equipo-integraciones-shopify` | Shopify | Admin REST/GraphQL, webhooks HMAC, App Bridge/OAuth, coste por consulta y limites de la plataforma |
| `equipo-integraciones-oauth` | OAuth 2.0 / OIDC | Authorization Code con PKCE, state, refresh tokens, rotacion y scopes minimos |
| `equipo-integraciones-idempotencia` | Idempotencia | Claves de idempotencia salientes, tablas de eventos entrantes y exactly-once efectivo |
| `equipo-integraciones-resiliencia` | Reintentos y resiliencia | Backoff exponencial con jitter, circuit breaker, timeouts y dead-letter queue |
| `equipo-integraciones-rate-limits` | Rate limiting | Retry-After, cabeceras X-RateLimit, token bucket local, colas y concurrencia acotada |
| `equipo-integraciones-credenciales` | Secretos y credenciales de terceros | Rotacion, separacion test/live, almacen y el fallo clasico de mezclar entornos |
| `equipo-integraciones-reconciliacion` | Observabilidad y reconciliacion | Logs correlados, metricas por endpoint y reconciliacion periodica del proveedor contra la BD |

### Rendimiento — lead `equipo-rendimiento` (8 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-rendimiento-profiling` | Profiling de CPU y memoria | py-spy, cProfile, scalene, memray y flame graphs; hotspots, asignaciones y fugas |
| `equipo-rendimiento-algoritmos` | Algoritmos y estructuras de datos | Coste asintotico, estructura correcta (set/dict/heap/trie/bloom) y evitar trabajo cuadratico |
| `equipo-rendimiento-caching` | Caching multicapa | HTTP (Cache-Control/ETag/CDN), aplicacion (Redis/memcached), memoizacion y vistas materializadas |
| `equipo-rendimiento-web-vitals` | Core Web Vitals | LCP, INP, CLS, TTFB; critical CSS, lazy-loading, preload/preconnect y compresion de imagenes |
| `equipo-rendimiento-consultas` | Optimizacion de consultas de BD | EXPLAIN (ANALYZE, BUFFERS), indices, N+1, planes y VACUUM/ANALYZE |
| `equipo-rendimiento-concurrencia` | Concurrencia y dimensionado | async vs hilos vs procesos, dimensionado de workers, backpressure y contencion |
| `equipo-rendimiento-benchmarking` | Benchmarking y carga | Micro y macro-benchmarks estadisticamente validos, y load/stress/soak con k6, wrk y oha |
| `equipo-rendimiento-observabilidad` | Observabilidad de rendimiento | Prometheus/node_exporter, tracing con OpenTelemetry, RUM y CrUX, y correlacion con despliegues |

### Web3 / Blockchain — lead `equipo-web3` (8 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-web3-solidity` | Smart contracts / Solidity | Patrones checks-effects-interactions y pull-over-push, OpenZeppelin/Solady y upgradeabilidad |
| `equipo-web3-evm` | EVM y bajo nivel | Opcodes, memoria vs storage vs calldata, delegatecall, layout de storage, ABI encoding y assembly |
| `equipo-web3-offchain` | Integracion on-chain / off-chain | ethers.js/viem/web3.py, gestion de nonce, EIP-1559, estimacion de gas y reorgs |
| `equipo-web3-wallets` | Wallets y firmas | EIP-191/EIP-712, EIP-4361 Sign-In with Ethereum, account abstraction ERC-4337 y WalletConnect |
| `equipo-web3-defi` | DeFi y tokenomics | ERC-20 con permit (EIP-2612), AMMs, oraculos Chainlink y TWAP, slippage y MEV |
| `equipo-web3-auditoria` | Seguridad de contratos | Reentrancy mono, cross-function y read-only, control de acceso, front-running y overflow |
| `equipo-web3-indexado` | Indexado on-chain | The Graph, Ponder o indexador propio con getLogs y cursor por bloque, y manejo de reorgs |
| `equipo-web3-tooling` | Tooling, testing y despliegue | Foundry (forge/cast/anvil), Hardhat, fuzzing e invariant testing, y despliegue verificado |

### Automatizacion / Bots — lead `equipo-automatizacion` (7 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-automatizacion-scripting` | Scripting (Python/PowerShell/Bash) | Pegamento y CLIs robustos: argparse/click, codigos de salida, idempotencia y logging estructurado |
| `equipo-automatizacion-scraping` | Scraping web | De HTTP plano a navegador headless: Playwright, requests, BeautifulSoup/lxml, anti-bot y parsing resistente |
| `equipo-automatizacion-bots` | Bots de mensajeria | python-telegram-bot v20+, aiogram, discord.py: comandos, estados, teclados, webhooks vs polling |
| `equipo-automatizacion-rpa` | RPA y automatizacion de escritorio | pywinauto, pyautogui, UIAutomation, AutoHotkey; cuando el RPA es correcto y cuando es deuda |
| `equipo-automatizacion-scheduling` | Scheduling y orquestacion | cron, systemd timers (OnCalendar, Persistent), Tareas de Windows, solapamiento y bloqueo de ejecuciones |
| `equipo-automatizacion-alertas` | Notificacion y observabilidad de jobs | ntfy, healthchecks.io, dead man switch, alertas accionables y fallo ruidoso en vez de silencioso |
| `equipo-automatizacion-colas` | Colas y trabajo diferido | Celery/RQ/Dramatiq y alternativas ligeras; reintentos, visibilidad, dead-letter y exactly-once efectivo |

### Diseno / UX — lead `equipo-diseno` (9 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-diseno-research` | UX research | Entrevistas, tests moderados y no moderados, encuestas, analitica de comportamiento y sintesis |
| `equipo-diseno-ia` | Arquitectura de informacion | Navegacion, taxonomias, nomenclatura, card sorting y tree testing |
| `equipo-diseno-ui` | Diseno visual / UI | Layout, tipografia, color, espaciado, rejilla y jerarquia visual aplicada |
| `equipo-diseno-design-systems` | Design systems | Tokens de color/espaciado/tipografia/radios/sombras, libreria de componentes y su gobierno |
| `equipo-diseno-prototipado` | Prototipado | De baja a alta fidelidad, prototipos interactivos y clicables para validar antes de construir |
| `equipo-diseno-usabilidad` | Pruebas de usabilidad | Protocolos de test, tareas, metricas (SUS, tasa de exito, tiempo) y lectura honesta de resultados |
| `equipo-diseno-microinteracciones` | Microinteracciones y estados | Feedback inmediato, animacion con proposito y estados de vacio, carga, error y exito |
| `equipo-diseno-layout` | Jerarquia visual y layout | Orden de lectura, contraste, agrupacion Gestalt, densidad y ritmo vertical |
| `equipo-diseno-ux-writing` | UX writing | Microcopy, mensajes de error accionables, etiquetas, tono y nomenclatura del usuario |

### Producto — lead `equipo-producto` (9 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-producto-requisitos` | Requisitos | Capturar necesidades, separar problema de solucion y especificar requisitos funcionales y no funcionales |
| `equipo-producto-historias` | Historias de usuario y criterios | Formato Como X quiero Y para Z, criterios Gherkin testables y Definition of Done |
| `equipo-producto-priorizacion` | Priorizacion | RICE, MoSCoW, WSJF, Kano y coste de retraso para ordenar el backlog con criterio explicito |
| `equipo-producto-metricas` | Metricas y KPIs | North Star, arbol de metricas, eventos de analitica y lectura desde la fuente real |
| `equipo-producto-roadmap` | Roadmap | Horizontes now/next/later, dependencias y expectativas; roadmap de resultados, no de fechas |
| `equipo-producto-mvp` | Alcance y MVP | Cortar al minimo que valida la hipotesis, out-of-scope explicito y criterio de kill |
| `equipo-producto-competencia` | Analisis competitivo y de mercado | Benchmarking real, pricing, posicionamiento, TAM/SAM/SOM y hueco de mercado |
| `equipo-producto-discovery` | Discovery y research | Entrevistas, encuestas, tests de humo, fake door y analisis de tickets de soporte |
| `equipo-producto-experimentacion` | Experimentacion y A/B | Hipotesis, metrica primaria, tamano de muestra, significancia y honestidad al leer resultados |

### Documentacion — lead `equipo-documentacion` (10 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-documentacion-technical-writing` | Technical writing | Estructura, voz, tono y registro; edicion y minimalismo de Carroll; el lector quiere terminar su tarea |
| `equipo-documentacion-readme` | README y quickstart | El primer minuto del repo: que es, como se instala, como se arranca y como se prueba, reproducible de verdad |
| `equipo-documentacion-openapi` | Referencia de API (OpenAPI) | Spec OpenAPI 3.1 validada, Swagger UI/Redoc/Scalar, ejemplos por endpoint, errores, auth y rate limits |
| `equipo-documentacion-tutoriales` | Tutoriales | Aprendizaje guiado end-to-end para principiantes: camino unico, sin ramas y resultado garantizado |
| `equipo-documentacion-howto` | Guias how-to | Recetas orientadas a tarea para quien ya sabe, probadas end-to-end |
| `equipo-documentacion-usuario-final` | Docs de usuario final | Manuales no tecnicos, FAQ, onboarding in-app, capturas y GIFs, lenguaje sin jerga |
| `equipo-documentacion-changelog` | Changelogs y notas de version | Keep a Changelog + SemVer y guias de migracion para breaking changes |
| `equipo-documentacion-docstrings` | Docstrings y comentarios | Google/NumPy style, JSDoc/TSDoc, Sphinx/MkDocs/TypeDoc; el porque, no el que |
| `equipo-documentacion-diagramas` | Diagramas y ADRs | Mermaid, modelo C4 y Architecture Decision Records que dejan por escrito el porque |
| `equipo-documentacion-docs-as-code` | Docs-as-code y publicacion | MkDocs Material/Docusaurus/Sphinx, versionado en Git, CI de docs, link-checking y previews por PR |

### SEO / Growth — lead `equipo-seo` (6 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-seo-tecnico` | SEO tecnico | robots.txt, sitemap.xml troceado, canonicas, indexacion, rastreo, renderizado JS y Screaming Frog |
| `equipo-seo-onpage` | SEO on-page | Arquitectura de informacion, enlazado interno, mapeo intencion-URL, titles/meta y contenido |
| `equipo-seo-analitica` | Analitica y medicion | GA4 (streams, eventos, key events, debug_view), GSC, GTM y consent mode v2 |
| `equipo-seo-internacional` | SEO internacional | hreflang bidireccional con x-default, estrategia de URLs por mercado y geotargeting |
| `equipo-seo-cro` | CRO | Analisis de embudo, heuristica de friccion en formularios y checkout, y experimentos con significancia |
| `equipo-seo-datos-estructurados` | Datos estructurados y CWV de campo | Schema.org/JSON-LD, rich results y Core Web Vitals medidos en campo con CrUX |

### i18n / Localizacion — lead `equipo-i18n` (7 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-i18n-framework` | Internacionalizacion de codigo | gettext/Babel, i18next/FormatJS, extraccion de strings y caza de hardcodeados |
| `equipo-i18n-calidad` | Traduccion y QA linguistico | Briefing y glosario, memoria de traduccion, revision nativa y deteccion de registro chirriante |
| `equipo-i18n-formatos` | Formatos por locale | CLDR como fuente de verdad, Intl.*, fecha/hora/numero/moneda y zonas horarias |
| `equipo-i18n-rtl` | RTL y UI bidireccional | dir=rtl, propiedades logicas CSS, espejado de iconos y textos mixtos LTR/RTL |
| `equipo-i18n-plurales` | Catalogos, pluralizacion e ICU | Reglas de plural CLDR, ICU MessageFormat, genero y variables en mensajes |
| `equipo-i18n-routing` | Negociacion de idioma y SEO multilingue | Accept-Language, override de usuario, estrategia de URLs, hreflang y x-default |
| `equipo-i18n-contenido-ia` | Localizacion de contenido dinamico e IA | Forzar el locale en LLM y plantillas de email, y verificar el idioma de salida |

### Legal / Compliance — lead `equipo-legal` (9 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-legal-rgpd` | RGPD y LOPDGDD | Bases de legitimacion, RAT del art. 30, derechos ARSOPL, DPIA, brechas y encargados de tratamiento |
| `equipo-legal-lssi` | LSSI-CE | Datos identificativos del prestador, comunicaciones comerciales, contratacion electronica y aviso legal |
| `equipo-legal-privacidad-diseno` | Privacidad por diseno y por defecto | Minimizacion, seudonimizacion, configuracion privada por defecto y limites de recogida |
| `equipo-legal-oss` | Licencias de software (OSS) | SBOM, compatibilidad de licencias, copyleft GPL/LGPL/AGPL, atribucion y auditoria de dependencias |
| `equipo-legal-contratos` | ToS, avisos legales y contratos | Terminos y condiciones, condiciones de venta B2C, desistimiento de 14 dias y clausulas abusivas |
| `equipo-legal-cookies` | Cookies y consentimiento | Guia de Cookies de la AEPD, rechazar tan facil como aceptar, sin muros de cookies y consent mode |
| `equipo-legal-retencion` | Retencion y borrado de datos | Plazos por tipo de dato, borrado o anonimizacion automatizada y fin del tratamiento |
| `equipo-legal-transferencias` | Transferencias internacionales | Mapa de flujos fuera del EEE, SCC 2021/914, evaluacion del pais destino y subencargados |
| `equipo-legal-ai-act` | Propiedad intelectual y AI Act | Derechos sobre imagenes y textos incluido contenido generado por IA, marcas y transparencia del AI Act |

### Accesibilidad — lead `equipo-accesibilidad` (9 especialistas)

| Agente | Especialidad | Alcance |
|---|---|---|
| `equipo-accesibilidad-wcag` | WCAG y normativa | Mapa de criterios A/AA/AAA de WCAG 2.1/2.2, EN 301 549, EAA, ADA/Section 508; VPAT/ACR y declaraciones de accesibilidad |
| `equipo-accesibilidad-aria` | ARIA y semantica HTML | HTML nativo primero; roles, states y properties correctos; APG; cuando ARIA sobra y cuando es imprescindible |
| `equipo-accesibilidad-teclado` | Navegacion por teclado y foco | Orden de tab, focus trap en modales, skip links, foco visible, retorno de foco, atajos que no colisionan |
| `equipo-accesibilidad-lectores` | Lectores de pantalla | NVDA+Firefox/Chrome, VoiceOver+Safari, JAWS, TalkBack: pruebas reales, anuncios y live regions |
| `equipo-accesibilidad-color` | Contraste y color | Ratios WCAG 2.x y algoritmo APCA, no transmitir informacion solo por color, alto contraste y dark mode |
| `equipo-accesibilidad-formularios` | Formularios accesibles | Labels programaticas, fieldset/legend, errores accionables, autocomplete y validacion anunciada |
| `equipo-accesibilidad-tooling` | Auditoria, tooling y CI | axe-core, Pa11y, Lighthouse, WAVE, IBM Equal Access; gate en CI y triaje de falsos positivos |
| `equipo-accesibilidad-contenido` | Contenido accesible y cognitivo | Lenguaje claro, jerarquia de encabezados, textos alternativos, subtitulos, transcripciones y carga cognitiva |
| `equipo-accesibilidad-motora` | Movilidad reducida y motora | Dianas de 24x24 CSS px minimo, alternativas a gestos complejos, tiempos ajustables y prefers-reduced-motion |

---

**Total: 210 especialistas + 24 leads = 234 agentes.**

Si el encargo toca un area o una tecnologia sin agente, se ficha un miembro
**permanente** nuevo: `references/plantilla-agente.md` para un lead de area nueva,
`references/plantilla-especialista.md` para un especialista dentro de un area existente.
