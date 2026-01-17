# Layout & Alignment Guide

## Overview

This guide documents the layout system and alignment strategies used throughout the website.

---

## 1. Layout System

### Container System

The website uses a **hybrid container system** combining Bootstrap's responsive containers with custom full-width sections.

#### Bootstrap Container
- **Max-width:** 1140px (at 1200px+ viewport)
- **Padding:** 15px left/right
- **Usage:** Page content (Appearances, HireMe, Writings, Entrepreneurship, Offers)

#### Custom Full-Width Sections
- **Hero Section** - 1200px max-width (visual element)
- **Newsletter Section** - 1140px max-width (matches Bootstrap)
- **As Seen At Section** - 1140px max-width (matches Bootstrap)
- **Footer** - 1140px max-width (matches Bootstrap)

---

## 2. Alignment Strategy

### The Problem
Different sections had different max-widths causing misalignment:
- Bootstrap container: 1140px
- Custom sections: 1200px
- **Result:** Content didn't align properly

### The Solution
**All content sections must use 1140px max-width to match Bootstrap container:**

```css
.newsletter-content,
.as-seen-at-content,
.footer-content {
  max-width: 1140px;
  margin: 0 auto;
  padding: 0 15px;
}
```

### Why 1140px?
Bootstrap 4's `.container` class uses these max-widths:
- `< 576px`: 100% width
- `≥ 576px`: 540px
- `≥ 768px`: 720px
- `≥ 992px`: 960px
- `≥ 1200px`: **1140px** ← Our target

---

## 3. Full-Width Section Pattern

### Structure
```html
<section class="full-width-section">
  <div class="inner-content">
    <!-- Content here -->
  </div>
</section>
```

### CSS Pattern
```css
/* Outer: Full-width background */
.full-width-section {
  width: 100vw;
  position: relative;
  left: 50%;
  right: 50%;
  margin-left: -50vw;
  margin-right: -50vw;
  padding: 40px 0;  /* Vertical padding only */
}

/* Inner: Constrained content */
.inner-content {
  max-width: 1140px;
  margin: 0 auto;
  padding: 0 15px;  /* Horizontal padding */
}
```

---

## 4. Implemented Sections

### Hero Section
```css
.hero-section {
  width: 100vw;
  /* Full-width dark background */
}

.hero-content {
  max-width: 1200px;  /* Slightly wider for visual balance */
  margin: 0 auto;
  padding: 0;  /* No padding, image is full-height */
}
```

### Newsletter Section
```css
.newsletter-section {
  width: 100vw;
  /* Full-width, neutral background */
}

.newsletter-content {
  max-width: 1140px;  /* Matches Bootstrap */
  margin: 0 auto;
  padding: 0 15px;
  display: flex;
  /* Two-column layout */
}
```

### As Seen At Section
```css
.as-seen-at-hero {
  width: 100vw;
  background-color: var(--color-primary);
  /* Full-width green background */
}

.as-seen-at-content {
  max-width: 1140px;  /* Matches Bootstrap */
  margin: 0 auto;
  padding: 0 15px;
  text-align: center;
}
```

### Footer
```css
.footer {
  width: 100vw;
  background-color: var(--color-grey-pastel);
  /* Full-width grey background */
}

.footer-content {
  max-width: 1140px;  /* Matches Bootstrap */
  margin: 0 auto;
  padding: 0 15px;
  display: flex;
  /* Three-column layout */
}
```

---

## 5. Page Content Pattern

### Main.elm Structure
```elm
view model =
    { title = "..."
    , body =
        [ div [ class "container content" ]  -- Bootstrap container
            [ Shared.viewNav (routeToString model.route)
            , viewPage model  -- Each page returns plain div
            ]
        , Shared.viewFooter model.time  -- Outside container
        ]
    }
```

### Page Module Structure
```elm
-- Each page module returns content without container
view : Html msg
view =
    div []  -- Plain div, wrapped by container in Main.elm
        [ h1 [] [ text "Page Title" ]
        , p [] [ text "Content..." ]
        -- More content
        ]
```

---

## 6. Responsive Behavior

### Desktop (≥1200px)
- Container: 1140px max-width, 15px padding
- Full-width sections: 100vw with 1140px inner content
- Navigation: Right-aligned within container
- Footer: Three-column layout

### Tablet (768px - 1199px)
- Container: 720px max-width, 15px padding
- Full-width sections: 100vw with 720px inner content
- Navigation: Same layout, may wrap
- Footer: May stack columns

### Mobile (<768px)
- Container: 100% width, 15px padding
- Full-width sections: 100vw with 100% inner content
- Navigation: Stacked layout
- Footer: Stacked single-column layout

---

## 7. Alignment Verification

### How to Check Alignment
1. Open browser dev tools
2. Set viewport to 1200px+ width
3. Inspect elements
4. Check that all content aligns:
   - Left edge of page content
   - Left edge of newsletter text
   - Left edge of footer copyright
   - **All should align at the same pixel position**

### Visual Test
```
┌─────────────────────────────────────────────────┐
│ [Bootstrap Container 1140px + 15px padding]     │
│ ├─ Page Title                                   │
│ ├─ Page Content                                 │
│                                                  │
│ [Newsletter Section - Full Width]               │
│   [Inner 1140px + 15px padding]                 │
│   ├─ Newsletter Text                            │
│                                                  │
│ [As Seen At - Full Width]                       │
│   [Inner 1140px + 15px padding]                 │
│   ├─ As Seen At Title                           │
│                                                  │
│ [Footer - Full Width]                           │
│   [Inner 1140px + 15px padding]                 │
│   ├─ Copyright Text                             │
└─────────────────────────────────────────────────┘

All left edges (├─) should align perfectly!
```

---

## 8. Common Pitfalls to Avoid

### ❌ DON'T: Use different max-widths
```css
.section-a { max-width: 1200px; }
.section-b { max-width: 1140px; }
/* Content won't align! */
```

### ✅ DO: Use consistent max-width
```css
.section-a,
.section-b {
  max-width: 1140px;
}
```

### ❌ DON'T: Add padding to both outer and inner
```css
.outer { padding: 0 20px; }
.inner { padding: 0 15px; }
/* Total padding is inconsistent! */
```

### ✅ DO: Add padding only to inner element
```css
.outer { padding: 40px 0; }  /* Vertical only */
.inner { padding: 0 15px; }  /* Horizontal only */
```

### ❌ DON'T: Nest containers
```elm
div [ class "container" ]
    [ div [ class "container" ]  -- Double nesting!
        [ content ]
    ]
```

### ✅ DO: Use container at top level only
```elm
div [ class "container" ]
    [ content ]  -- Direct children
```

---

## 9. Layout Best Practices

### When Creating New Sections

1. **Decide if full-width or not:**
   - Full-width: Hero banners, colored backgrounds
   - Container-width: Regular page content

2. **Use the pattern:**
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
   
   /* Constrained inner */
   .section-inner {
     max-width: 1140px;
     margin: 0 auto;
     padding: 0 15px;
   }
   ```

3. **Test alignment:**
   - Compare with existing sections
   - Check at 1200px+ viewport
   - Verify mobile responsiveness

### When Modifying Layout

1. **Check impact on alignment:**
   - Will this change affect other sections?
   - Does it maintain 1140px max-width?
   - Does it keep 15px padding?

2. **Test across breakpoints:**
   - Desktop (1200px+)
   - Tablet (768px - 1199px)
   - Mobile (<768px)

3. **Verify visual consistency:**
   - All sections align properly
   - No horizontal scroll
   - Spacing is consistent

---

## 10. CSS Variables for Consistency

### Current Implementation
```css
:root {
  /* Container could be defined as variable */
  --container-max-width: 1140px;
  --container-padding: 15px;
}

/* Usage */
.content-wrapper {
  max-width: var(--container-max-width);
  padding: 0 var(--container-padding);
}
```

### Why This Helps
- Single source of truth
- Easy to update globally
- Prevents inconsistencies

---

## 11. Navigation Alignment

### Navigation Position
```css
.navigation {
  display: flex;
  justify-content: flex-end;
  margin-top: 24px;
}
```

### Why Right-Aligned
- Follows Bootstrap container flow
- Aligns with hero-text right edge
- Consistent with site's visual hierarchy

### Container Context
Navigation is **inside** the `.container` div:
```elm
div [ class "container content" ]
    [ Shared.viewNav ...  -- Inside container
    , viewPage model
    ]
```

This ensures it respects the 1140px + 15px padding alignment.

---

## 12. Footer Layout

### Three-Column Structure
```css
.footer-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  flex-wrap: wrap;
  gap: 40px;
}

.footer-copyright {
  flex: 1;
  min-width: 300px;
}

.footer-quick-links {
  flex: 0 0 auto;
}
```

### Responsive Behavior
```css
@media (max-width: 767px) {
  .footer-content {
    flex-direction: column;
    gap: 30px;
  }
  
  .footer-copyright {
    min-width: 100%;
  }
}
```

---

## Summary

### Key Principles
1. **Use 1140px max-width** for all content sections
2. **Use 15px horizontal padding** consistently
3. **Full-width sections** break out, then constrain inner content
4. **Test alignment** across all breakpoints
5. **Follow Bootstrap container** patterns for consistency

### Checklist for New Sections
- [ ] Max-width is 1140px
- [ ] Horizontal padding is 15px
- [ ] Vertical padding on outer element only
- [ ] Tests on desktop (1200px+)
- [ ] Tests on tablet (768-1199px)
- [ ] Tests on mobile (<768px)
- [ ] Aligns with existing sections

The layout system ensures perfect alignment across all pages and sections! 📐✨
