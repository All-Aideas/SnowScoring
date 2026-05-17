# SnowScore

**The Credit History API for the Invisible Generation**

> Convertimos tickets, facturas y extractos bancarios en un score de comportamiento financiero verificable, portable y on-chain — accesible por API para bancos, fintechs y prestamistas.

---

## 1. El Problema

En América Latina, **más del 70% de los jóvenes y trabajadores informales no tienen historial crediticio formal**, aunque demuestran capacidad de pago todos los meses: pagan alquiler, servicios, internet, comida, transporte.

El sistema financiero tradicional los marca como "invisibles":

- Sin recibo de sueldo → sin crédito
- Sin tarjeta de crédito → sin historial
- Sin historial → sin acceso a vivienda, microcrédito, ni inclusión financiera real

El paradoja es clara: **no tener tarjeta de crédito no significa no tener responsabilidad financiera.**

---

## 2. La Solución

SnowScore es un **Financial Reasoning Agent** que transforma documentos financieros heterogéneos (tickets, recibos, facturas, extractos bancarios) en un score crediticio estandarizado, certificado on-chain en Avalanche.

El usuario captura un año de su actividad económica con la cámara del celular. Nuestro motor de IA:

1. **Lee** documentos en cualquier formato
2. **Estandariza** los datos a un schema único
3. **Razona** sobre patrones de comportamiento (recurrencia, estabilidad, consistencia)
4. **Certifica** el resultado emitiendo un Soulbound Token en Avalanche C-Chain

El resultado es una reputación financiera que **vive en la wallet del usuario** y puede ser consultada por terceros vía API.

---

## 3. Cómo funciona (flujo funcional)

### Para el usuario final

1. **Registro:** se crea una cuenta con email, Google o wallet (Core Wallet de Avalanche)
2. **Captura:** sube fotos de tickets, facturas y extractos bancarios desde el celular
3. **Procesamiento:** la IA analiza, categoriza y normaliza cada documento en segundos
4. **Score:** se calcula un SnowScore (0–100) y un grade (A+ a D) en base a patrones de comportamiento
5. **Certificación:** se ancla la prueba en Avalanche y se emite un SnowCertificate (SBT)
6. **Portabilidad:** la reputación es del usuario y vive en su wallet — sin importar el banco, país o plataforma

### Para el desarrollador (API)

Bancos, fintechs y prestamistas integran SnowScore con una sola llamada:

```bash
POST https://api.snowscore.xyz/v1/score
Authorization: Bearer sk_live_...

{
  "wallet": "0xA3f...8E2",
  "depth": "12_months"
}
```

Respuesta:

```json
{
  "score": 87,
  "grade": "A-",
  "confidence": 0.94,
  "data_points": 142,
  "recurring_payments": 8,
  "avg_monthly_flow": 340000,
  "on_chain_proof": "0xb47f...c91a",
  "chain": "avalanche-c"
}
```

---

## 4. Arquitectura técnica

| Capa | Tecnología | Función |
|------|-----------|---------|
| **Captura** | Web app responsive (HTML/JS) | Upload de imágenes desde mobile o desktop |
| **Visión + Razonamiento** | Gemini 2.0 Flash (multimodal) | Extracción estructurada + clasificación + análisis de patrones |
| **Estandarización** | Schema JSON unificado | Normaliza tickets, facturas y extractos a un formato único |
| **Scoring** | Lógica determinística + signals de IA | Calcula reliability score y grade |
| **On-chain proof** | Avalanche C-Chain (Fuji testnet) | Hash del score anclado; futuro SBT |
| **API pública** | REST / autenticación por API key | Consulta de scores por terceros (bancos, fintechs) |
| **Privacidad** | Hash on-chain, datos originales off-chain | Los tickets no se publican; solo la prueba |

### Por qué Avalanche

- **Finalidad sub-segundo** → reputación tan fluida como el efectivo
- **Bajos costos de gas** → económicamente viable para usuarios LATAM
- **Subnets/L1s** → posibilidad futura de una subnet dedicada a identidad financiera
- **Ecosistema DeFi maduro** → integración natural con protocolos de préstamo

---

## 5. Modelo de negocio

SnowScore es **gratuito para el usuario final**. Monetizamos cobrando a las instituciones que consumen la API.

| Producto | Precio | Cliente |
|----------|--------|---------|
| Score lookup | USD 0.12 / call | Fintechs, scoring rápido |
| Full report (12 meses) | USD 0.85 / call | Bancos, evaluación de crédito |
| Volume tier (>10k/mes) | Custom pricing | Enterprise |
| Sandbox / Testnet | Free | Desarrolladores |

---

## 6. Casos de uso

- **Microcredit fintechs:** otorgan préstamos a usuarios sin historial bancario con confianza
- **Property rentals:** propietarios verifican solvencia sin pedir recibos de sueldo
- **DeFi protocols:** habilitan préstamos under-collateralized usando reputación on-chain
- **Educación / becas:** verificación de estabilidad económica familiar
- **E-commerce / BNPL:** evaluación rápida para "buy now pay later"

---

## 7. Stack técnico

- **Frontend:** HTML + CSS + JavaScript vanilla (single-page, sin build steps, deployable en cualquier static host)
- **AI:** Gemini 2.5 Flash (multimodal vision + JSON mode estructurado)
- **Blockchain:** Avalanche C-Chain, contrato `ScoreRegistry.sol` (Solidity 0.8.20) con `anchorScore(score, grade, hash, confidence)` + evento `ScoreAnchored`. Anchoring vía Core Wallet + ethers.js v6
- **Crypto primitives:** `keccak256` sobre payload canónico → hash determinístico recomputable en navegador del consumidor
- **Auth:** login simulado para demo (email/Google/Wallet) — gateway productivo en roadmap institucional
- **Hosting:** Firebase Hosting (https://snowscore-709be.web.app)

### Pantallas y endpoints

1. **Landing institucional** con stats, casos de uso, sección institucional (Bankaool / Arkangeles / Fintechs LATAM), FAQ para área de riesgo, demo de API en vivo
2. **Login** con email/Google/Core Wallet + modo demo "María Pérez" pre-cargado
3. **Dashboard** con score, upload multi-formato (tickets / extractos / cripto-hash), análisis en vivo con Gemini, historial estandarizado, conexión a wallet y anchor on-chain
4. **`/verify?tx=0x...`** con lectura on-chain real (`JsonRpcProvider`) + recompute de hash en navegador (`keccak256`) → verificación trust-minimized

---

## 8. Roadmap

### Now — Entregable del hackathon
Stack completo en producción: Reasoning Agent, scoring engine, `ScoreRegistry` en Avalanche, página de verificación pública, narrativa institucional, demo en vivo.

### Q3 2026 — Pilotos
- Primeros 2–3 pilotos en producción con partners LATAM (microcrédito, real estate, BNPL)
- SDKs oficiales en Node, Python y Java
- Gateway productivo de API con auth org-level, rate limiting y billing por call
- Integraciones con cores bancarios (Galicia, Mercado Pago, Naranja X)

### Q4 2026 → 2027 — Capa institucional
- L1 dedicada en Avalanche para identidad financiera (finalidad sub-segundo, reglas soberanas por jurisdicción)
- Certificaciones regulatorias por país: BCRA y CNV (Argentina), CNBV (México), SFC (Colombia), BACEN (Brasil)
- Bridges cross-chain → cualquier protocolo de lending EVM consume el score
- Marketplace de underwriting: los lenders bidean en tiempo real sobre usuarios calificados que opten por compartir score

### 2027 → en adelante
- Cobertura en todas las economías LATAM principales, luego África y Sudeste Asiático
- Protocolo abierto: cualquier institución puede aportar contribuciones al score del usuario (alquiler, telecom, educación) → SnowScore como capa de referencia de trust para la economía no bancarizada

---

## 9. Por qué ganamos este hackathon

- **Impacto social real:** inclusión financiera medible en una región subatendida
- **Uso avanzado de IA:** no es un wrapper de GPT, es un Financial Reasoning Agent con prompt estructurado y razonamiento sobre patrones
- **Blockchain con sentido técnico:** Avalanche aporta valor real (finalidad, costo, portabilidad), no es una blockchain pegada a la fuerza
- **Modelo de negocio claro:** no monetizamos al usuario vulnerable, sino a las instituciones que necesitan los datos
- **Mercado masivo:** 1.4B de adultos no bancarizados globalmente, 70% de jóvenes LATAM sin historial

---

*SnowScore — La capa de confianza que le faltaba a la economía de los invisibles.*
