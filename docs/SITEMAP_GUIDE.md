# Sitemap Implementation Guide

## Overview

The website has a complete sitemap implementation with automated weekly updates via GitHub Actions. This ensures search engines always see fresh content and helps with SEO rankings.

---

## 📁 Files Created

### Sitemap Files
- **`/public/sitemap.xml`** - Source sitemap for development
- **`/build/sitemap.xml`** - Production sitemap (deployed version)

### Robots File
- **`/public/robots.txt`** - Tells search engines where to find the sitemap
- **`/build/robots.txt`** - Production robots.txt

### GitHub Actions
- **`.github/workflows/update-sitemap.yml`** - Automated weekly sitemap updater

---

## 🗺️ Sitemap Structure

### Pages Included

All website pages are included in the sitemap with appropriate priorities:

| Page | URL | Priority | Change Frequency |
|------|-----|----------|------------------|
| Home | `https://mpj.io/` | 1.0 | weekly |
| Hire Me | `https://mpj.io/hire-me` | 0.9 | monthly |
| Writings | `https://mpj.io/writings` | 0.8 | weekly |
| Appearances | `https://mpj.io/appearances` | 0.8 | monthly |
| Entrepreneurship | `https://mpj.io/entrepreneurship` | 0.7 | monthly |
| Offers | `https://mpj.io/offers` | 0.6 | monthly |

### Priority Explanation
- **1.0** = Most important page (Homepage)
- **0.9** = High priority (Primary CTA - Hire Me)
- **0.8** = Important content pages (Writings, Appearances)
- **0.7** = Secondary content (Entrepreneurship)
- **0.6** = Utility pages (Offers)

### Change Frequency
- **weekly** = Content updates regularly (Home, Writings)
- **monthly** = Updates less frequently (other pages)

---

## 🤖 Automated Updates

### GitHub Actions Workflow

The sitemap is automatically updated **every Sunday at 00:00 UTC** (weekly).

#### What It Does:
1. ✅ Updates all `<lastmod>` dates to the current date
2. ✅ Updates both `public/sitemap.xml` and `build/sitemap.xml`
3. ✅ Commits and pushes changes automatically
4. ✅ Can be manually triggered via GitHub UI

#### Workflow Details:

**File**: `.github/workflows/update-sitemap.yml`

**Schedule**: 
- Runs every Sunday at 00:00 UTC
- Cron expression: `0 0 * * 0`

**Manual Trigger**:
You can manually trigger the workflow from GitHub:
1. Go to your repository on GitHub
2. Click "Actions" tab
3. Select "Update Sitemap" workflow
4. Click "Run workflow"

**What Gets Updated**:
```xml
<!-- Before -->
<lastmod>2026-01-23</lastmod>

<!-- After (next Sunday) -->
<lastmod>2026-01-30</lastmod>
```

---

## 🔍 SEO Benefits

### Why Weekly Updates Matter

1. **Fresh Content Signal** - Search engines see your site as active
2. **Crawl Priority** - Updated lastmod encourages more frequent crawling
3. **Index Freshness** - Helps maintain current search rankings
4. **Discovery** - New content gets discovered faster

### Google Search Console Integration

After deploying, submit your sitemap to Google:

1. Go to [Google Search Console](https://search.google.com/search-console)
2. Select your property (mpj.io)
3. Navigate to: **Sitemaps** (in left sidebar)
4. Add sitemap URL: `https://mpj.io/sitemap.xml`
5. Click "Submit"

### Bing Webmaster Tools Integration

1. Go to [Bing Webmaster Tools](https://www.bing.com/webmasters)
2. Add/verify your site
3. Navigate to: **Sitemaps**
4. Submit: `https://mpj.io/sitemap.xml`

---

## 🧪 Testing

### Local Testing

#### Verify Sitemap Syntax:
```bash
cd /Users/abdurrachmanmappuji/Development/the-enterprise/website/public
xmllint --noout sitemap.xml
```

If no errors, the syntax is valid!

#### View Sitemap Locally:
```bash
# Start dev server
cd /Users/abdurrachmanmappuji/Development/the-enterprise/website
npm run dev

# Visit in browser:
# http://localhost:8001/sitemap.xml
```

### Production Testing

After deployment, test these URLs:

1. **Sitemap**: https://mpj.io/sitemap.xml
2. **Robots**: https://mpj.io/robots.txt

### Online Validators

- **XML Sitemap Validator**: https://www.xml-sitemaps.com/validate-xml-sitemap.html
- **Google Sitemap Test**: Use Google Search Console → Sitemaps → Test

---

## 📝 Maintenance

### Adding New Pages

When you add a new page to the website:

1. **Update routing** in `src/Main.elm`
2. **Add to sitemap** in both:
   - `public/sitemap.xml`
   - `build/sitemap.xml`

Example:
```xml
<url>
  <loc>https://mpj.io/new-page</loc>
  <lastmod>2026-01-23</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.8</priority>
</url>
```

3. **Choose appropriate values**:
   - `priority`: 0.5 to 1.0 (how important relative to other pages)
   - `changefreq`: daily, weekly, monthly, yearly
   - `lastmod`: Current date (will be auto-updated weekly)

### Modifying Update Frequency

To change from weekly to a different schedule, edit `.github/workflows/update-sitemap.yml`:

```yaml
schedule:
  # Daily at midnight
  - cron: '0 0 * * *'
  
  # Weekly on Sunday (current)
  - cron: '0 0 * * 0'
  
  # Bi-weekly (every other Sunday)
  - cron: '0 0 1,15 * *'
  
  # Monthly (1st of each month)
  - cron: '0 0 1 * *'
```

**Cron Helper**: https://crontab.guru/

---

## 🔧 Troubleshooting

### Workflow Not Running?

1. **Check if GitHub Actions are enabled**:
   - Go to repository Settings → Actions → Allow all actions

2. **Verify the workflow file is in the correct location**:
   ```
   .github/workflows/update-sitemap.yml
   ```

3. **Check workflow runs**:
   - GitHub → Actions tab → View recent runs

### Changes Not Committing?

The workflow only commits if there are actual changes. If the sitemap already has the current date, no commit is made.

**Force an update**:
1. Manually change a date in `public/sitemap.xml`
2. Wait for next scheduled run, or
3. Manually trigger the workflow

### Sitemap Not Accessible Online?

1. **Verify file exists** in build directory
2. **Check build process** includes static files
3. **Test with curl**:
   ```bash
   curl https://mpj.io/sitemap.xml
   ```

---

## 📊 Monitoring

### GitHub Actions Status

Check workflow status:
1. Go to repository on GitHub
2. Click "Actions" tab
3. View "Update Sitemap" workflow runs
4. Green ✅ = Success
5. Red ❌ = Failed (check logs)

### Search Engine Coverage

**Google Search Console**:
- Sitemaps → View submitted sitemaps
- Coverage → See indexed pages
- Should show all 6 pages indexed

**Expected Result**: All 6 URLs indexed and green

---

## 🎯 Best Practices

### Do's ✅
- Keep sitemap updated (automated via GitHub Actions)
- Submit to Google Search Console and Bing
- Monitor indexing status monthly
- Update sitemap when adding new pages
- Use meaningful priorities (1.0 for homepage, 0.5-0.9 for others)

### Don'ts ❌
- Don't set all pages to priority 1.0 (defeats the purpose)
- Don't forget to update build/sitemap.xml when editing manually
- Don't include non-canonical URLs
- Don't include redirect URLs
- Don't exceed 50,000 URLs per sitemap (you're far from this)

---

## 📚 Related Documentation

- **SEO Guide**: [`docs/SEO_GUIDE.md`](./SEO_GUIDE.md)
- **Multi-page Implementation**: [`docs/MULTI_PAGE_IMPLEMENTATION.md`](./MULTI_PAGE_IMPLEMENTATION.md)
- **Navigation Guide**: [`docs/NAVIGATION_GUIDE.md`](./NAVIGATION_GUIDE.md)

---

## 🚀 Deployment Checklist

When deploying the sitemap:

- [ ] Verify `public/sitemap.xml` exists
- [ ] Verify `build/sitemap.xml` exists
- [ ] Verify `public/robots.txt` exists
- [ ] Verify `build/robots.txt` exists
- [ ] Test sitemap is accessible at `https://mpj.io/sitemap.xml`
- [ ] Test robots.txt is accessible at `https://mpj.io/robots.txt`
- [ ] Submit sitemap to Google Search Console
- [ ] Submit sitemap to Bing Webmaster Tools
- [ ] Verify GitHub Action ran successfully
- [ ] Monitor for first automated update (next Sunday)

---

## 📈 Expected Outcomes

### Immediate (0-7 days)
- ✅ Sitemap accessible at mpj.io/sitemap.xml
- ✅ Google Search Console accepts sitemap
- ✅ All 6 pages discovered by Google

### Short-term (1-4 weeks)
- ✅ Weekly automated updates running
- ✅ Improved crawl frequency
- ✅ All pages indexed in Google

### Long-term (1-3 months)
- ✅ Better search rankings for fresh content
- ✅ Faster discovery of new pages
- ✅ Improved SEO performance overall

---

**Status**: ✅ Complete and Automated  
**Last Updated**: January 23, 2026  
**Next Update**: Automated weekly (Sundays at 00:00 UTC)
