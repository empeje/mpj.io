# Navigation Structure Quick Reference

## Top Navigation Menu

```
┌─ Home (/)
│
├─ Product ▼
│  └─ Sistemas (external: https://sistemas.mpj.io)
│
├─ Erudition ▼
│  ├─ Blog (external: https://blog.mpj.io)
│  ├─ Writings (/writings) ← NEW PAGE
│  ├─ Substack (external)
│  ├─ YouTube (external)
│  └─ Leanpub (external)
│
├─ Jurisprudence ▼
│  └─ LawTech (external)
│
└─ More ▼
   ├─ Hire Me (/hire-me) ← NEW PAGE
   ├─ Entrepreneurship (/entrepreneurship) ← NEW PAGE
   ├─ Google Scholar (external)
   ├─ Legacy Blog (external)
   └─ Offers (/offers) ← NEW PAGE
```

## Page Routing Map

| URL Path              | Page Module              | Main Content                          |
|-----------------------|--------------------------|---------------------------------------|
| `/`                   | Pages.Home               | Hero, Newsletter, As Seen At, Teasers |
| `/appearances`        | Pages.Appearances        | Talks (all) + Coverages               |
| `/hire-me`            | Pages.HireMe             | fCTO, Mentoring, Mentees, Recent Event|
| `/writings`           | Pages.Writings           | Blogs + Publications                  |
| `/entrepreneurship`   | Pages.Entrepreneurship   | Companies + Investments               |
| `/offers`             | Pages.Offers             | Referrals (with search)               |
| `/*` (any other)      | NotFound                 | 404 Page                              |

## Content Distribution

### viewRecentEvent
- ✅ Home page (top 2 talks)
- ✅ HireMe page (bottom, top 2 talks)

### All Talks (21 talks)
- ✅ Appearances page (full list)
- Partial on Home & HireMe via viewRecentEvent

### Full Sections
- **Talks** → Appearances
- **Coverages** → Appearances  
- **Blogs** → Writings
- **Publications** → Writings
- **Companies** → Entrepreneurship
- **Investments** → Entrepreneurship
- **Referrals** → Offers
- **Mentoring** → HireMe (exclusive)

## Color Rotation (Iconic Design)

Border colors rotate through content lists:
- 🔴 **Red** (`--color-danger: #C15050`) - index % 3 == 0
- 🟢 **Green** (`--color-primary: #00917C`) - index % 2 == 0
- 🔵 **Blue** (`--color-blue: #28527A`) - everything else

Applied to:
- Navigation dropdowns
- Content lists (talks, blogs, publications, etc.)
- Referral table rows
