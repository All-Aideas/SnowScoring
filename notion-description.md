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

## 7. Stack del MVP (hackathon build)

- **Frontend:** HTML + CSS + JavaScript vanilla (single-file, deployable en Firebase Hosting)
- **AI:** Gemini 2.0 Flash API (multimodal vision + JSON mode)
- **Blockchain (roadmap):** Avalanche Fuji Testnet, smart contract en Solidity para emisión de SBT
- **Auth (mock):** simulación de login con email/Google/Wallet
- **Hosting:** Firebase Hosting o cualquier static host

### Pantallas implementadas

1. **Landing page** con propuesta de valor, stats y documentación de API
2. **Login** con múltiples métodos (email, Google, Core Wallet)
3. **Dashboard** con score actual, upload multi-formato (tickets / extractos / otros), análisis en vivo con Gemini, e historial estandarizado

---

## 8. Roadmap

**Hackathon (MVP actual)**

- ✅ Procesamiento de documentos con Gemini
- ✅ Standardización a schema único
- ✅ UI completa (landing + login + dashboard)
- ✅ Mock del on-chain proof

**Post-hackathon (3 meses)**

- Smart contract de SBT en Avalanche Fuji → mainnet
- API pública con autenticación y rate limiting
- Integración real con wallets (Core, MetaMask)
- Primeros pilotos con fintechs LATAM

**Escala (6–12 meses)**

- Subnet dedicada en Avalanche para identidad financiera
- Compliance regulatorio (BCRA, CNV en Argentina; equivalentes regionales)
- Expansión a México, Colombia y Brasil
- SDK oficial para integradores

---

## 9. Por qué ganamos este hackathon

- **Impacto social real:** inclusión financiera medible en una región subatendida
- **Uso avanzado de IA:** no es un wrapper de GPT, es un Financial Reasoning Agent con prompt estructurado y razonamiento sobre patrones
- **Blockchain con sentido técnico:** Avalanche aporta valor real (finalidad, costo, portabilidad), no es una blockchain pegada a la fuerza
- **Modelo de negocio claro:** no monetizamos al usuario vulnerable, sino a las instituciones que necesitan los datos
- **Mercado masivo:** 1.4B de adultos no bancarizados globalmente, 70% de jóvenes LATAM sin historial

---

*SnowScore — La capa de confianza que le faltaba a la economía de los invisibles.*
