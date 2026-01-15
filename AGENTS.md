# Website: architecture summary & quick audit

## Summary
The `website/` folder is a small single-page site built with Elm. The compiled Elm app is bootstrapped from `src/index.js` which mounts `Elm.Main` into the DOM node with id `root` provided by `public/index.html`. Styling is provided by `src/main.css`, and static assets (icons, images used by Elm) live in `public/`. `src/Main.elm` is a single Elm Browser.element module that holds the Model, Update, and a large View composed of many helper functions. The project also includes a `serviceWorker.js` helper (Create‑React‑App style) which is imported but not registered by default (`serviceWorker.unregister()` in `src/index.js`).

## Notable patterns & conventions
- Single-page mounting: Elm owns the DOM under `<div id="root">` and is initialised via `Elm.Main.init({ node: ... })` in `src/index.js`.
- Monolithic Elm view: `src/Main.elm` contains a large set of view helper functions and the entire UI in one module (Model is small: time + referrals filter).
- Public assets: images and manifest live in `public/` and are referenced by Elm view code via filenames.
- Build/bootstrapping: JS entry point `src/index.js` imports the Elm module, global CSS, third‑party CSS and the service worker helper.

## Primary inconsistency / anti-pattern
Name: Mixing imperative JS DOM libraries with Elm without explicit interop ✅

Explanation: `src/index.js` now imports only `bootstrap/dist/css/bootstrap.css` (Bootstrap CSS). Earlier imports of `jquery`, `popper.js`, and Bootstrap's JS were removed from the file; this reduces the risk of accidental DOM-manipulation conflicts.

Why it matters: Importing imperative libraries (like jQuery or Bootstrap's JS) alongside Elm without an explicit interop boundary can lead to:
- Conflicting DOM updates and unpredictable UI behavior (if the libraries manipulate elements Elm owns)
- Hard-to-debug event ordering and lifecycle issues
- Violations of Elm's guarantees about immutability and predictable updates

Suggested minimal remediation / status: The JS imports have been removed (good). If you only need Bootstrap for styling, keep `bootstrap/dist/css/bootstrap.css` (as currently present). If you need JS-driven widgets (dropdowns, tooltips, modals), implement a small interop layer using Elm ports and only let the JS operate on DOM elements that are intentionally outside Elm's control.

## One-line next step
- Centralize visual tokens (colors/spacing/typography) into CSS variables; the Bootstrap JS imports have been removed from `src/index.js` (status: resolved). Trebuchet MS is set as the preferred system font and no external fonts are loaded.

## Progress checklist (done)
- [x] Inspect `website/src/main.css` and extract colors/components/breakpoints
- [x] Inspect `website/src/Main.elm` to map classes and inline layout styles
- [x] Inspect `website/public/index.html` for font/script usage
- [x] Inspect `website/src/index.js` and confirm Bootstrap CSS import (JS imports removed)
- [x] Draft Design Guidelines summary based on files above
- [x] Insert Design Guidelines into `website/AGENTS.md`
- [x] Update `website/AGENTS.md` to reflect removal of Bootstrap JS imports
- [x] Validate `website/AGENTS.md` for syntax/errors
- [x] Add Google Fonts link to `public/index.html` and apply global font in `src/main.css` (later removed when Trebuchet was chosen)
- [x] Centralize basic tokens (colors/spacing/typography) in `src/main.css` via :root CSS variables
- [x] Set `Trebuchet MS` as the preferred default font and removed Google Fonts link from `public/index.html`

## Design Guidelines
Below is a concise summary of the visual system used by the site (extracted from `website/src/main.css` and the Elm view in `website/src/Main.elm`). Use this as a quick reference for colors, typography, spacing, layout, components, responsive rules, and file/selector traceability.

### 1) Color palette
- Primary (brand/CTA green): #00917C (used for .dropbtn, .referral-button, focus/border accents)
- Accent / secondary colors:
  - Dark teal / text accent: #293C4B (main body/headings color, used in .content, .mentee-card-title, table text)
  - Red (alert/negative): #C15050 (used in .red-border)
  - Blue accent: #28527A (used in .blue-border)
- Neutrals and surfaces:
  - Light border / muted: #E0E0E0 (borders, table dividers)
  - Very light background: #F8F9FA (table header, hover backgrounds)
  - Body text muted: #555 / #666 (supporting copy, disclaimers)
  - White: #FFFFFF (card & table backgrounds)
- Hover state for some CTAs: #007D6A (derived hover color for .referral-button)

Notes: Colors are hard-coded in `src/main.css`. Consider centralizing with CSS variables (e.g., --color-primary) for maintainability.

### 2) Typography
- Base font family (content): 'Source Sans Pro', 'Trebuchet MS', 'Lucida Grande', 'Bitstream Vera Sans', 'Helvetica Neue', sans-serif (declared on `.content`).
- Sizing examples found in CSS:
  - `.content` sets font-size: 120% (relative base for body copy)
  - `.footer` uses font-size: 70%
  - `.edo-testimonial` uses font-size: 1.1em
- Weights: bold is used for headings, `.mentee-card-title`, and `.product-name` (via font-weight: bold).

Notes: There is no <link> to load 'Source Sans Pro' in `public/index.html`. Either add a Google Fonts import or self-host the font. Also consider declaring a typographic scale and line-height variables (e.g., --fs-base, --lh-base) for consistency.

### 3) Spacing scale
- Common spacing units used (px): 4/8/12/15/16/20/24/30/40 roughly appear across rules.
- Examples:
  - `.header` margin-top: 24px
  - `.logo` margin: 20px 0; max-width: 200px
  - `.mentee-card` padding: 20px; gap between cards: 20px (30px on larger screens)
  - `.referral-table` cell padding: 15px 12px
- Recommendation: adopt a simple spacing scale (4,8,16,24,32) and convert repeated values to variables.

### 4) Layout & grid
- The Elm markup uses a Bootstrap `.container` wrapper (in `src/Main.elm`) and a small set of flex-based layouts in CSS.
- Key layout patterns:
  - Header area: a flex row with avatar + copy (inline styles in `Main.elm` using style "display" "flex" and style "flex" values)
  - `.mentee-showcase`: column on small screens, switches to row via @media (min-width: 768px) and each `.mentee-card` flex:1
  - `.responsive-iframe-container`: aspect-ratio-preserving container for embedded videos; changes to fixed width/height at @media (min-width: 1024px)

### 5) Common components & classes
- Navigation: `.navigation`, `.navigation ul`, `.navigation li` — simple inline list aligned right.
- Dropdown menu: `.dropdown`, `.dropbtn`, `.dropdown-content` — CSS-only hover dropdown (no JS required).
- Cards / showcase: `.mentee-showcase`, `.mentee-card`, `.mentee-card-title`, `.mentee-card-content` — minimal card with border, no shadow.
- Tables: `.referral-table`, responsive table rules for mobile that turn rows into stacked blocks and use `data-label` for labels.
- Search input: `.search-input` with focus state border-color: #00917C.
- Buttons / links: `.referral-button` (primary CTA look), `.deco-none` (link without decoration), and border helper classes `.red-border`, `.green-border`, `.blue-border`.
- Testimonial: `.edo-testimonial` (italic, light gradient background)

### 6) Responsive breakpoints / media queries
- Major breakpoints used in CSS:
  - @media (min-width: 768px) — layout switches for `.mentee-showcase`.
  - @media (min-width: 1024px) — video iframe switches to fixed size (840x472.5)
  - @media (max-width: 768px) — `.referral-table` becomes stacked block-style rows for mobile
- The project also uses Bootstrap, so the Bootstrap grid breakpoints are available if used in Elm markup.

### 7) Utility classes / helpers
- `.deco-none` — removes link decoration while inheriting color.
- `.red-border`, `.green-border`, `.blue-border` — left-border accents with hover background states.
- `.responsive-iframe-container` — reusable video wrapper.

### 8) Bootstrap usage & overrides
- `src/index.js` imports `bootstrap/dist/css/bootstrap.css` (Bootstrap CSS). Previously, JS imports for Bootstrap (`jquery`, `popper.js`, `bootstrap`) were present but have been removed.
- The site primarily relies on custom CSS (`src/main.css`) and Elm for layout. Bootstrap provides the `.container` wrapper and any optional components but many styles are overridden (cards, tables, buttons use custom styles).
- Recommendation: keep Bootstrap CSS for its grid/container utilities if desired. Only reintroduce Bootstrap's JS (and its dependencies) if you intentionally require JS-driven widgets — when you do, implement Elm ports or isolate that DOM and clearly document the interop.

### 9) File & selector references (traceability)
- Primary stylesheet: `website/src/main.css` — contains the selectors and rules described above (search for: `.content`, `.mentee-card`, `.referral-table`, `.responsive-iframe-container`, `.dropdown`, `.dropbtn`, `.search-input`).
- Elm view & markup: `website/src/Main.elm` — contains markup classes and inline styles (search for: `class "container content"`, `class "logo"`, `class "mentee-card"`, `class "dropdown"`, `class "responsive-iframe-container"`, `id "referrals"`).
- HTML shell: `website/public/index.html` — head, analytics scripts and places to add font link if needed.
- JS entry: `website/src/index.js` — imports `main.css` and `bootstrap/dist/css/bootstrap.css` (CSS only).

### 10) Quick usage examples
- Primary CTA:
  - Use: <span class="referral-button">Invite</span>
  - Class: `class="referral-button"` (applies green background, white text, padding and rounded corners)

- Responsive video wrapper:
  - Markup: <div class="responsive-iframe-container"> <iframe src="..."> </iframe> </div>

- Card tile:
  - Markup: <div class="mentee-card"> <h4 class="mentee-card-title">Title</h4> <div class="mentee-card-content">…</div> </div>

### Missing / recommended small improvements
- ✅ DONE: Centralized colors, spacing and type scale into CSS custom properties in `src/main.css` (:root variables now define --color-primary, --color-accent, --sp-1 through --sp-4, --font-sans)
- ✅ DONE: Replaced all hardcoded colors with CSS variables throughout the stylesheet (maintainability improved)
- ✅ DONE: Preferred font set to 'Trebuchet MS' as default system font (no external font loading needed)
- Bootstrap JS imports have been removed from `src/index.js` — this reduces interop risk. Only reintroduce them (with Elm ports/isolation) if you need JS-driven components.

---

## Core Design Philosophy

### 🎨 The Iconic Hover Design (Heart of the Website)

**CRITICAL: This is the signature visual element of the website and must be preserved at all costs.**

The website's most distinctive and recognizable feature is the **colored left-border hover interaction** applied to list items and table rows:

- **Default state:** Each item displays a 5px colored left border (red, green, or blue in rotation)
- **Hover state:** The entire background fills with the border's color, text turns white

**Technical implementation:**
- CSS classes: `.red-border`, `.green-border`, `.blue-border` (defined in `src/main.css`)
- Elm logic: `pickBorder` function in `src/Main.elm` assigns colors based on index modulo
- Color rotation: index % 3 == 0 → red; index % 2 == 0 → green; else → blue

**Why this matters:**
1. **Brand identity** — this interaction is immediately recognizable and unique to the site
2. **User engagement** — the hover effect provides clear visual feedback and delight
3. **Visual hierarchy** — colors help distinguish different content items at a glance

**Protected by design:**
- Border colors use CSS variables (`var(--color-danger)`, `var(--color-primary)`, `var(--color-blue)`) for maintainability while preserving exact behavior
- Any refactoring must validate that hover transitions remain smooth and colors stay consistent
- Visual regression testing should always verify this interaction

**DO NOT:**
- Change the fundamental interaction pattern (border → full background)
- Modify color rotation logic without explicit approval
- Remove or significantly alter hover transitions
- Apply this pattern inconsistently across similar components

**Reference implementation:** See `.red-border`, `.green-border`, `.blue-border` in `website/src/main.css` (lines ~78-110)

---

## Ongoing Refactoring Efforts

**Status:** Active | **Current Score:** 9.6/10 | **Last Updated:** January 15, 2026

### Quick Summary
Recent refactoring efforts have significantly improved code quality while preserving the iconic hover design:
- ✅ CSS variables centralized (colors, spacing)
- ✅ Security hardened (all external links)
- ✅ Mobile responsiveness improved (table labels)
- ✅ Border classes consolidated with CSS variables
- ⚠️ Header layout kept as inline styles (pragmatic trade-off for visual stability)

### Detailed Logs
For complete refactoring history, lessons learned, testing protocols, and technical details, see:

**→ [`REFACTORING_LOG.md`](./REFACTORING_LOG.md)**

This separate log file contains:
- Session-by-session change history
- Detailed "what we tried" vs "what worked" analyses
- Code quality assessments with scores
- Testing protocols and verification steps
- Critical lessons (e.g., when NOT to refactor)
- Utility classes available for future use
- References and best practices

**Key Principle from Refactoring:**
> Not every inline style needs to become a CSS class. When a specific layout is fragile and works perfectly as-is, leave it alone and improve the rest of the codebase. Visual stability trumps code purity.

---

<!-- End of AGENTS.md -->
