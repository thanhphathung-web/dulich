# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Baggio Travel is a Vietnamese tour operator web app. The frontend is **pure HTML/CSS/JS with no build step, no framework, and no npm** — each page is a self-contained single-file app. The backend (Node.js + Express + Prisma) is a separate service referenced in docs but not present in this repo.
Vietnamese travel booking website. Frontend-only (HTML/CSS/JS), deployed on Vercel.
Backend: Supabase (browser JS client directly, no Node.js/Express).
## Running the project

Open any `.html` file directly in a browser, or serve the directory with any static file server:

```bash
npx serve .        # or python -m http.server
```

Vercel handles deployment; routing is defined in `vercel.json` (e.g. `/admin` → `baggio-admin.html`).

## Architecture

### Frontend — single-file apps

Every HTML file is fully self-contained: inline `<style>`, inline `<script>`, and a CDN `<script>` tag for Supabase JS. There is no shared CSS file, no module bundler, and no component library.

**Two categories of files:**
- **Live files** (connect to real Supabase): `index.html`, `baggio-booking-live.html`, `baggio-cms.html`, `baggio-comms.html`, `baggio-guides-mgmt.html`, `baggio-operations.html`, `baggio-report.html`, `baggio-suppliers.html`, `baggio-tour-detail.html`
- **Prototype/docs files** (static or placeholder data): `baggio-booking-engine.html`, `baggio-admin.html` (has `xxxx` placeholder credentials), plus all the `baggio-*-guide.html` / `baggio-*-api.html` reference docs

### Supabase config pattern

Live files declare two globals at the very top `<script>` block:

```js
const SUPABASE_URL  = 'https://lfnlezfphwjtdunyungi.supabase.co'
const SUPABASE_ANON = 'eyJhbGci...'  // anon public key
```

`baggio-admin.html` and `baggio-booking-engine.html` still have `xxxx` placeholder values and must be updated before they work live.

### CSS design system

Each file defines CSS custom properties in `:root`. The public-facing pages use a warm editorial palette:

```css
--ink:#111118; --cream:#faf8f3; --red:#c5372b; --gold:#b8860b; --teal:#1a6b5e;
--font:'Be Vietnam Pro'; --serif:'Playfair Display'; --mono:'Space Mono';
```

Admin/tool pages use a dark developer palette (`--bg:#080b10`, blue/green/amber/red accent tokens).

### Backend API (separate service — not in this repo)

- **Stack:** Node.js 20, Express 5, Prisma ORM, PostgreSQL via Supabase
- **Auth:** JWT, `Authorization: Bearer <token>` header
- **Rate limiting:** 100 req / 15 min / IP globally; webhook endpoint uses `express.raw()` for signature verification
- **CORS whitelist:** `https://baggiotravel.com`, `http://localhost:3000`
- **Key routes:** `/api/tours`, `/api/bookings`, `/api/payments`, `/api/users`, `/api/guides`
- **Webhook:** `POST /api/payment/webhook` (MoMo / VNPay)

Backend `.env` keys: `DATABASE_URL`, `DIRECT_URL`, `JWT_SECRET`, `JWT_EXPIRES_IN`, `RESEND_API_KEY`, `FROM_EMAIL`, `FRONTEND_URL`

### AI Chatbot

`baggio-chatbot.html` calls the Claude API **directly from the browser**. The API key is entered by the user at runtime via a modal — it is never hardcoded. Do not change this pattern.

### Vercel routing

`vercel.json` maps clean URLs to the underlying `.html` files. Update it whenever a new page is added or a file is renamed.

## Key reference docs (in-repo HTML files)

| File | What it documents |
|---|---|
| `baggio-backend-api.html` | REST API endpoints, auth flow, middleware |
| `baggio-database-schema.html` | ERD + schema for all DB tables |
| `baggio-email-system.html` | 5 transactional email templates (Resend + React Email) |
| `baggio-deploy-guide.html` | Full Vercel + Supabase deploy walkthrough |
| `baggio-seo-guide.html` | Meta tags, schema.org structured data, sitemap |
| `docs/project_summary.md` | Tech stack overview and per-file feature summary |

## Tech Stack
- Pure HTML/CSS/JS (no frameworks)
- Supabase: https://lfnlezfphwjtdunyungi.supabase.co
- MyMemory API for translation (VI/EN)
- Chart.js for admin dashboards
- Fonts: Be Vietnam Pro, Playfair Display

## Key Rules
- NO server-side code — all Supabase calls from browser JS client
- Multilingual: VI columns = _vi suffix, EN columns = _en suffix
- Always verify column names against actual DB schema before writing queries
- Column renames affect ALL files — audit before renaming

## Active Files
- index.html: Homepage + search
- baggio-cms.html: Tour/blog management
- baggio-admin.html: Admin dashboard
- baggio-booking-live.html: Live booking flow
- baggio-account.html: Customer account (Google OAuth)

## Supabase Tables
- tours (name_vi, name_en, destination, price...)
- customers (user_id, profile data)
- bookings
