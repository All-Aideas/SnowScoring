# CLAUDE.md — SnowScore Hackathon Project
> Memoria persistente para Claude Code. Leé este archivo primero en cada sesión.
---
## 1. Contexto urgente
- **Proyecto:** SnowScore — Credit History API for the Invisible Generation
- **Evento:** Hackathon de Avalanche
- **Deadline:** **Domingo a las 9:00 AM** (entrega final)
- **Owner:** Cesar Riat (AI Lead, consultor en Argentina)
- **Idioma de trabajo:** Español rioplatense informal. Cesar usa voice-to-text, así que sus mensajes pueden tener errores de tipeo o frases pegadas — interpretá la intención, no te traben los typos.
## 2. Qué es SnowScore (resumen funcional)
SnowScore convierte tickets, facturas y extractos bancarios en un **score de comportamiento financiero** estandarizado, certificado on-chain en Avalanche, y vendido vía API a bancos/fintechs.
**Pitch en una frase:** "Sus recibos son el nuevo buró de crédito."
### Flujo end-to-end
1. Usuario sube fotos de tickets/facturas/extractos desde el navegador
2. Un **Financial Reasoning Agent** (Gemini 2.0 Flash multimodal) extrae datos estructurados, los normaliza a un schema único, y razona sobre patrones (recurrencia, estabilidad, consistencia)
3. Se calcula un SnowScore (0–100) y un grade (A+ a D)
4. Se ancla un hash de prueba en Avalanche C-Chain (Fuji testnet) — actualmente mock visual
5. Terceros (bancos, fintechs) consultan el score vía API REST por $0.12/call
### Diferencial vs. competencia
- No es un wrapper de GPT — es un agente con prompt estructurado que razona
- Blockchain con sentido técnico (Avalanche aporta finalidad sub-segundo + costo bajo + portabilidad), no pegada a la fuerza
- Modelo de negocio claro: no monetizamos al usuario vulnerable
## 3. Estrategia para el deadline
**Restricción crítica:** Cesar **NO va a codear smart contracts**. Toda la parte blockchain queda como:
- Slide de arquitectura conceptual en el deck
- Mock visual en la UI (hash falso, link a Snowtrace, badge "Verified on-chain")
- Roadmap "post-hackathon" para implementación real
**Lo que SÍ entregamos funcionando:**
- Landing page completa con propuesta de valor + API docs + pricing
- Login mock (cualquier email/password entra)
- Dashboard con score visible
- Upload real → Gemini API → JSON estandarizado → se agrega al historial
**Estrategia de pitch:** demo simple que funciona > demo ambiciosa que se rompe.
## 4. Estado actual del código
### Archivos en este directorio
- `index.html` — **app completa single-file** (landing + login + dashboard). HTML/CSS/JS vanilla, ~1200 líneas. Llama directamente a Gemini API desde el frontend (no hay backend).
- `notion-description.md` — descripción funcional para Notion del jurado/equipo
### Lo que ya funciona
- ✅ Routing SPA entre 3 páginas (landing / login / dashboard)
- ✅ Login mock con nombre del usuario derivado del email
- ✅ Upload de imagen con drag & drop
- ✅ Tabs para tipo de documento (ticket / extracto bancario / otro) que ajustan el prompt
- ✅ Llamada real a Gemini 2.0 Flash con `response_mime_type: "application/json"`
- ✅ Loading state animado de 5 pasos
- ✅ Render de resultados + auto-append al historial
- ✅ Diseño con identidad Avalanche (rojo #E84142, tipografía Fraunces, dark accents)
- ✅ Responsive mobile
### Lo que falta o conviene mejorar
- ⬜ Probar con varios tipos de documentos reales (factura de luz argentina, ticket de super, extracto bancario)
- ⬜ Mejorar el prompt si Gemini no clasifica bien algunos casos LATAM (ej: "Edenor" debería detectarse como utilities)
- ⬜ Persistir el historial en localStorage para que sobreviva al refresh (opcional, mejora la demo)
- ⬜ Animación de transición entre páginas (opcional)
- ⬜ Deploy a Firebase Hosting o GitHub Pages
- ⬜ **Deck extenso** (12-15 slides, pendiente)
- ⬜ **Pitch deck corto** (5-6 slides, pendiente)
- ⬜ Grabar el video del demo
## 5. Stack técnico
| Capa | Tecnología | Notas |
|------|-----------|-------|
| Frontend | HTML + CSS + JS vanilla | Single-file, deployable a cualquier static host |
| Tipografías | Fraunces (display), Inter Tight (body), JetBrains Mono (code) | Via Google Fonts CDN |
| AI | Gemini 2.0 Flash | endpoint: `generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent` |
| Auth | Mock (cualquier email entra) | No hay backend real |
| Blockchain | Avalanche C-Chain Fuji (conceptual) | Hash mock, link a Snowtrace |
| Hosting | Firebase Hosting (planeado) | Cesar tiene experiencia previa con Firebase |
### Endpoint de Gemini usado
```js
POST https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=API_KEY
{
  contents: [{ parts: [{ text: prompt }, { inline_data: { mime_type, data } }] }],
  generationConfig: { temperature: 0.2, response_mime_type: "application/json" }
}
```
### Schema de salida estandarizado (lo más importante)
```json
{
  "doc_type": "receipt | bank | other",
  "merchant": "string",
  "category": "utilities | groceries | rent | food | transport | education | health | telecom | income | transfer | other",
  "category_label": "string en español",
  "amount": number,
  "currency": "ARS",
  "date": "YYYY-MM-DD",
  "is_recurring": boolean,
  "recurrence_pattern": "monthly | weekly | one-time | unknown",
  "payment_behavior_signal": "frase corta describiendo el comportamiento (max 20 palabras)",
  "reliability_score": 0-100,
  "items_summary": "string",
  "datapoints_extracted": number
}
```
## 6. Decisiones de diseño tomadas
- **Single-file HTML:** Cesar quiere correrlo local con doble click o subir a Firebase. No queremos build steps, frameworks, ni configuración.
- **API key en el frontend:** SOLO para la demo. En producción iría detrás de un backend. Anotar esto en el deck como "limitación conocida del MVP".
- **No usar localStorage para guardar API key:** mejor que se pegue cada vez, queda más "demo controlada".
- **Rojo Avalanche (#E84142) como acento, no como color dominante:** la mayoría de la UI es snow/ink (blanco crema + negro), el rojo se usa quirúrgicamente.
- **Fraunces serif para los números grandes y headlines:** le da personalidad editorial, evita el look genérico de "AI slop SaaS".
- **Naming:** "SnowScore" (suena a Avalanche + pureza de datos), "SnowCertificate" (el SBT), "Financial Reasoning Agent" (el motor de IA).
## 7. Cómo trabaja Cesar
- **Ritmo rápido e iterativo.** Prefiere ver resultados parciales antes que planes largos.
- **Pregunta antes de asumir** cuando hay decisiones de arquitectura, pero **no preguntes por preferencias triviales** (colores, naming menor) — ya hay un sistema de diseño definido.
- **Mensajes pueden ser cortos y con typos** (voice-to-text). Interpretá la intención.
- **No genera código que él no pidió.** Si ve "deck extenso", quiere el deck — no le sumes un backend de Node sin avisar.
- **Usa Notion** para documentación. Las descripciones del proyecto van en markdown.
- **Le importa el branding personal** (cesarriat.com). Si algo es lucido y profesional, mejor.
## 8. Próximos pasos sugeridos (en orden)
1. **Validar la demo:** probar `index.html` con una factura de luz argentina real, ver si Gemini devuelve JSON limpio
2. **Ajustes finos al prompt si hace falta** (ej: forzar categorización LATAM, mejorar el `payment_behavior_signal`)
3. **Persistir historial en localStorage** (opcional, ~30 min, mejora mucho la demo)
4. **Deploy a Firebase Hosting** (~10 min)
5. **Grabar video del demo** (60-90 seg, guion ya definido — está en el chat con Claude)
6. **Armar deck extenso de 12-15 slides** (problema, mercado, solución, arquitectura, GTM, tokenomics, roadmap, team)
7. **Destilar pitch deck de 5-6 slides** del deck extenso
## 9. Guion del video del demo (referencia)
1. **0-8s:** Landing hero "Their receipts are the new credit bureau"
2. **8-15s:** Scroll mostrando stats, how it works, API docs con curl + pricing
3. **15-22s:** Click "Get Started" → login con Google
4. **22-30s:** Dashboard "Hola, Cesar" + score 87/100 visible
5. **30-35s:** Click tab "Extracto bancario"
6. **35-40s:** Subir factura de luz
7. **40-55s:** Loading state con 5 pasos
8. **55-75s:** Resultados + JSON de `POST /v1/standardize`
9. **75-85s:** Nueva entrada se agrega al historial
10. **85-90s:** Plano final en score card
## 10. Tono y narrativa para el pitch
> "Hoy te muestro tres cosas: el problema, el producto, y el negocio.
>
> **El problema:** 70% de los jóvenes en LATAM no tienen historial crediticio.
>
> **El producto:** SnowScore convierte tickets y extractos en datos estandarizados, con IA que razona sobre patrones de comportamiento.
>
> **El negocio:** no cobramos al usuario — cobramos a bancos y fintechs por consulta de API. $0.12 por score, anclado en Avalanche."
---
## Reglas de oro para Claude Code
1. **No reescribas el HTML entero por cambios chicos** — usá ediciones quirúrgicas.
2. **Mantené la estética actual** (Fraunces + rojo Avalanche + JetBrains Mono). No agregues TailwindCSS, no cambies fuentes, no propongas un rediseño.
3. **No agregues frameworks ni build steps.** Vanilla JS/CSS, una sola página.
4. **Si Gemini da problemas con un prompt, ajustá el prompt** — no cambies de modelo.
5. **Cualquier cambio funcional grande, avisá antes de hacerlo.** Si Cesar dice "agregale X", primero confirmá si X es lo que esperás o pedile que aclare en una pregunta.
6. **Logueá cambios significativos en este CLAUDE.md** al final, en una sección "Changelog".
---
## Changelog
- **2026-05-15:** Versión inicial del proyecto creada. Landing + Login + Dashboard funcionando con Gemini 2.0 Flash. Pendiente: deck, video, deploy.
- **2026-05-15:** Agregado insights panel (spending breakdown por categoría + monthly flow chart). Agregado bank connect mock (Galicia / Naranja X / Mercado Pago) + descarga de reporte crediticio JSON. CSS/JS vanilla, sin frameworks.
- **2026-05-15:** Git inicializado. README.md completo creado. Push a GitHub (All-Aideas/SnowScoring). API key de Gemini removida del HTML antes del commit. Notion actualizado con tareas y descripción completa del proyecto.
- **2026-05-15:** Brand system aplicado: Poppins reemplaza Fraunces+Inter Tight. Paleta #1E3A8A→#7C3AED→#14B8A6 (gradiente oficial). Border-radius en cards/botones/panels. Score card con gradiente. STATUS.md creado. Todo pusheado.
- **2026-05-15:** Agregado flow diagram visual en la landing (sección oscura entre stats-bar y "How it works"): Tickets + Historial → IA → Score/Avalanche → Entidades. Responsive mobile. README y CLAUDE.md actualizados. Todo pusheado.
- **2026-05-15 (tarde):** Deploy a Firebase Hosting → https://snowscore-709be.web.app (target snowscore-709be en proyecto acta-insights-sj5w4). API key de Gemini protegida con HTTP referrer restrictions (web.app, firebaseapp.com, localhost) + restricción a Generative Language API only en GCP.
- **2026-05-15 (noche):** **Anchoring on-chain REAL en Avalanche Fuji** (reemplaza el mock visual). Cambios quirúrgicos en index.html: (1) cargado ethers.js v6 vía CDN antes del script principal, (2) botón "Conectar Wallet" en `.dash-header` con `connectWallet()` que detecta `window.avalanche` (Core) o `window.ethereum` (MetaMask) y auto-switchea a Fuji (chainId 0xa869 / 43113) usando `wallet_switchEthereumChain` + `wallet_addEthereumChain` como fallback, (3) función `anchorOnChain(scoreData)` que computa `ethers.keccak256(ethers.toUtf8Bytes(JSON.stringify(scoreData)))` y manda self-tx con el hash en `data`, mostrando estado + link a Snowtrace y actualizando el footer dinámicamente, (4) botón "Certificar on-chain ↗" agregado a `renderResults` en una card con gradiente azul→violeta + div `#anchorStatus`, (5) nuevas clases CSS `.btn-outline` y `.btn-light`. Verificado en preview local: ethers cargado, funciones expuestas en `window`, render correcto, fallback "Conectá tu wallet primero" funcionando. Deploy verificado en producción con `firebase deploy --only hosting:snowscore-709be`.
- **2026-05-15 (noche):** **MANUAL.md creado** — guía step-by-step de usuario: requisitos, faucets Fuji, flujo de uso (landing → login → upload → wallet → anchor → verificación Snowtrace), troubleshooting, stack técnico, roadmap. STATUS.md, README.md y CLAUDE.md actualizados con el estado post-anchor.
- **2026-05-16:** **Logo y cover oficiales creados** en `brand/`. Logo (512×512): copo de nieve de 6 puntas con hexágono central que representa el "bloque" de blockchain — vincula Snow/Avalanche/blockchain en una sola marca. Cover (840×300): gradiente + snowflake + wordmark + tagline "Tu consumo construye tu identidad financiera". Aplicado en index.html: favicon (`<link rel="icon" type="image/svg+xml" href="brand/logo.svg">`) + topbar (`.logo-mark` ahora usa `background:url('brand/logo.svg')`). Reemplaza el diamond legacy que no comunicaba el concepto de nieve/blockchain. README, STATUS, MEMORY actualizados con brand assets.
- **2026-05-16 (sprint final, commit 32b5c79):** 4 features paralelos para reforzar la narrativa institucional del hackathon:
  1. **Sección "Para Instituciones"** (landing) con 3 cards (Bankaool · Microcrédito México · +35% aprobaciones / Arkangeles · Real Estate · -60% tiempo eval / Fintechs LATAM · nueva línea negocio). Reusa `.uc-grid` + `.uc-card` para consistencia visual, con `<strong>` para problema/solución/KPI.
  2. **FAQ institucional** con 5 preguntas en `<details>`/`<summary>` animados (privacidad/consentimiento, KYC, regulación BCRA/CNV/CNBV, integración core bancario, por qué Avalanche). Nuevas clases `.faq`, `.faq-list`, `.faq-item` con border violeta al abrir y `+`/`−` animado via `::after`.
  3. **Botón "Probar la API en vivo →"** en sección API. Función `tryApiDemo()` ejecuta 5 pasos animados (autenticando → resolviendo wallet → on-chain → scoring → firmando) con dot turquesa pulsante (`@keyframes apiPulse`), luego reemplaza el `.code-body` con respuesta JSON real generada (score 84-89 random, grade dinámico, confidence, proof hex, timestamp ISO, latencia 180-300ms). Permite al jurado ver el endpoint funcional sin correr curl.
  4. **Anchor persistente** post-certificación: `anchorOnChain()` guarda `{hash, url, ts, addr, score}` en `localStorage.snowscore_last_tx`. Función `restoreAnchorState()` corre en `DOMContentLoaded`. Función `updateAnchorBadge(hash, url)` actualiza tanto el footer del landing como un nuevo **badge pulsante en `.dash-header`** (`#lastAnchorBadge`, con `.anchor-dot` turquesa animado, clickeable → abre Snowtrace). Sobrevive al reload — clave para demo en vivo.

  Verificado en preview local: sin errores en consola, 3 cards/5 FAQs/badge/botón demo renderizan, API demo completa el flujo (200 OK · 284ms). Pusheado a master (`32b5c79`). Pendiente Cesar: `firebase deploy --only hosting:snowscore-709be`.

- **2026-05-16 (madrugada, commit 7ff0f05):** **Smart contract real + verify page + demo mode + crypto input** (cierre de Option A para el pitch institucional):
  1. **`contracts/ScoreRegistry.sol`** (Solidity 0.8.20+, compilado con `npx -y solc@0.8.24 --bin --abi --optimize`). Storage por usuario: `lastScore` (struct con score, grade, hash, confidence, timestamp, nonce), `anchorCount`, `totalAnchors`. Función `anchorScore(uint8 score, bytes2 grade, bytes32 hash, uint16 confidence)` + getter `getLastScore(address)` + evento `ScoreAnchored`. Artifacts en `build/contracts_ScoreRegistry_sol_ScoreRegistry.{bin,abi}` (bytecode 2766 bytes).
  2. **`deploy.html`** standalone (mini-app separada): ABI/bytecode inline + Core Wallet connect con auto-switch a Fuji + `ethers.ContractFactory(ABI, BYTECODE, signer).deploy()` one-click + muestra address + tx hash + Snowtrace link + instrucciones de pegado en `index.html`.
  3. **Página `/#verify?tx=0x...`** dentro de index.html: nuevo `<div class="page" id="page-verify">` con form, función `runVerify()` que valida regex `^0x[0-9a-fA-F]{64}$`, usa `ethers.JsonRpcProvider(FUJI_RPC).getTransaction/getTransactionReceipt/getBlock` para leer datos reales, y `renderVerifySuccess()` con gradient bg + score 72px + vs-grid. Caso demo (`DEMO_PROFILE.anchorTx`) responde con payload hardcoded para confiabilidad offline. URL hash routing (`#verify?tx=`) + link "Verificar" en navPublic.
  4. **Modo demo "María Pérez"**: constante `DEMO_PROFILE` con 7 docs iniciales + función `loginAsDemo()` que pre-pobla userEmail/userName/greetingName/avatarLetter, repobla `#historyList` con render animado (fade-in 60ms staggered), persiste tx demo en `localStorage.snowscore_last_tx` para que `restoreAnchorState()` la levante. Pill UI en login con dot turquesa pulsante y texto "Pre-cargada con 5+ documentos y score certificado".
  5. **`config.js` (gitignored)** para sacar la API key del repo público. `index.html` la carga con `<script src="config.js" onerror="window.SNOWSCORE_CONFIG=null;">` y `analyzeBtn` la lee de `window.SNOWSCORE_CONFIG?.GEMINI_API_KEY` con fallback al input manual. `config.example.js` queda como template para que cualquiera pueda forkear y correr local.

  Pusheado a master (`7ff0f05`). Pendiente Cesar: faucet AVAX → abrir deploy.html → deployar contrato → pegar address en `SCORE_REGISTRY_ADDRESS` → redeploy Firebase.

- **2026-05-16 (sesión actual):** **Narrativa cripto/hash unificada** — 5 ediciones quirúrgicas para que la propuesta de "aceptamos hashes" sea coherente end-to-end en toda la app:
  1. **Stats-bar 5to item**: `$155B · Remesas LATAM/año · ingresos hoy invisibles para el score`. Grid cambió a `repeat(auto-fit, minmax(200px, 1fr))` para escalar (antes era `repeat(4, 1fr)` fijo).
  2. **Upload tab "Otro" → "Cripto / Hash"** (`data-type="crypto"`). El `typePrompt` ahora describe "captura de transacción cripto, recibo de cobro en stablecoin o evidencia de remesa on-chain" para que Gemini entienda screenshots de wallet/explorer/exchange.
  3. **Historial default (Cesar)**: 6ta entrada `USDC — Cobro freelance (Base) · USDC 1.850 · Recurrente`.
  4. **DEMO_PROFILE.history (María)**: 2 entradas nuevas — `USDT — Remesa familiar (TRC20) · USDT 320` y `USDC — Cobro freelance (Base) · USDC 850`. El render de history-item ahora usa `${h.currency || 'ARS'}` en vez de hardcodear "ARS", para que las cripto muestren USDT/USDC.
  5. **Step 01 "Capturar"** menciona explícitamente "hashes de transacciones cripto (cobros en USDC/USDT, remesas on-chain)".

  Verificado en preview local: 5 stats renderizan en grid auto-fit, tab Cripto/Hash activo, María tiene 9 items en historial (2 con currency cripto), step 01 actualizado. Sin errores nuevos en consola. README/STATUS/MANUAL/MEMORY sincronizados. Pendiente: commit + push + redeploy Firebase.
