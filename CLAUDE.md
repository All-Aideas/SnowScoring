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
