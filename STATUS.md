# SnowScore — Estado del proyecto

> Última actualización: 2026-05-15

## Estado general
**Hackathon Avalanche** · Deadline: Domingo 9:00 AM

---

## MVP — Componentes

### ✅ Completado

| Componente | Detalle |
|-----------|---------|
| Landing page | Hero + stats + flow diagram + how it works + API docs + pricing + use cases |
| Flow diagram visual | Tickets+Banco → IA → Score/Avalanche → Entidades. Dark section, responsive. |
| Login | Mock: email / Google / Core Wallet. Cualquier email entra. |
| Dashboard | Score 87/A-, greeting dinámico por email. |
| Upload | Drag & drop + tabs (Ticket / Extracto bancario / Otro) |
| Financial Reasoning Agent | Gemini 2.0 Flash integrado, JSON mode, prompt LATAM-aware |
| Loading state | 5 pasos animados (visión → normalización → razonamiento → scoring → on-chain) |
| Resultados | Behavioral signal + tabla de datos + JSON del schema output |
| Historial | Auto-append al subir documento, mock de 5 entradas pre-cargadas |
| Spending breakdown | Barras por categoría hardcodeadas (Alquiler 42%, Utilities 22%...) |
| Monthly flow | Mini chart 6 meses, mes actual en violeta |
| Bank connect | Mock: Galicia / Naranja X / Mercado Pago con estado "Conectado" |
| Descarga reporte | JSON descargable con score, categorías, on-chain proof, privacy note |
| Brand system | Poppins + gradiente #1E3A8A→#7C3AED→#14B8A6, border-radius, cards |
| Responsive | Mobile-first, sidebar oculta en mobile |
| On-chain mock | Hash 0xb47f...c91a + link Snowtrace en footer |
| GitHub | Repo: github.com/All-Aideas/SnowScoring (branch: master) |
| README | Completo: problema, solución, API, schema, stack, roadmap |

### ⏳ Pendiente

| Tarea | Responsable | Notas |
|-------|------------|-------|
| Deploy | Cesar | GitHub Pages: Settings → Pages → master/(root) → Save. URL: https://all-aideas.github.io/SnowScoring/ |
| Grabar video demo | Cesar (notebook) | 60-90 seg. Guion en CLAUDE.md §9 |

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

---

## Stack técnico

| Capa | Tecnología |
|------|-----------|
| Frontend | HTML + CSS + JS vanilla, single-file |
| AI | Gemini 2.0 Flash (multimodal, JSON mode) |
| Blockchain | Avalanche C-Chain Fuji (mock visual) |
| Hosting | GitHub Pages (recomendado) / Firebase Hosting |

---

## Deploy rápido (GitHub Pages)

1. Ir a **github.com/All-Aideas/SnowScoring/settings/pages**
2. Source: `Deploy from a branch`
3. Branch: `master` / `(root)`
4. **Save** → Live en `https://all-aideas.github.io/SnowScoring/`
