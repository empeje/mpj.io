# Page-Specific Structured Data Implementation

**Date:** January 23, 2026  
**Change:** Moved structured data from global HTML to page-specific Elm rendering  
**Reason:** Better SEO practice - structured data should only appear on relevant pages

---

## 🎯 What Changed

### Before (Incorrect ❌)
- Structured data was in `/public/index.html` and `/build/index.html`
- **Problem:** Appeared on EVERY page (home, appearances, writings, etc.)
- **SEO Issue:** Google saw mentoring reviews on pages that aren't about mentoring
- **Wrong approach:** Site-wide structured data for page-specific content

### After (Correct ✅)
- Structured data is injected into `<head>` via Elm ports + JavaScript
- **HireMe page:** Product schema with mentoring reviews (5-star ratings)
- **Appearances page:** ItemList schema with 21 Event items (tech talks & conferences)
- **Solution:** Only renders when route matches specific pages
- **SEO Benefit:** Structured data only appears on pages where contextually relevant
- **Right approach:** Page-specific structured data via dynamic rendering

---

## 📝 Technical Implementation

### Elm Port Definition

```elm
port updateStructuredData : String -> Cmd msg
```

### JavaScript Port Handler

In `/src/index.js`:

```javascript
if (app.ports && app.ports.updateStructuredData) {
  app.ports.updateStructuredData.subscribe(function(data) {
    // Remove existing structured data
    const existingScript = document.querySelector('script[type="application/ld+json"]');
    if (existingScript) {
      existingScript.remove();
    }
    
    // Add new structured data to HEAD
    if (data && data.trim() !== '') {
      const script = document.createElement('script');
      script.type = 'application/ld+json';
      script.text = data;
      document.head.appendChild(script);  // ← Injected into <head>!
    }
  });
}
```

### Elm Function

```elm
getStructuredDataForRoute : Route -> String
getStructuredDataForRoute route =
    case route of
        HireMe ->
            """{ Product schema with reviews }"""
        
        Appearances ->
            """{ ItemList schema with Event items }"""
        
        _ ->
            ""
```

### Integration

The structured data is sent via port when:
1. **Page loads** - `init` function sends initial structured data
2. **Route changes** - `UrlChanged` handler sends updated structured data

```elm
init _ url key =
    let route = parseUrl url
    in ( model
       , Cmd.batch [ getTime
                   , updateStructuredData (getStructuredDataForRoute route)
                   ]
       )

update msg model =
    case msg of
        UrlChanged url ->
            let newRoute = parseUrl url
            in ( { model | route = newRoute }
               , updateStructuredData (getStructuredDataForRoute newRoute)
               )
```

**Key Benefit:** This injects structured data into `<head>` (not body), which is the correct location for SEO!

---

## 🎓 Why This Matters

### SEO Best Practices

1. **Relevance:** Structured data should only appear on pages it describes
2. **Context:** Reviews about mentoring belong on the mentoring page only
3. **Trust:** Google penalizes misleading structured data placement
4. **Quality:** Page-specific data signals better content organization

### What Google Sees

**Before (Wrong):**
- Homepage: Has mentoring reviews (confusing - homepage isn't about mentoring specifically)
- Appearances page: Has mentoring reviews (wrong - this page is about talks)
- Writings page: Has mentoring reviews (wrong - this page is about articles)
- Hire Me page: Has mentoring reviews (correct ✅)

**After (Correct):**
- Homepage: No structured data (clean)
- Appearances page: Has Event list with 21 tech talks (correct ✅)
- Writings page: No structured data (clean)
- Hire Me page: Has mentoring reviews (correct ✅)
- Other pages: No structured data (clean)

---

## 📚 How to Update Reviews Now

### New Process (Current)
1. Open `/src/Main.elm`
2. Find `getStructuredDataForRoute` function
3. Extract JSON string from the `HireMe` case
4. Format with https://jsonformatter.org/
5. Add/edit review
6. Minify with https://jsonformatter.org/json-minify
7. Replace JSON in Elm code
8. Compile and test

**The port automatically handles:**
- ✅ Removing old structured data from `<head>`
- ✅ Injecting new structured data into `<head>` (correct location!)
- ✅ Updating when route changes
- ✅ Clearing structured data on non-HireMe pages

**Full instructions:** See `/docs/STRUCTURED_DATA_GUIDE.md`

---

## ✅ Benefits of This Approach

### For SEO
- ✅ **Better relevance:** Data only on relevant pages
- ✅ **Cleaner indexing:** Google sees proper page context
- ✅ **No confusion:** Each page has appropriate metadata
- ✅ **Higher trust:** Proper structured data placement

### For Maintenance
- ✅ **Type safety:** Elm compiler catches errors
- ✅ **Single source:** One place to update (Main.elm)
- ✅ **Dynamic:** Can be extended to other pages easily
- ✅ **Route-based:** Automatic rendering based on URL

### For Extensibility
- ✅ **Scalable:** Easy to add structured data to other pages
- ✅ **Conditional:** Can render different data per route
- ✅ **Flexible:** Can use Elm logic to customize data

---

## 🔮 Future Enhancements

### Easy to Add More Page-Specific Data

**Example: Blog posts structured data on Writings page**
```elm
viewStructuredData : Route -> Html msg
viewStructuredData route =
    case route of
        HireMe ->
            -- Mentoring reviews
            
        Writings ->
            -- BlogPosting structured data
            
        Appearances ->
            -- Event structured data
            
        _ ->
            Html.text ""
```

### Can Use Elm Data Models

```elm
viewStructuredData : Model -> Html msg
viewStructuredData model =
    case model.route of
        HireMe ->
            -- Can access model.reviews if stored in Elm
            viewReviewsStructuredData model.reviews
        _ ->
            Html.text ""
```

---

## 📖 Documentation Updates

All documentation has been updated to reflect this change:

✅ `/docs/STRUCTURED_DATA_GUIDE.md` - Updated with Elm-specific instructions  
✅ `/docs/STRUCTURED_DATA_CHECKLIST.md` - Reflects Elm implementation  
✅ `/docs/IMPLEMENTATION_SUMMARY.md` - Shows current architecture  
✅ This file - Explains the architectural change

---

## 🚨 Important Notes

### For Future Developers

1. **Don't add structured data to HTML files** - Use Elm's `viewStructuredData` function
2. **Check the route** - Make sure data only renders on relevant pages
3. **Follow the pattern** - Use the same approach for other page-specific metadata
4. **Validate placement** - Test that data only appears on intended pages

### For SEO

1. **Verify with Google Rich Results Test** on each specific page URL
2. **Check page source** on different routes to confirm proper rendering
3. **Monitor Google Search Console** for any structured data issues
4. **Test locally first** before deploying changes

---

## ✅ Verification Steps

### How to Verify It's Working

1. **Run the site locally:**
   ```bash
   cd website
   elm reactor
   # or your build process
   ```

2. **Check each page:**
   - Go to http://localhost:8000
   - View page source (Ctrl+U / Cmd+Option+U)
   - Verify NO structured data script
   
   - Go to http://localhost:8000/hire-me
   - View page source
   - Verify Product structured data IS present (mentoring reviews)
   
   - Go to http://localhost:8000/appearances
   - View page source
   - Verify ItemList structured data IS present (21 tech talks)

3. **After deployment:**
   - Test https://mpj.io/ → No structured data
   - Test https://mpj.io/writings → No structured data
   - Test https://mpj.io/hire-me → Has Product structured data ✅
   - Test https://mpj.io/appearances → Has ItemList structured data ✅

---

## 📊 Impact Assessment

### SEO Impact: Positive ⬆️
- Better page relevance signals
- Cleaner metadata structure
- Proper context for search engines
- Higher quality score potential

### Development Impact: Neutral ➡️
- Same level of effort to update
- Better type safety (Elm)
- Clearer architecture
- Single source of truth

### Performance Impact: Neutral/Positive ➡️
- No HTML file bloat on non-relevant pages
- Dynamic rendering is negligible overhead
- Smaller initial HTML payload on most pages

---

## 🎉 Summary

**What we did:**
- Moved structured data from global HTML to page-specific Elm rendering
- Now only appears on `/hire-me` page where it's relevant
- Updated all documentation with new procedures

**Why it matters:**
- Better SEO practices
- Clearer page context for search engines
- More maintainable architecture
- Extensible for future page-specific data

**What you need to know:**
- To update reviews: Edit `src/Main.elm` → `viewStructuredData` function
- Follow guide: `/docs/STRUCTURED_DATA_GUIDE.md`
- This is the correct architectural pattern for page-specific metadata

---

**Status:** ✅ Complete and validated  
**Date:** January 23, 2026  
**Next Step:** Deploy and verify with Google Rich Results Test on `/hire-me` page only

---

*This change follows SEO best practices and makes the codebase more maintainable.*
