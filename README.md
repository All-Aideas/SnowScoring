# SnowScore — Credit History API for the Invisible Generation

> *"Their receipts are the new credit bureau."*

SnowScore converts tickets, invoices, and bank statements into a standardized financial behavior score — certified on-chain on Avalanche and accessible via API to banks, fintechs, and lenders.

Built for the **Avalanche LatAm Institutional Hackathon 2026**.

**Live demo:** https://snowscore-709be.web.app
**User manual:** [MANUAL.md](./MANUAL.md)

---

## The Problem

In Latin America, **70% of young people and informal workers have no formal credit history**, even though they demonstrate payment capacity every month: rent, utilities, internet, groceries, transportation.

The traditional financial system marks them as "invisible":
- No payslip → no credit
- No credit card → no history
- No history → no access to housing, microcredit, or real financial inclusion

**The paradox is clear:** not having a credit card doesn't mean not having financial responsibility.

---

## The Solution

SnowScore is a **Financial Reasoning Agent** that transforms heterogeneous financial documents (receipts, invoices, bank statements) into a standardized credit score, certified on-chain on Avalanche C-Chain.

1. **Capture** — User uploads photos of tickets, utility bills, rent receipts, bank statements **and crypto transaction hashes** (USDC/USDT inflows, on-chain remittances)
2. **Reason** — Gemini 2.5 Flash (multimodal) extracts structured data and reasons about behavioral patterns (recurrence, stability, consistency)
3. **Score** — Calculates a SnowScore (0–100) and grade (A+ to D)
4. **Certify** — Anchors a `keccak256` proof hash on Avalanche C-Chain Fuji via Core Wallet — either as self-transaction (default) or by calling the `ScoreRegistry` contract (when deployed)
5. **Share** — Third parties query the score via REST API at $0.12/call and verify integrity on Snowtrace or via the in-app `/verify` page

---

## API

```bash
POST https://api.snowscore.xyz/v1/score
Authorization: Bearer sk_live_...

{
  "wallet": "0xA3f...8E2",
  "depth": "12_months"
}
```

```json
{
  "score": 87,
  "grade": "A-",
  "confidence": 0.94,
  "data_points": 142,
  "recurring_payments": 8,
  "avg_monthly_flow": 480000,
  "on_chain_proof": "0xb47f...c91a",
  "chain": "avalanche-c"
}
```

### Pricing

| Product | Price | Client |
|---------|-------|--------|
| Score lookup | $0.12 / call | Fintechs, quick scoring |
| Full report (12 months) | $0.85 / call | Banks, credit evaluation |
| Volume tier (>10k/month) | Custom | Enterprise |
| Sandbox / Testnet | Free | Developers |

---

## Standardized Schema

Every document is normalized to a single JSON schema:

```json
{
  "doc_type": "receipt | bank | crypto",
  "merchant": "string",
  "category": "utilities | groceries | rent | food | transport | education | health | telecom | income | transfer | other",
  "category_label": "string in Spanish",
  "amount": 42380,
  "currency": "ARS",
  "date": "2026-04-10",
  "is_recurring": true,
  "recurrence_pattern": "monthly",
  "payment_behavior_signal": "Pago puntual de servicio esencial con patrón mensual estable",
  "reliability_score": 91,
  "items_summary": "Factura de electricidad Edenor — período abril 2026",
  "datapoints_extracted": 8
}
```

---

## Brand System

| Token | Value | Usage |
|-------|-------|-------|
| `--deep-blue` | `#1E3A8A` | Logo, titles, institutional elements |
| `--violet` | `#7C3AED` | AI, innovation, CTAs, gradient |
| `--light-blue` | `#3B82F6` | Interfaces, icons, secondary info |
| `--turquoise` | `#14B8A6` | Score, metrics, positive states |
| `--lavender` | `#EDE9FE` | Cards, soft backgrounds |
| Official gradient | `#1E3A8A → #7C3AED → #14B8A6` | Score card, CTA buttons |

**Primary font:** Poppins (400/500/600/700/800) — geometric, clean, accessible
**Technical font:** JetBrains Mono (400/500/700) — code, API, metadata

### Brand assets

| Asset | Path | Size |
|-------|------|------|
| Logo | `brand/logo.svg` | 512×512 |
| Cover | `brand/cover.svg` | 840×300 |

**Concept:** The logo is a six-pointed snowflake (Snow / Avalanche) with a hexagonal block at its center (blockchain certification), rendered in the official gradient. It carries the brand idea: *consumer behavior becomes verifiable on-chain identity*.

---

## Tech Stack

| Layer | Technology | Notes |
|-------|-----------|-------|
| Frontend | HTML + CSS + JS vanilla | Single-file, deployable to any static host |
| Fonts | Poppins · JetBrains Mono | Via Google Fonts CDN |
| AI | Gemini 2.5 Flash | Multimodal vision + JSON mode |
| Auth | Mock (any email works) | No real backend |
| Blockchain | Avalanche C-Chain Fuji | Real self-tx anchoring via ethers.js v6 + Core Wallet |
| Hosting | Firebase Hosting | Live at `snowscore-709be.web.app` |

### Why Avalanche
- **Sub-second finality** → reputation as fluid as cash
- **Low gas costs** → economically viable for LATAM users
- **Subnets/L1s** → future dedicated subnet for financial identity
- **Mature DeFi ecosystem** → natural integration with lending protocols

---

## Value Flow

```
[Tickets + Historial bancario]
        ↓
[Financial Reasoning Agent — Gemini 2.0 Flash Multimodal]
  01 · Extrae datos
  02 · Normaliza schema
  03 · Razona patrones
        ↓
[SnowScore 87 / A− ⟐ Avalanche C-Chain — Hash anclado on-chain]
        ↓
[Bancos / Fintechs / Propiedades / DeFi]
  POST /v1/score · $0.12/call
```

---

## Running Locally

No build steps. Just open the file:

```bash
# Option 1 — direct
open index.html

# Option 2 — local server
npx serve . --listen 3000
```

Then navigate to `http://localhost:3000`, click **Get Started**, and use any email/password to log in.

To analyze a document, you'll need a [Gemini API key](https://aistudio.google.com/apikey) (free tier works).

---

## Use Cases

- **Microcredit fintechs** — Grant loans to users without bank history with confidence
- **Property rentals** — Landlords verify solvency without requesting payslips
- **DeFi protocols** — Enable under-collateralized loans using on-chain reputation
- **Education / scholarships** — Verify family economic stability
- **E-commerce / BNPL** — Quick evaluation for "buy now pay later"

---

## Roadmap

**Hackathon MVP (current)**
- ✅ Document processing with Gemini 2.5 Flash
- ✅ Standardization to unified schema
- ✅ Full UI (landing + login + dashboard)
- ✅ Spending insights + bank connect mock
- ✅ Credit report download (JSON)
- ✅ **Real on-chain anchoring** on Avalanche Fuji via Core Wallet
- ✅ **Persistent anchor state** (localStorage + pulsing badge in dashboard header)
- ✅ **Institutional landing section** for Bankaool, Arkangeles and LATAM fintechs
- ✅ **Institutional FAQ** (privacy, KYC, regulation, integration, Avalanche rationale)
- ✅ **Live API demo button** that simulates a real POST /v1/score response
- ✅ **Crypto / hash document type** (USDC/USDT inflows, on-chain remittances) — first-class citizen in the upload flow
- ✅ **ScoreRegistry smart contract** (`contracts/ScoreRegistry.sol`, Solidity 0.8.20) + one-click `deploy.html`
- ✅ **In-app `/verify` page** — read tx/receipt/block from Fuji via `JsonRpcProvider` and show full score payload
- ✅ **Demo mode "María Pérez"** — login pill that pre-loads 9 documents (including USDT/USDC), persisted demo tx and active on-chain badge
- ✅ API key extracted to gitignored `config.js` (with manual fallback)
- ✅ Live deployment on Firebase Hosting

**Post-hackathon (3 months)**
- Backend with API key proxy + auth
- Dedicated SBT smart contract on Avalanche Fuji → mainnet
- Public API with authentication and rate limiting
- First pilots with LATAM fintechs (Bankaool, Arkangeles)

**Scale (6–12 months)**
- Dedicated Avalanche subnet for financial identity
- Regulatory compliance (BCRA, CNV in Argentina)
- Expansion to Mexico, Colombia, and Brazil
- Official SDK for integrators

---

## Business Model

SnowScore is **free for end users**. We monetize by charging institutions that consume the API.

> We don't monetize the vulnerable user — we charge the institutions that need the data.

---

*SnowScore — The trust layer the invisible economy was missing.*

Built by [Cesar Riat](https://cesarriat.com) · Powered by Gemini · Anchored on Avalanche
