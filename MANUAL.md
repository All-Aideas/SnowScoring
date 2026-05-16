# SnowScore — Manual de usuario

> Guía paso a paso para usar SnowScore: subir documentos, generar score, conectar wallet y certificar on-chain en Avalanche Fuji.

**URL en producción:** https://snowscore-709be.web.app
**Repo:** https://github.com/All-Aideas/SnowScoring

---

## 1. ¿Qué hace SnowScore?

SnowScore convierte tus **tickets, facturas y extractos bancarios** en un **score de comportamiento financiero** (0–100) certificado on-chain en Avalanche. Pensado para personas sin historial crediticio que igual tienen patrones de consumo estables.

**Flujo end-to-end:**

1. Subís fotos de documentos desde el navegador
2. Un Agente de Razonamiento Financiero (Gemini 2.5 Flash) extrae datos y razona sobre patrones
3. Se calcula un SnowScore (0–100) + grado (A+ a D)
4. Conectás tu Core Wallet y certificás el score en Avalanche Fuji (testnet)
5. La transacción queda verificable en Snowtrace

---

## 2. Requisitos previos

| Requisito | Para qué |
|-----------|----------|
| Navegador moderno (Chrome, Brave, Edge) | Correr la app |
| Extensión **Core Wallet** (https://core.app) | Conectar y firmar la certificación on-chain |
| Algo de **AVAX en Fuji testnet** | Pagar el gas de la transacción (≈ 0.001 AVAX) |
| Conexión a internet | API de Gemini + RPC de Avalanche |

> Si no tenés Core Wallet: instalala desde core.app, creá una nueva wallet y guardá la seed phrase. **Nunca uses una wallet con fondos reales para hackathons o demos.**

---

## 3. Conseguir AVAX en Fuji testnet

El AVAX de Fuji es gratuito (no tiene valor real). Opciones:

1. **Builder Hub Faucet** (recomendado, requiere wallet conectada):
   - Andá a https://build.avax.network/
   - Conectá tu Core Wallet
   - Buscá "Faucet" → pedí 2 AVAX

2. **Core App Faucet:**
   - https://core.app/tools/testnet-faucet/?subnet=c&token=c
   - Pegá tu address o conectá Core

3. **Snowtrace:** verificá que el AVAX llegó en https://testnet.snowtrace.io/address/TU_ADDRESS

---

## 4. Flujo de uso de la app

### 4.1. Landing page

1. Abrí https://snowscore-709be.web.app
2. Leé la propuesta, scrolleá hasta ver el flow diagram, las stats y la API docs
3. En la sección **API** podés probar la API en vivo con el botón **"Probar la API en vivo →"** (simula un POST /v1/score y reemplaza el code-block con la respuesta JSON real con score/grade/confidence/proof)
4. Más abajo está la sección **"Para Instituciones"** (Bankaool, Arkangeles, Fintechs LATAM) y el **FAQ institucional** (privacidad, KYC, regulación, integración, Avalanche)
5. Click en **"Comenzar"** (botón violeta arriba a la derecha)

### 4.2. Login

Tenés 2 opciones:

**A. Login normal (cualquier email):**
1. Ingresá cualquier email (ej: `cesar@cesarriat.com`) y cualquier password
2. Click **"Entrar"**
3. *Nota: el login es mock — no hay backend real, cualquier email entra.*

**B. Modo demo "María Pérez" (recomendado para jurado):**
1. Click en la pill **"Modo demo · María Pérez"** abajo del login
2. Entrás directo con un perfil pre-poblado: 9 documentos en historial (incluye **remesas USDT** y **cobros USDC**), tx demo persistida y badge on-chain activo desde el primer segundo
3. Pensado para mostrar la app llena de datos sin necesidad de subir nada

### 4.3. Dashboard

Vas a ver:
- **Score card:** SnowScore 87/100, Grado A−, datos, recurrentes, cobertura, estado on-chain
- **Insights:** distribución de gastos por categoría + flujo mensual
- **Bancos:** mock de Galicia / Naranja X / Mercado Pago para "conectar"
- **Subir documento:** área de drag & drop + tabs por tipo
- **Historial:** últimos documentos analizados

### 4.4. Subir un documento

1. Click en **"+ Agregar documento"** arriba a la derecha, o arrastrá una imagen al área de drop
2. Elegí el tipo:
   - **Ticket / Factura** — recibo de servicio, factura de luz, ticket de super
   - **Extracto bancario** — resumen de cuenta o movimientos
   - **Cripto / Hash** — screenshot de wallet, explorador (Snowtrace, Etherscan, Tronscan) o app de exchange con un cobro/remesa en stablecoin. Sirve para acreditar **ingresos cripto** (freelance USDC, remesas familiares USDT) que el sistema bancario no ve.
3. Click **"Analizar con Gemini"**
4. Esperá ~10 segundos mientras corre el agente (verás 5 pasos animados)
5. Aparecen los resultados:
   - Señal de comportamiento (frase corta)
   - Datos extraídos (comercio, categoría, monto, fecha, recurrencia)
   - JSON estandarizado completo
   - Bloque violeta con botón **"Certificar on-chain"**

> El documento queda agregado al historial automáticamente.

### 4.5. Conectar tu Core Wallet

1. En el dashboard, arriba a la derecha hay un botón violeta **"Conectar Wallet"**
2. Click → Core abre un popup pidiendo permisos
3. Aceptá la conexión
4. Si no estás en Fuji, Core te pide cambiar de red → aceptá
5. El botón pasa a mostrar `0x621…90DF · Fuji` con fondo gradiente

### 4.6. Certificar el score on-chain

1. Después de analizar un documento, andá al bloque violeta **"Certificación on-chain · Avalanche Fuji"**
2. Click **"Certificar on-chain ↗"**
3. La app calcula `keccak256(JSON.stringify(scoreData))` y manda una self-transaction con ese hash en el campo `data`
4. Core te muestra el popup → confirmá
5. Esperá ~2 segundos a que se mine el bloque
6. Aparece un bloque verde con:
   - Hash de la transacción
   - Link directo a Snowtrace para verificarla
7. El footer se actualiza con el hash anclado
8. En el header del dashboard aparece un **badge persistente "On-chain · 0x…"** con dot pulsante turquesa (clickeable, abre Snowtrace). El badge sobrevive al reload de la página gracias a `localStorage`.

> El costo es ≈ 0.001 AVAX (centavos de testnet, no tiene valor real).

---

## 5. Verificar la certificación en Snowtrace

1. Click en **"Ver en Snowtrace ↗"** desde la app, o copiá el hash y andá a `https://testnet.snowtrace.io/tx/TU_HASH`
2. En la página verás:
   - Status: Success
   - From / To: tu address (self-transaction)
   - Value: 0 AVAX
   - Input Data: el hash keccak256 del score (esa es la prueba de integridad)

Cualquier banco o fintech puede recalcular `keccak256(scoreData)` y verificar que coincide con el hash anclado. Si los datos fueron modificados después, los hashes no van a coincidir.

### 5.1. Verificación dentro de la app (`/#verify`)

Para que un banco/fintech no tenga que salir a Snowtrace, la app trae una **página de verificación propia**:

1. Andá a https://snowscore-709be.web.app/#verify o click en **"Verificar"** del menú superior
2. Pegá un hash de transacción (`0x` + 64 chars hex)
3. Click **"Verificar"** — la app consulta Fuji directamente via RPC (`ethers.JsonRpcProvider`) y muestra:
   - Score recuperado del payload anclado
   - Grade, confidence, datapoints
   - Address del firmante, número de bloque, timestamp
   - Link a Snowtrace para auditoría externa
4. La tx demo del modo María Pérez funciona offline (payload hardcoded) — útil para el pitch.

---

## 6. Smart contract ScoreRegistry (avanzado)

Por defecto la app ancla el score como **self-transaction** (el hash va en `data`). Para una versión más institucional, el repo trae un contrato real:

- `contracts/ScoreRegistry.sol` — almacena `score`, `grade`, `hash`, `confidence`, `timestamp`, `nonce` por usuario + emite evento `ScoreAnchored`
- `deploy.html` — mini-app standalone para deployarlo con un click

**Cómo deployarlo:**

1. Abrí `deploy.html` (local o subido a Firebase) en el browser con Core Wallet conectada
2. Click **"Conectar Wallet"** → la app auto-switchea a Fuji
3. Click **"Deploy ScoreRegistry"** → Core te pide firmar la tx de deploy (~ 0.01 AVAX de gas)
4. Cuando se mina, copiá la address que aparece
5. Pegala en `index.html` en la constante `SCORE_REGISTRY_ADDRESS = "0x..."`
6. Redeploy a Firebase: `firebase deploy --only hosting:snowscore-709be`
7. Desde ahora, "Certificar on-chain" llama al contrato (con fallback a self-tx si la address está vacía)

---

## 7. Privacidad y seguridad

- La API key de Gemini está **restringida por HTTP referrer** a `snowscore-709be.web.app`, `snowscore-709be.firebaseapp.com` y `localhost`. No se puede usar desde otros dominios.
- En producción real, la API key debería estar detrás de un backend. Esto es una limitación conocida del MVP de demo.
- **No subas documentos con datos sensibles reales.** Usá facturas viejas o material de prueba.

---

## 8. Troubleshooting

| Problema | Solución |
|----------|---------|
| El botón "Conectar Wallet" no hace nada | Instalá Core Wallet (https://core.app) y recargá la página |
| Core dice "Wrong network" | Click en "Conectar Wallet" otra vez — la app cambia a Fuji automáticamente |
| "Insufficient funds for gas" | Conseguí AVAX de Fuji en el faucet (ver sección 3) |
| Gemini devuelve JSON vacío | El documento es ilegible. Probá con otra foto, mejor iluminada |
| El botón "Certificar on-chain" dice "Conectá tu wallet primero" | Hacé click primero en "Conectar Wallet" arriba del dashboard |
| La página no carga `window.ethers` | Hard refresh con Ctrl+Shift+R (caché de Firebase Hosting) |

---

## 9. Stack técnico (resumen)

- **Frontend:** HTML + CSS + JS vanilla, single-file (`index.html`)
- **IA:** Gemini 2.5 Flash multimodal vía REST
- **Blockchain:** Avalanche C-Chain Fuji (chain ID 43113), ethers.js v6
- **Hosting:** Firebase Hosting (`snowscore-709be.web.app`)
- **Wallet:** Core Wallet (provider `window.avalanche`, fallback `window.ethereum`)

---

## 10. Roadmap post-hackathon

- Backend con autenticación real (Auth0 / Firebase Auth)
- API key de Gemini detrás del backend
- Smart contract dedicado en Avalanche para certificación masiva
- SBT (Soulbound Token) por usuario con su SnowScore actualizado
- Integraciones B2B con Bankaool y Arkangeles
- Webhook para notificar a entidades cuando un score cambia

---

**Hecho con ❤ por Cesar Riat para el Avalanche LatAm Institutional Hackathon 2026.**
