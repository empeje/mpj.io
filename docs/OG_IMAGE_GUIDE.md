# Open Graph Image Optimization Guide

## Current Status ✅ Partially Complete

### What's Fixed:
- ✅ **Title length optimized**: 54 characters (was 64) - now in the 50-60 optimal range
  - Old: "Abdu 'Códigos' Mappuji - The CTO-mentor, Engineer, Legal Scholar" (64 chars)
  - New: "Abdu Mappuji - CTO-Mentor, Engineer & Legal Scholar" (54 chars)
- ✅ **Meta tags updated**: Both `public/index.html` and `build/index.html` now reference `og-image.jpg`
- ✅ **Correct dimensions declared**: 1200x630px in meta tags

### What Still Needs To Be Done:

## 🎨 Create the OG Image: `og-image.jpg`

The meta tags now reference `https://mpj.io/og-image.jpg`, but this image needs to be created with the following specifications:

### Image Specifications
- **Dimensions**: 1200px × 630px (landscape orientation)
- **Format**: JPEG or PNG
- **File size**: Under 1MB (ideally under 300KB for fast loading)
- **Location**: `/website/public/og-image.jpg` (and `/website/build/og-image.jpg`)

### Required Elements in the Image

#### 1. Clear Headline ⚠️
Add text overlay on the image with your main message:
```
Abdu Mappuji
CTO-Mentor & Software Engineer
```

**Typography recommendations:**
- Use bold, sans-serif font (e.g., Arial Black, Helvetica Bold, Inter Bold)
- Font size: 64-80px for name, 40-48px for subtitle
- Color: High contrast (white text on dark background or dark text on light background)
- Add subtle shadow or outline for readability

#### 2. Call-to-Action (CTA) ⚠️
Add a clear action statement, such as:
```
"Book a Mentorship Session"
"Transform Your Tech Leadership"
"Let's Build Together"
"Visit mpj.io"
```

**CTA recommendations:**
- Font size: 32-40px
- Position: Bottom right or bottom center
- Consider adding an arrow or icon
- Use brand color (green from your website: `#28a745` or `--color-primary`)

#### 3. Visual Elements
Based on your current `hero-1.jpg` (2316×3088px portrait photo):

**Option A - Professional Photo Crop**
1. Crop the portrait photo to 1200×630 landscape
2. Position your face on the left/center third
3. Add text overlay on the right side with semi-transparent background
4. Ensure text is readable with proper contrast

**Option B - Brand-Focused Design**
1. Use a solid background or gradient
2. Add your logo or website URL
3. Include professional photo as circular avatar (300×300px)
4. More space for headline and CTA text

**Option C - Hybrid Approach**
1. Blurred or darkened version of hero-1.jpg as background
2. Clear, bold text overlay in the center
3. Professional but text-focused

### Design Safe Zones
Remember that different platforms crop OG images differently:
- **Facebook**: Full 1200×630 display
- **LinkedIn**: Crops to ~1200×627
- **Twitter**: Crops to 2:1 ratio
- **Safe zone**: Keep important elements within 1104×552 centered area

### Design Tools & Methods

#### Method 1: Online Tools (Easiest)
- **Canva** (canva.com) - Free templates for "Facebook Post" or "Twitter Post"
- **Pablo by Buffer** (pablo.buffer.com)
- **Figma** (figma.com) - Free design tool with OG image templates

#### Method 2: Desktop Tools
- **Adobe Photoshop** - Professional option
- **GIMP** - Free alternative to Photoshop
- **Sketch** - Mac only
- **Affinity Designer** - One-time purchase

#### Method 3: Command Line (For cropping hero-1.jpg)
If you just want to crop the existing image:

```bash
# Using ImageMagick (install: brew install imagemagick)
magick convert hero-1.jpg -resize 1200x630^ -gravity center -extent 1200x630 og-image-base.jpg

# Then add text overlay manually in a design tool
```

#### Method 4: Node.js Script (Automated)
Install sharp for image processing:

```bash
npm install sharp
```

Create a script `scripts/generate-og-image.js`:

```javascript
const sharp = require('sharp');

async function createOGImage() {
  await sharp('public/hero-1.jpg')
    .resize(1200, 630, {
      fit: 'cover',
      position: 'center'
    })
    .jpeg({ quality: 85 })
    .toFile('public/og-image-base.jpg');
  
  console.log('Base OG image created! Now add text overlay manually.');
}

createOGImage();
```

## Current File References

The following files now reference `og-image.jpg`:
- `/website/public/index.html` - Source HTML template
- `/website/build/index.html` - Built production HTML

Both files expect the image at:
- Development: `/website/public/og-image.jpg`
- Production: `https://mpj.io/og-image.jpg`

## Testing Your OG Image

### Before Going Live:
1. **Facebook Debugger**: https://developers.facebook.com/tools/debug/
2. **Twitter Card Validator**: https://cards-dev.twitter.com/validator
3. **LinkedIn Post Inspector**: https://www.linkedin.com/post-inspector/
4. **Meta Tags Checker**: https://metatags.io/

### What to Check:
- ✅ Image displays at correct size (1200×630)
- ✅ Text is readable on all platforms
- ✅ CTA is visible and clear
- ✅ File size is under 1MB
- ✅ Image loads quickly
- ✅ No important elements are cut off

## Recommended Next Steps

1. **Create the image** using one of the methods above
2. **Save as** `og-image.jpg` in both:
   - `/website/public/og-image.jpg`
   - `/website/build/og-image.jpg`
3. **Test** using the validation tools above
4. **Deploy** and verify on production

## Example Text Overlay Layout

```
┌─────────────────────────────────────────────────┐
│                                                 │
│  [Background: hero-1.jpg cropped/blurred]       │
│                                                 │
│           Abdu Mappuji                          │
│           CTO-Mentor & Software Engineer        │
│                                                 │
│           Helping tech leaders grow through     │
│           mentorship & technical expertise      │
│                                                 │
│                           Visit mpj.io →        │
└─────────────────────────────────────────────────┘
    1200px × 630px
```

## Brand Colors (from website)

Use these colors from your website for consistency:
- **Primary Green**: `#28a745` - For CTAs and accents
- **Dark Background**: `#1a1a1a` or `#2c2c2c`
- **Light Text**: `#ffffff` or `#f8f9fa`
- **Text**: `#333333` (on light backgrounds)

---

**Status**: ⚠️ Waiting for `og-image.jpg` to be created
**Last Updated**: January 23, 2026
