# Footer White Space Fix

## Problem
The footer in the website had extra white space underneath, creating a gap between the footer and the edge of the browser window.

## Root Cause
The issue was caused by a combination of factors:

1. **Bootstrap CSS Integration**: The website uses Bootstrap 4.6.0, which is imported before the custom CSS
2. **Height: 100% on html/body/#root**: These elements had `height: 100%` but no explicit margin reset
3. **Browser Default Margins**: Even though Bootstrap resets many styles, the interaction between:
   - Full-width sections using negative margins (`margin-left: -50vw; margin-right: -50vw`)
   - The container structure
   - Height calculations
   
   ...was creating unwanted white space at the bottom

## Solution Applied

### Changes to `/website/src/main.css`

1. **Added explicit margin/padding reset**:
```css
html, body, #root {
  height: 100%;
  margin: 0;      /* Added */
  padding: 0;     /* Added */
  font-family: var(--font-sans);
}
```

2. **Added overflow-x control**:
```css
body {
  overflow-x: hidden;  /* Prevents horizontal scrollbar from full-width technique */
}
```

3. **Bootstrap container override**:
```css
/* Ensure Bootstrap container doesn't add extra spacing */
.container {
  padding-bottom: 0 !important;
  margin-bottom: 0 !important;
}
```

## Technical Details

### The Full-Width Technique
The footer and other sections use a common CSS technique for full-width backgrounds within a centered layout:

```css
.footer {
  width: 100vw;
  position: relative;
  left: 50%;
  right: 50%;
  margin-left: -50vw;
  margin-right: -50vw;
}
```

This technique requires:
- `overflow-x: hidden` on the body to prevent horizontal scrollbars
- Proper margin/padding resets on parent elements
- Careful handling when mixed with Bootstrap's container classes

## Testing
After applying the fix:
- ✅ No white space below footer
- ✅ Footer extends to bottom edge of browser
- ✅ No horizontal scrollbar appears
- ✅ Responsive layout still works correctly
- ✅ No CSS errors introduced

## Files Modified
- `/website/src/main.css` - Added margin/padding resets and Bootstrap container overrides

## Related Files
- `/website/src/index.js` - Imports Bootstrap CSS before custom styles
- `/website/src/Shared.elm` - Contains footer structure
- `/website/package.json` - Lists Bootstrap 4.6.0 as dependency

---

**Date**: January 23, 2026
**Status**: ✅ Fixed
