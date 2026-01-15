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
- Add a Google Fonts link for the declared font and centralize visual tokens (colors/spacing) into CSS variables; the Bootstrap JS imports have been removed from `src/index.js` (status: resolved).

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
- Add a font host or Google Fonts link for 'Source Sans Pro' in `public/index.html` to ensure consistent typography across platforms.
- Centralize colors, spacing and type scale into CSS custom properties in `src/main.css` (e.g., :root { --color-primary: #00917C; --sp-1: 8px; --fs-base: 16px; })
- Bootstrap JS imports have been removed from `src/index.js` — this reduces interop risk. Only reintroduce them (with Elm ports/isolation) if you need JS-driven components.

<!-- End of AGENTS.md -->
