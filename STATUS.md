# SnowScore — Estado del proyecto

> Última actualización: 2026-05-16 (ScoreRegistry + verify page + demo mode + crypto/hash narrative)

## Estado general
**Hackathon Avalanche LatAm Institutional** · Deadline: Domingo 9:00 AM
**Live:** https://snowscore-709be.web.app

---

## MVP — Componentes

### ✅ Completado

| Componente | Detalle |
|-----------|---------|
| Landing page | Hero + stats + flow diagram + how it works + API docs + pricing + use cases |
| Flow diagram visual | Tickets+Banco → IA → Score/Avalanche → Entidades. Dark section, responsive. |
| Login | Mock: email / Google / Core Wallet. Cualquier email entra. |
| Dashboard | Score 87/A-, greeting dinámico por email. |
| Upload | Drag & drop + tabs (Ticket / Extracto bancario / **Cripto / Hash**) — el tab cripto ajusta el prompt para entender screenshots de wallet, explorador o exchange |
| Financial Reasoning Agent | Gemini 2.5 Flash integrado, JSON mode, prompt LATAM-aware |
| Loading state | 5 pasos animados (visión → normalización → razonamiento → scoring → on-chain) |
| Resultados | Behavioral signal + tabla de datos + JSON del schema output |
| Historial | Auto-append al subir documento, mock de 5 entradas pre-cargadas |
| Spending breakdown | Barras por categoría hardcodeadas (Alquiler 42%, Utilities 22%...) |
| Monthly flow | Mini chart 6 meses, mes actual en violeta |
| Bank connect | Mock: Galicia / Naranja X / Mercado Pago con estado "Conectado" |
| Descarga reporte | JSON descargable con score, categorías, on-chain proof, privacy note |
| Brand system | Poppins + gradiente #1E3A8A→#7C3AED→#14B8A6, border-radius, cards |
| Responsive | Mobile-first, sidebar oculta en mobile |
| **Wallet connect (real)** | Botón en dashboard, detecta `window.avalanche`/`window.ethereum`, auto-switch a Fuji |
| **Anchor on-chain (real)** | keccak256 del score → self-tx con hash en `data` → link Snowtrace |
| **Anchor persistente** | `localStorage.snowscore_last_tx` + badge pulsante en dash-header (sobrevive al reload) |
| **Sección "Para Instituciones"** | 3 cards (Bankaool, Arkangeles, Fintechs LATAM) con problema/solución/KPI |
| **FAQ institucional** | 5 preguntas en `<details>` animados (privacidad, KYC, regulación, integración, Avalanche) |
| **API demo en vivo** | Botón "Probar la API en vivo" → 5 pasos animados → reemplaza code-block con respuesta JSON real |
| **Smart contract ScoreRegistry** | `contracts/ScoreRegistry.sol` (Solidity 0.8.20) — función `anchorScore(score, grade, hash, confidence)` + evento `ScoreAnchored` + storage `lastScore`/`anchorCount`/`totalAnchors`. Compilado con `solc 0.8.24 --optimize` → artifacts en `build/`. |
| **deploy.html standalone** | Mini-app HTML separada con Core Wallet connect + auto-switch Fuji + `ethers.ContractFactory.deploy()`. One-click deploy + muestra address + tx hash + Snowtrace link + instrucciones de pegado. |
| **Verify page** | Página `/#verify?tx=0x...` con `ethers.JsonRpcProvider(FUJI_RPC)` para leer tx/receipt/block directamente de Fuji. Caso demo (tx hardcoded) renderiza payload completo (score, grade, datapoints, address, block). |
| **Demo mode "María Pérez"** | Botón en login que pre-carga perfil completo: 9 docs en historial (incluye 2 cripto: USDT remesa + USDC freelance), tx demo persistida en localStorage, badge "On-chain" activo desde el primer segundo. |
| **5to stat institucional** | `$155B · Remesas LATAM/año · ingresos hoy invisibles para el score`. Stats-bar pasó a `grid-template-columns: auto-fit minmax(200px, 1fr)` para escalar. |
| **Step 01 con crypto** | "Cómo funciona" → Capturar ahora menciona explícitamente **hashes de transacciones cripto** (USDC/USDT, remesas on-chain). |
| **API key segura (config.js)** | API key sale del repo público — vive solo en `config.js` (gitignored) cargado en runtime. Fallback al input manual si no existe. `config.example.js` queda como template. |
| **Deploy producción** | Firebase Hosting → https://snowscore-709be.web.app |
| **API key segura** | Restringida por HTTP referrer (web.app, firebaseapp.com, localhost) + Gemini API only |
| GitHub | Repo: github.com/All-Aideas/SnowScoring (branch: master) |
| README + MANUAL | README técnico + MANUAL.md de usuario step-by-step |

### ⏳ Pendiente

| Tarea | Responsable | Notas |
|-------|------------|-------|
| AVAX en Fuji | Cesar | Builder Hub faucet (con Core conectada) → pedir 2 AVAX a `0x621…90DF` |
| Deploy ScoreRegistry | Cesar | Abrir `deploy.html` → conectar Core → click "Deploy" → copiar address |
| Pegar address en index.html | Cesar | Constante `SCORE_REGISTRY_ADDRESS` (vacía por default — anchor cae a self-tx hasta que la setees) |
| Test anchor end-to-end | Cesar | Login demo (María) → subir doc → Certificar on-chain → verificar tx en Snowtrace + en /#verify |
| Redeploy Firebase | Cesar | `firebase deploy --only hosting:snowscore-709be` |
| Grabar video demo | Cesar (notebook) | 60-90 seg. Guion en CLAUDE.md §9 |
| Slides finales | Cesar | Domingo (max 1h, opcional) |

### ✅ Entregables no-código

| Item | Estado |
|------|--------|
| Deck extenso (12-15 slides) | ✅ Listo |
| Pitch deck corto (5-6 slides) | ✅ Listo |
| Notion del proyecto | ✅ Actualizado |

---

## Brand System

| Token | Valor | Uso |
|-------|-------|-----|
| `--deep-blue` | `#1E3A8A` | Logo, títulos, elementos institucionales |
| `--violet` | `#7C3AED` | IA, innovación, CTAs, gradiente |
| `--light-blue` | `#3B82F6` | Interfaces, iconos, info secundaria |
| `--turquoise` | `#14B8A6` | Score, métricas, estados positivos |
| `--lavender` | `#EDE9FE` | Cards, fondos suaves, secciones secundarias |
| Gradiente oficial | `#1E3A8A → #7C3AED → #14B8A6` | Score card, botones CTA, highlights |

**Tipografía principal:** Poppins (400/500/600/700/800)
**Tipografía técnica:** JetBrains Mono (400/500/700)

### Brand assets
- `brand/logo.svg` — 512×512 — copo de nieve (6 puntas) con hexágono central (bloque blockchain). Aplicado como favicon + logo del topbar (`.logo-mark` background).
- `brand/cover.svg` — 840×300 — fondo gradiente + snowflake + wordmark + tagline "Tu consumo construye tu identidad financiera".
- Concepto del logo: copo de nieve (Snow / Avalanche) + hexágono central (bloque blockchain) con gradiente oficial.

---

## Stack técnico

| Capa | Tecnología |
|------|-----------|
| Frontend | HTML + CSS + JS vanilla, single-file |
| AI | Gemini 2.5 Flash (multimodal, JSON mode) |
| Blockchain | Avalanche C-Chain Fuji — real anchoring vía ethers.js v6 + Core Wallet |
| Hosting | Firebase Hosting (snowscore-709be.web.app) |

---

## Deploy

Live: **https://snowscore-709be.web.app**

```bash
firebase deploy --only hosting:snowscore-709be
```

Config:
- `firebase.json`: target `snowscore-709be`, public `.`
- `.firebaserc`: default project `acta-insights-sj5w4`, target → site `snowscore-709be`

---

## Wallet + On-chain (cómo funciona)

- **Provider:** `window.avalanche` (Core) → fallback `window.ethereum` (MetaMask)
- **Chain:** Fuji testnet (chainId `0xa869` / 43113), RPC `https://api.avax-test.network/ext/bc/C/rpc`
- **Auto-switch:** si el usuario está en otra red, la app llama `wallet_switchEthereumChain` y, si no existe, `wallet_addEthereumChain`
- **Anchor:** `ethers.keccak256(ethers.toUtf8Bytes(JSON.stringify(scoreData)))` → self-tx con ese hash en `data`
- **Verificación:** cualquier banco recalcula keccak256 del score y compara con el hash anclado en Snowtrace
