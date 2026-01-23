# Appearances Page Structured Data

**Date:** January 23, 2026  
**Type:** ItemList with Event items  
**Location:** `/appearances` page only  
**Count:** 21 tech talks and speaking engagements

---

## 📊 What Was Added

### Schema Type: ItemList with Event Items

**Structure:**
- `@type`: "ItemList" (container for all talks)
- `name`: "Tech Talks and Speaking Engagements by Abdu Mappuji"
- `itemListElement`: Array of 21 Event items (ListItem)

**Each Event includes:**
- Event name and description
- Start date (year or specific date)
- Event attendance mode (Online/Offline)
- Event status (Scheduled/Cancelled)
- Location (VirtualLocation or Place)
- Performer (Abdu Mappuji)
- Organizer (conference/meetup name)
- Language (where applicable)

---

## 🎯 SEO Benefits

### Rich Results Eligibility

**Event Rich Results:**
- May appear in Google Search with event details
- Shows event dates, locations, and organizers
- Can appear in Google Events search
- Helps with local search for in-person events

**Knowledge Graph:**
- Contributes to speaker profile
- Shows speaking history
- Builds authority in tech topics
- Links to video recordings

---

## 📝 Complete Event List

### 2025 (1 event)
1. **Building and monetizing MCP servers on Apify**
   - Online event
   - Platform: YouTube Live

### 2024 (1 event)
2. **Road to Devcon: Empowering Web3 Innovators**
   - Gadjah Mada Blockchain Club
   - Online event

### 2023 (1 event)
3. **Hologram AI Pitch**
   - Encode Club
   - Online event

### 2022 (5 events)
4. **Complete Web3 & Ethereum with Scala** - Ya!vaConf (Sep 28, 2022)
5. **Web3 & Ethereum with Scala** - ScalaWAW (Sep 6, 2022)
6. **DAO Masterclass** - Remote Skills Academy
7. **Developer Perspective on Web3** - Republik Rupiah (Indonesian)
8. **Smart Contract Discussion** - Podcast Indonesia Belajar (Indonesian)

### 2021 (5 events)
9. **Low-code Masterclass with Retool** - Remote Skills Academy Bali (Indonesian)
10. **Blockchain 101 with Python** - PyCon Indonesia
11. **Russian Doll Caching for SSR** - Web Directions Lazy Load
12. **Typesafe Web Development with Eta** - Conf42 Java
13. **KulWeekend #3: Markov Chain Bots** - Kulkul Tech

### 2020 (5 events)
14. **KulWeekend #2: Data Cleaning** - Kulkul Tech
15. **KulWeekend #1: Python & Web Scraping** - Kulkul Tech
16. **Build and Deploy Your First Website** - KulTalks (Indonesian)
17. **Intro to Git & GitHub** - SabernX (Indonesian)
18. **How Teaching Convinced Me to Use Elm** - ElmJapan (Cancelled - COVID-19)

### 2018 (2 events)
19. **Deploy Moodle in Raspberry Pi** - MoodleMoot Philippines
20. **DevOps Practice in Nonprofit** - DevOpsDay Jakarta

### 2017 (1 event)
21. **Playful Load Testing with Locust** - PyCon Indonesia Surabaya

---

## 🎓 Topics Covered

### Primary Topics:
- **Web3 & Blockchain:** 6 talks (Ethereum, DAO, Smart Contracts)
- **Python:** 4 talks (PyCon presentations, data science)
- **DevOps:** 2 talks (Docker, DevOps practices)
- **Functional Programming:** 3 talks (Elm, Eta, Scala)
- **Low-code/No-code:** 1 talk (Retool)
- **General Development:** 5 talks (Git, web development, data)

### Languages:
- **English:** 15 talks
- **Indonesian (Bahasa):** 6 talks

### Event Formats:
- **Online:** 18 events
- **In-person:** 2 events
- **Cancelled:** 1 event (COVID-19)

---

## 🔧 How to Update

### Adding a New Talk

1. Open `/src/Main.elm`
2. Find `getStructuredDataForRoute` function
3. Locate the `Appearances ->` case
4. Extract and format the JSON using https://jsonformatter.org/
5. Add new event to the `itemListElement` array:

```json
{
  "@type": "ListItem",
  "position": 22,
  "item": {
    "@type": "Event",
    "name": "Your Talk Title",
    "description": "Brief description of the talk",
    "startDate": "2026-01-23",
    "eventAttendanceMode": "https://schema.org/OnlineEventAttendanceMode",
    "eventStatus": "https://schema.org/EventScheduled",
    "location": {
      "@type": "VirtualLocation",
      "url": "https://youtube.com/watch?v=..."
    },
    "performer": {
      "@type": "Person",
      "name": "Abdu Mappuji",
      "url": "https://mpj.io"
    },
    "organizer": {
      "@type": "Organization",
      "name": "Conference Name"
    }
  }
}
```

6. Update position numbers if needed
7. Minify the JSON using https://jsonformatter.org/json-minify
8. Replace in Elm code
9. Compile and test

### Event Attendance Modes

Use the appropriate mode:
- **Online:** `https://schema.org/OnlineEventAttendanceMode`
- **In-person:** `https://schema.org/OfflineEventAttendanceMode`
- **Hybrid:** `https://schema.org/MixedEventAttendanceMode`

### Event Status

- **Scheduled:** `https://schema.org/EventScheduled`
- **Cancelled:** `https://schema.org/EventCancelled`
- **Postponed:** `https://schema.org/EventPostponed`
- **Rescheduled:** `https://schema.org/EventRescheduled`

### Location Types

**For online events:**
```json
"location": {
  "@type": "VirtualLocation",
  "url": "https://youtube.com/..."
}
```

**For in-person events:**
```json
"location": {
  "@type": "Place",
  "name": "Conference Name",
  "url": "https://conference.com"
}
```

---

## ✅ Validation

### Test the Structured Data

1. **Local Testing:**
   ```bash
   cd website
   npm start
   ```
   Visit: http://localhost:3000/appearances
   View source → Check for ItemList schema

2. **Google Rich Results Test:**
   - URL: https://search.google.com/test/rich-results
   - Test: https://mpj.io/appearances
   - Should show valid ItemList with Event items

3. **Schema.org Validator:**
   - URL: https://validator.schema.org/
   - Paste the structured data
   - Should validate without errors

### Expected Results

✅ **ItemList detected**  
✅ **21 Event items found**  
✅ **All required fields present**  
✅ **Valid date formats**  
✅ **Valid URLs**

---

## 📈 SEO Impact

### Search Visibility

**Before:**
- Plain text list of talks
- No rich snippets
- Limited discoverability

**After:**
- Event rich results eligible
- Structured event information
- Better search visibility
- Can appear in Events search
- Shows in Knowledge Graph

### Expected Timeline

- **Week 1:** Google discovers structured data
- **Week 2-4:** Data processed and indexed
- **Month 2-3:** Rich results may start appearing
- **Month 6+:** Consistent rich results in search

---

## 🎯 Best Practices

### When Adding Events

1. **Use specific dates** when available (not just year)
2. **Include video links** for online talks
3. **Add language tag** for non-English talks (`"inLanguage": "id"`)
4. **Use descriptive names** that include the topic
5. **Keep descriptions concise** but informative

### Maintaining Data Quality

- ✅ Update cancelled events with correct status
- ✅ Add new talks chronologically (newest first)
- ✅ Ensure all URLs are working
- ✅ Include organizer information
- ✅ Specify event attendance mode accurately

---

## 📊 Analytics

### Monitor Performance

**Google Search Console:**
- Check "Enhancements" → Event structured data
- Monitor impressions and clicks
- Track errors and warnings

**What to Track:**
- Number of indexed events
- Rich result appearances
- Click-through rates
- Search queries leading to events

---

## 🔗 Related Documentation

- **Main Guide:** `/docs/STRUCTURED_DATA_GUIDE.md`
- **Architecture:** `/docs/PAGE_SPECIFIC_STRUCTURED_DATA.md`
- **HireMe Reviews:** See main guide for review structured data
- **Implementation:** `/docs/IMPLEMENTATION_SUMMARY.md`

---

## 💡 Future Enhancements

### Possible Additions

1. **Add more event details:**
   - Duration
   - Audience size
   - Event images
   - Registration URLs

2. **Link related content:**
   - Blog posts about talks
   - Slides/presentation materials
   - Related videos

3. **Add more metadata:**
   - Event topics/keywords
   - Target audience level
   - Prerequisites

---

**Status:** ✅ Implemented and ready for deployment  
**Last Updated:** January 23, 2026  
**Total Events:** 21 talks (2017-2025)

---

*This structured data helps Google and other search engines understand your speaking history and may result in rich event listings in search results.*
