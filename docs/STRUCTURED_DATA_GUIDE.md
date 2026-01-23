# Structured Data Guide for mpj.io

## Overview

This guide explains how to maintain and update the **JSON-LD structured data** on the mpj.io website. Structured data helps search engines understand and display your content better, potentially showing rich results in search.

**Current Implementation:**
- **HireMe page:** Product schema with mentoring reviews (5-star ratings)
- **Appearances page:** ItemList schema with 21 Event items (tech talks and conferences)

**Location:** Dynamically injected into `<head>` via Elm ports - only appears on specific pages

---

## 📍 Where to Find It

The structured data uses Elm ports and JavaScript to inject into the HTML `<head>`:

**Elm Side:** `/src/Main.elm`
- **Port:** `port updateStructuredData : String -> Cmd msg`
- **Function:** `getStructuredDataForRoute : Route -> String`
- **When:** Sends data via port on init and route changes

**JavaScript Side:** `/src/index.js`
- **Handler:** Listens to `updateStructuredData` port
- **Action:** Removes old script, adds new script to `document.head`

```javascript
app.ports.updateStructuredData.subscribe(function(data) {
  const existingScript = document.querySelector('script[type="application/ld+json"]');
  if (existingScript) existingScript.remove();
  
  if (data && data.trim() !== '') {
    const script = document.createElement('script');
    script.type = 'application/ld+json';
    script.text = data;
    document.head.appendChild(script);  // ← Injected into <head>!
  }
});
```

**Why this approach?**
- ✅ **Correct location:** Injected into `<head>`, not body (SEO best practice)
- ✅ **Page-specific:** Only appears on hire-me page, not site-wide
- ✅ **Dynamic:** Updates automatically when route changes
- ✅ **Maintainable:** Single source of truth in Elm code

---

## 🎯 What's Implemented

### Product Information
- **Type:** Product (Mentoring Service)
- **Name:** "Exclusive Mentoring by Abdu Mappuji"
- **Description:** Highly-selective mentoring program
- **Pricing:** $70-$2000 (3 package options)

### Aggregate Rating
- **Rating:** 5.0/5.0
- **Count:** 2 reviews
- Automatically calculated from individual reviews

### Individual Reviews
Currently includes 2 reviews:

1. **Wihlarko Prasdegdho (Edo)**
   - Rating: 5/5 ⭐⭐⭐⭐⭐
   - Role: Senior Engineer at Tridorian
   - Focus: Career coaching, CV improvement, interview preparation
   - Result: Landed fulltime remote role in Singapore
   - Date: 2024-01-15

2. **Aurélien Lair**
   - Rating: 5/5 ⭐⭐⭐⭐⭐
   - Focus: CI/CD pipeline development, DevOps mentoring
   - Date: 2023-04-24

---

## 📝 How to Add a New Review

### Step 1: Gather Information

Before adding a review, collect:
- ✅ **Reviewer's full name**
- ✅ **Company/title** (optional but recommended)
- ✅ **LinkedIn or Twitter URL** (if available)
- ✅ **Review text/testimonial**
- ✅ **Star rating** (1-5, currently all are 5)
- ✅ **Review date** (format: YYYY-MM-DD)

### Step 2: Format the Review JSON

Copy this template and fill in the details:

```json
{
  "@type": "Review",
  "reviewRating": {
    "@type": "Rating",
    "ratingValue": "5",
    "bestRating": "5"
  },
  "author": {
    "@type": "Person",
    "name": "FULL NAME HERE",
    "jobTitle": "TITLE at COMPANY",
    "url": "LINKEDIN_OR_TWITTER_URL"
  },
  "reviewBody": "REVIEW TEXT HERE",
  "datePublished": "YYYY-MM-DD"
}
```

**Field guidelines:**
- `ratingValue`: "1" to "5" (string, not number)
- `name`: Full name as they want to be credited
- `jobTitle`: Optional, remove entire line if not available
- `url`: LinkedIn/Twitter profile, remove entire line if not available
- `reviewBody`: Full testimonial text, escape quotes with `\"`
- `datePublished`: ISO date format (YYYY-MM-DD)

### Step 3: Update the Elm Code

1. Open `/src/Main.elm`
2. Find the `getStructuredDataForRoute` function (around line 155+)
3. Locate the JSON string for the `HireMe` case
4. **Important:** The JSON is minified (on one line) for production

**To edit:**
1. Copy the entire JSON string from the `HireMe` case
2. Use https://jsonformatter.org/ to format it (make it readable)
3. Add your new review to the `"review"` array
4. Update the `"ratingCount"` in `"aggregateRating"`
5. Recalculate `"ratingValue"` if needed (average of all ratings)
6. Use https://jsonformatter.org/json-minify to minify it back
7. Replace the JSON string in the Elm code

**Example location in Main.elm:**
```elm
getStructuredDataForRoute : Route -> String
getStructuredDataForRoute route =
    case route of
        HireMe ->
            """{ your minified JSON here }"""
        _ ->
            ""
```

**Note:** The port automatically handles injecting this into the `<head>` element!

### Step 4: Update Aggregate Rating

After adding a review, ensure these fields are correct:

```json
"aggregateRating": {
  "@type": "AggregateRating",
  "ratingValue": "5.0",          // Average of all ratings
  "bestRating": "5",
  "worstRating": "1",
  "ratingCount": "3"              // ← INCREMENT THIS
}
```

**Calculation:**
- Count total reviews
- Calculate average rating
- Update `ratingCount`
- Update `ratingValue` if average changes

### Step 5: Validate

1. **Elm Compilation:**
   ```bash
   cd website
   elm make src/Main.elm
   ```
   Ensure no compilation errors

2. **JSON Validity:**
   - Extract the JSON from your code
   - Use: https://jsonlint.com/
   - Validate it's proper JSON

3. **Schema.org Validation:**
   - Build and run the site locally
   - Navigate to `/hire-me`
   - View page source
   - Copy the structured data script
   - Validate at: https://validator.schema.org/

4. **Google Rich Results Test:**
   - After deployment: https://search.google.com/test/rich-results
   - Enter: https://mpj.io/hire-me
   - Check for "Review" rich results eligibility

---

## 🔄 How to Edit an Existing Review

### Update Review Text

1. Find the review in `/public/index.html`
2. Locate the `"reviewBody"` field
3. Update the text
4. **Important:** Escape any quotes in the text with `\"`
5. Update `/build/index.html` (see Step 5 above)
6. Validate (see Step 6 above)

### Change Rating

1. Find the review's `"reviewRating"` object
2. Update `"ratingValue"` (1-5)
3. Recalculate aggregate rating:
   - Add up all ratings
   - Divide by number of reviews
   - Update `aggregateRating.ratingValue`
4. Update both HTML files
5. Validate

### Update Author Info

You can update:
- `name` - Author's name
- `jobTitle` - Their current role
- `url` - Their profile URL

**Example:**
```json
"author": {
  "@type": "Person",
  "name": "Wihlarko Prasdegdho (Edo)",
  "jobTitle": "Lead Engineer at NewCompany",  // ← Updated
  "url": "https://www.linkedin.com/in/wihlarko-prasdegdho"
}
```

---

## 🗑️ How to Remove a Review

1. Open `/public/index.html`
2. Find and delete the entire review object `{ ... }`
3. **Important:** Fix the JSON syntax:
   - Remove comma after previous review if this was the last one
   - Ensure proper comma placement between remaining reviews
4. Update `ratingCount` in `aggregateRating` (decrement by 1)
5. Recalculate `ratingValue` if needed
6. Update `/build/index.html`
7. Validate

---

## 🎨 Advanced: Different Rating Values

Currently all reviews are 5-star. To add variety:

### Example: 4-Star Review

```json
{
  "@type": "Review",
  "reviewRating": {
    "@type": "Rating",
    "ratingValue": "4",          // ← Changed to 4
    "bestRating": "5"
  },
  "author": {
    "@type": "Person",
    "name": "Someone",
    "url": "https://example.com"
  },
  "reviewBody": "Great mentoring, very helpful.",
  "datePublished": "2025-01-20"
}
```

**Then update aggregate:**
```json
"aggregateRating": {
  "@type": "AggregateRating",
  "ratingValue": "4.7",          // (5+5+4)/3 = 4.67 → 4.7
  "bestRating": "5",
  "worstRating": "1",
  "ratingCount": "3"
}
```

---

## ✅ Testing Your Changes

### Local Testing

1. **Visual Check**
   - Open `/public/index.html` in browser
   - Open Developer Tools (F12)
   - Go to Console tab
   - Type: `JSON.parse(document.querySelector('script[type="application/ld+json"]').textContent)`
   - Should see parsed JSON object without errors

2. **JSON Validation**
   ```bash
   # If you have jq installed
   cat public/index.html | grep -A 100 'application/ld+json' | jq .
   ```

### After Deployment

1. **Google Rich Results Test**
   - Visit: https://search.google.com/test/rich-results
   - Enter: https://mpj.io/hire-me
   - Should show review snippets eligible

2. **Schema Markup Validator**
   - Visit: https://validator.schema.org/
   - Enter URL or paste code
   - Check for errors/warnings

3. **Google Search Console**
   - Wait 1-2 weeks after deployment
   - Check "Enhancements" section
   - Look for "Review snippets" or "Product" data

---

## 🚨 Common Mistakes & Solutions

### ❌ Missing Comma
**Error:** Unexpected token
```json
{
  "@type": "Review",
  // ...
}  // ← Missing comma before next review
{
  "@type": "Review",
  // ...
}
```

**Fix:** Add comma between reviews
```json
},  // ← Add comma here
{
```

### ❌ Unescaped Quotes
**Error:** JSON parse error
```json
"reviewBody": "He said "amazing" to me"
```

**Fix:** Escape inner quotes
```json
"reviewBody": "He said \"amazing\" to me"
```

### ❌ Wrong Rating Count
**Problem:** Shows 3 reviews but says `"ratingCount": "2"`

**Fix:** Count all reviews in the array and update:
```json
"ratingCount": "3"  // Must match actual number of reviews
```

### ❌ Wrong Average Rating
**Problem:** Shows 5+5+4 = 14 stars but says `"ratingValue": "5.0"`

**Fix:** Calculate average correctly
```json
// 14/3 = 4.67 → round to 4.7
"ratingValue": "4.7"
```

### ❌ Invalid Date Format
**Error:** Google doesn't recognize date
```json
"datePublished": "Jan 15, 2024"  // Wrong format
```

**Fix:** Use ISO format
```json
"datePublished": "2024-01-15"  // Correct: YYYY-MM-DD
```

---

## 📊 SEO Impact & Benefits

### What Structured Data Does

✅ **Rich Search Results**
- Star ratings may appear in Google search results
- Enhanced snippets with review count
- Higher click-through rates (CTR)

✅ **Better Search Understanding**
- Google knows this is a service with reviews
- Helps match to relevant searches
- Improves content categorization

✅ **Knowledge Graph**
- Data may appear in Knowledge Panel
- Shows credibility and social proof
- Builds brand authority

### Expected Timeline

- **Week 1:** Google discovers structured data
- **Week 2-4:** Data processed and validated
- **Month 2-3:** Rich results may start appearing
- **Month 6+:** Consistent rich results in SERPs

### Monitoring

Check these regularly:

1. **Google Search Console**
   - Enhancements → Review snippets
   - Check for errors/warnings

2. **Rich Results Test**
   - Test URL weekly: https://search.google.com/test/rich-results
   - Ensure eligibility maintained

3. **Live Search**
   - Google: "Abdu Mappuji mentoring"
   - Check if stars appear
   - Monitor over time

---

## 📋 Quick Reference Checklist

When adding a new review:

- [ ] Collect reviewer information (name, title, URL)
- [ ] Get review text and date
- [ ] Confirm rating (1-5 stars)
- [ ] Format as JSON following template
- [ ] Add to `/public/index.html` review array
- [ ] Increment `ratingCount` in aggregateRating
- [ ] Recalculate `ratingValue` if needed
- [ ] Update `/build/index.html` (minified)
- [ ] Validate JSON syntax (jsonlint.com)
- [ ] Validate Schema.org (validator.schema.org)
- [ ] Test with Google Rich Results Test
- [ ] Deploy and monitor Google Search Console

---

## 🔗 Useful Links

### Validation Tools
- JSON Linter: https://jsonlint.com/
- JSON Minifier: https://jsonformatter.org/json-minify
- Schema.org Validator: https://validator.schema.org/
- Google Rich Results Test: https://search.google.com/test/rich-results

### Documentation
- Schema.org Product: https://schema.org/Product
- Schema.org Review: https://schema.org/Review
- Schema.org Rating: https://schema.org/Rating
- Google Review Guidelines: https://developers.google.com/search/docs/appearance/structured-data/review-snippet

### Calculators
- Average Calculator: https://www.calculator.net/average-calculator.html
- Date Format Converter: https://www.timestamp-converter.com/

---

## 🤝 Related Documentation

- **SEO Guide:** `/docs/SEO_GUIDE.md` - Overall SEO strategy
- **Sitemap Guide:** `/docs/SITEMAP_GUIDE.md` - Sitemap management
- **Implementation Checklist:** `/docs/STRUCTURED_DATA_CHECKLIST.md` - Post-deployment tasks and tracking
- **Implementation Summary:** `/docs/IMPLEMENTATION_SUMMARY.md` - Quick overview of what was implemented
- **Agents Guide:** `/AGENTS.md` - Main documentation index

---

## 📝 Update Log

Track major changes to structured data:

| Date | Change | Updated By |
|------|--------|------------|
| 2026-01-23 | Initial implementation with 2 reviews (Edo & Aurélien) | GitHub Copilot |
| | | |
| | | |

**Usage:**
- Add a row when adding/removing reviews
- Note rating changes
- Track who made the update

---

## 💡 Pro Tips

1. **Always 5 Stars?**
   - Current strategy: Only show 5-star reviews
   - This maintains perfect 5.0 aggregate rating
   - Alternative: Include 4-star reviews for authenticity (updates aggregate to ~4.7)

2. **How Many Reviews?**
   - Google prefers 5+ reviews for rich results
   - Current: 2 reviews (goal: add 3 more)
   - Add reviews as more mentees provide testimonials

3. **Review Dates**
   - Keep reviews recent (within 1-2 years)
   - Consider removing very old reviews
   - Update dates when mentee changes companies

4. **Author URLs**
   - LinkedIn preferred for professionals
   - Twitter/GitHub acceptable
   - Personal website OK
   - Not required but recommended

5. **Review Text Length**
   - Google prefers 50-500 words
   - Current reviews: 100-150 words (good range)
   - Include specific outcomes/results

---

**Last Updated:** January 23, 2026  
**Document Owner:** Abdu Mappuji  
**Status:** Active & Maintained

---

## 🆘 Need Help?

If you're stuck:

1. **Syntax errors:** Use jsonlint.com to identify the problem
2. **Schema errors:** Check validator.schema.org for specific issues
3. **Not showing in Google:** Wait 2-4 weeks, then check Search Console
4. **Other issues:** Review this guide section by section

**Remember:** Structured data is invisible to users but powerful for SEO. Take your time to get it right! 🚀
