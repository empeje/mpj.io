# Website: architecture summary & quick audit

## Summary
The `website/` folder is a **multi-page Elm application** using client-side routing. The site uses `Browser.application` (not `Browser.element`) with `elm/url` for navigation. The compiled Elm app is bootstrapped from `src/index.js` which mounts `Elm.Main` into the DOM node with id `root` provided by `public/index.html`. Styling is provided by `src/main.css` (with Bootstrap CSS for grid), and static assets (icons, images) live in `public/`. The project includes a `serviceWorker.js` helper which is imported but not registered by default.

### Architecture
- **Main.elm**: Router with `Browser.application`, handles URL changes and route parsing
- **Shared.elm**: Common components (navigation, footer, viewRecentEvent, utility functions)
- **Pages/**: Modular page components (Home, Appearances, HireMe, Writings, Entrepreneurship, Offers)
- **Routing**: Clean URLs (no hash routing) with browser back/forward support

## Notable patterns & conventions
- **Multi-page routing**: Uses `elm/url` and `elm/browser` for SPA routing with clean URLs
- **Shared components**: Navigation, footer, and common utilities extracted to `Shared.elm`
- **Modular pages**: Each page is its own module under `Pages/` directory
- **Public assets**: Images and manifest live in `public/` and are referenced by filename
- **Build/bootstrapping**: JS entry point `src/index.js` imports the Elm module, global CSS, third‑party CSS
- **Container alignment**: All sections use 1140px max-width to match Bootstrap container (see `docs/LAYOUT_GUIDE.md`)

## Documentation

All technical documentation is organized in the `docs/` directory:

### 📚 Core Documentation
- **[`docs/MULTI_PAGE_IMPLEMENTATION.md`](./docs/MULTI_PAGE_IMPLEMENTATION.md)** - Complete multi-page routing implementation guide
- **[`docs/NAVIGATION_GUIDE.md`](./docs/NAVIGATION_GUIDE.md)** - Navigation structure and routing map
- **[`docs/IMPROVEMENTS_COMPLETE.md`](./docs/IMPROVEMENTS_COMPLETE.md)** - Summary of navigation and footer improvements
- **[`docs/SEO_GUIDE.md`](./docs/SEO_GUIDE.md)** - Complete SEO implementation (meta tags, alt text, title attributes)
- **[`docs/LAYOUT_GUIDE.md`](./docs/LAYOUT_GUIDE.md)** - Layout system, alignment strategies, and responsive design
- **[`REFACTORING_LOG.md`](./REFACTORING_LOG.md)** - Refactoring history, lessons learned, and testing protocols

### 🎯 Agent Guidelines

**When you need to remember something for next time:**
1. **Update AGENTS.md** - Add architectural notes, patterns, or warnings here
2. **Create docs in `docs/`** - Write detailed guides for complex topics
3. **Link from AGENTS.md** - Reference your docs with relative links

**For any refactoring work:**
1. **Link or add to `REFACTORING_LOG.md`** - Document what changed, why, and lessons learned
2. **Update relevant docs** - Keep `docs/` guides current with code changes
3. **Test thoroughly** - Follow testing protocols in REFACTORING_LOG.md

**Documentation Best Practices:**
- Use descriptive filenames (e.g., `SEO_GUIDE.md`, `LAYOUT_GUIDE.md`)
- Include code examples with syntax highlighting
- Add checklists for verification
- Link between related documents
- Keep AGENTS.md as the entry point/index

---

## SEO Implementation

The website is fully optimized for search engines. See **[`docs/SEO_GUIDE.md`](./docs/SEO_GUIDE.md)** for complete details.

### Quick Summary:
- ✅ **Meta descriptions**: Dynamic per page (Home, Appearances, HireMe, etc.)
- ✅ **Page title**: "Abdu \"Códigos\" Mappuji - The CTO-mentor, Engineer, Legal Scholar"
- ✅ **Image SEO**: All images have `alt` + `title` attributes
- ✅ **Link SEO**: All links have `title` attributes and proper security (`rel="noopener noreferrer"`)
- ✅ **Semantic HTML**: Proper heading hierarchy (h1 → h2 → h3)
- ✅ **Keywords**: CTO-mentor, fractional CTO, engineer, legal scholar, mentoring, etc.

### Implementation Location:
- Meta description: `Main.elm` → `getMetaDescription` function
- Image attributes: All `img` elements have `alt` and `title`
- Link attributes: All `a` elements have `title` attribute
- External links: Use `Shared.linkNewTab` helper with security attributes

---

## Layout & Alignment System

The website uses a **hybrid layout system** combining Bootstrap containers with custom full-width sections. See **[`docs/LAYOUT_GUIDE.md`](./docs/LAYOUT_GUIDE.md)** for complete details.

### Key Principles:
1. **1140px max-width** - All content sections match Bootstrap container width
2. **15px horizontal padding** - Consistent with Bootstrap container
3. **Full-width sections** - Break out of container, then constrain inner content
4. **Alignment verification** - All content left edges must align perfectly

### Container Pattern:
```css
/* Full-width outer */
.section-outer {
  width: 100vw;
  position: relative;
  left: 50%;
  right: 50%;
  margin-left: -50vw;
  margin-right: -50vw;
}

/* Constrained inner (matches Bootstrap) */
.section-inner {
  max-width: 1140px;
  margin: 0 auto;
  padding: 0 15px;
}
```

### Why 1140px?
Bootstrap 4's `.container` uses 1140px max-width at 1200px+ viewport. All custom sections must match this for proper alignment.

---

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

The website's most distinctive and recognizable feature is the **unified colored left-border hover interaction** applied consistently throughout the site:

**The Unified Pattern:**
- **Default state:** 3px colored left border with subtle padding, NO underline
- **Hover state:** Border grows to 5px, padding expands slightly (zoom effect), background fills with border color, text turns white, NO underline
- **Transition:** Smooth 0.3s ease for all properties
- **Consistency:** Global rule removes underlines from ALL links site-wide

**Where it's applied (100% consistent):**
1. **List items and table rows** — content links with color rotation (red/green/blue based on index)
2. **Navigation** — "Blog" link (green border) with zoom effect
3. **Dropdown button** — "More" button (blue border) with zoom effect
4. **Dropdown menu items** — rotating colors (red/green/blue) with zoom effect
5. **Special inline links** — "Child of all nations" (green border) with zoom effect
6. **Mentee testimonial cards** — color rotation (green/blue for odd/even) with zoom effect

**Technical implementation:**
```css
/* Global consistency - remove all underlines */
a {
  text-decoration: none;
}

a:hover {
  text-decoration: none;
}

/* The Unified Pattern - Applied Everywhere */
element {
  border-left: 3px solid var(--color-*);
  padding-left: 8px;  /* or 16px for navigation */
  transition: all 0.3s ease;
}

element:hover {
  border-left-width: 5px;
  padding-left: 10px;  /* or 18px for navigation - creates zoom effect */
  background-color: var(--color-*);
  color: white;
}
```

**CSS classes:**
- `.red-border`, `.green-border`, `.blue-border` (content lists/tables)
- `.navigation li a` (Blog link)
- `.dropbtn` (More button)
- `.dropdown-content a` (dropdown menu items)
- `.inline-link-special` (special inline links)
- `.mentee-card` (testimonial cards with :nth-child color rotation)

**Elm logic:** 
- `pickBorder` function in `src/Main.elm` assigns colors to list items based on index modulo
- Color rotation: index % 3 == 0 → red; index % 2 == 0 → green; else → blue

**Why this matters:**
1. **Brand identity** — this interaction is immediately recognizable and unique to the site
2. **Complete consistency** — identical behavior across ALL interactive elements (navigation, content, tables, inline links)
3. **User engagement** — the zoom effect (border growth + padding expansion) provides satisfying visual feedback
4. **Visual hierarchy** — colors help distinguish different content items at a glance
5. **Professional polish** — every hover interaction follows the exact same pattern

**Protected by design:**
- Border colors use CSS variables (`var(--color-danger)`, `var(--color-primary)`, `var(--color-blue)`) for maintainability
- All transitions use `all 0.3s ease` for consistency
- Border grows from 3px → 5px everywhere
- Padding expansion creates the signature "zoom" effect
- Any refactoring must validate that hover transitions remain smooth and colors stay consistent

**DO NOT:**
- Change the fundamental interaction pattern (3px border → 5px border + background fill)
- Modify transition timing (must stay 0.3s ease)
- Remove or alter the zoom effect (border + padding growth)
- Apply different hover patterns to different sections
- Change border width (3px default, 5px on hover is standard)
- Add underlines to any links (breaks the clean iconic design)

**Reference implementation:** 
- Content lists/tables: `.red-border`, `.green-border`, `.blue-border` in `website/src/main.css` (lines ~122-159)
- Navigation: `.navigation li a`, `.dropbtn`, `.dropdown-content a` in `website/src/main.css` (lines ~60-244)
- Special inline: `.inline-link-special` in `website/src/main.css` (lines ~102-116)

---

## Ongoing Refactoring Efforts

**Status:** Active | **Current Score:** 10/10 | **Last Updated:** January 15, 2026

### Quick Summary
Recent refactoring efforts have significantly improved code quality while extending the iconic hover design:
- ✅ CSS variables centralized (colors, spacing)
- ✅ Security hardened (all external links)
- ✅ Mobile responsiveness improved (table labels)
- ✅ Border classes consolidated with CSS variables
- ✅ Navigation redesigned with iconic hover pattern (Blog, More button, dropdown items)
- ✅ **NEW:** Analytics tracking with UTM parameters & reusable utility function
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
