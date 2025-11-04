# Static Website Template

A modern, responsive static website template built with HTML5, CSS3, and vanilla JavaScript. Perfect for landing pages, portfolios, documentation sites, and simple web projects.

## Features

- ✅ Responsive design (mobile-first)
- ✅ Modern CSS Grid and Flexbox layouts
- ✅ Vanilla JavaScript (no framework dependencies)
- ✅ SEO optimized
- ✅ Accessibility (WCAG 2.1)
- ✅ Performance optimized
- ✅ Cross-browser compatible
- ✅ Dark mode support
- ✅ Contact form
- ✅ GitHub Pages ready

## Quick Start

### Prerequisites

- Web browser
- Text editor
- Local web server (optional, for development)

### Installation

```bash
# Download template
cp -r templates/static-website my-website
cd my-website

# That's it! No build process required.
```

### View Locally

**Option 1: Python**
```bash
python -m http.server 8000
```

**Option 2: Node.js**
```bash
npx serve
```

**Option 3: VS Code Live Server**
- Install Live Server extension
- Right-click `index.html`
- Select "Open with Live Server"

Then open `http://localhost:8000` in your browser.

## Project Structure

```
static-website/
├── index.html              # Homepage
├── about.html             # About page
├── contact.html           # Contact page
├── css/
│   ├── style.css          # Main styles
│   ├── responsive.css     # Media queries
│   └── dark-mode.css      # Dark mode styles
├── js/
│   ├── main.js            # Main JavaScript
│   ├── navigation.js      # Menu and navigation
│   └── form.js            # Form handling
├── images/
│   ├── logo.svg
│   ├── hero.jpg
│   └── icons/
├── fonts/                 # Custom fonts (optional)
├── assets/                # Other assets
├── .gitignore
└── README.md
```

## Customization

### Update Site Information

**1. Edit `index.html`:**

```html
<head>
  <title>Your Site Name</title>
  <meta name="description" content="Your site description">
  <meta name="author" content="Your Name">
</head>

<body>
  <header>
    <h1>Your Site Name</h1>
    <p>Your tagline or description</p>
  </header>
</body>
```

**2. Update Colors** (`css/style.css`):

```css
:root {
  /* Primary colors */
  --primary-color: #007bff;
  --secondary-color: #6c757d;
  --accent-color: #28a745;
  
  /* Neutral colors */
  --text-color: #333;
  --background-color: #fff;
  --border-color: #dee2e6;
  
  /* Fonts */
  --font-family: 'Inter', -apple-system, sans-serif;
  --font-size-base: 16px;
}
```

**3. Update Logo and Images:**

Replace files in `/images/` directory:
- `logo.svg` - Your logo
- `hero.jpg` - Hero/banner image
- `favicon.ico` - Browser favicon

### Add New Pages

1. **Create HTML file** (`services.html`):

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Services - Your Site</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <nav>
    <!-- Navigation menu -->
  </nav>
  
  <main>
    <h1>Our Services</h1>
    <!-- Content -->
  </main>
  
  <footer>
    <!-- Footer -->
  </footer>
  
  <script src="js/main.js"></script>
</body>
</html>
```

2. **Add to navigation** (all HTML files):

```html
<nav>
  <ul>
    <li><a href="index.html">Home</a></li>
    <li><a href="about.html">About</a></li>
    <li><a href="services.html">Services</a></li>
    <li><a href="contact.html">Contact</a></li>
  </ul>
</nav>
```

## Sections

### Hero Section

```html
<section class="hero">
  <div class="container">
    <h1>Welcome to Our Site</h1>
    <p>Your compelling tagline goes here</p>
    <a href="#learn-more" class="btn btn-primary">Learn More</a>
  </div>
</section>
```

```css
.hero {
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  color: white;
  text-align: center;
  padding: 100px 20px;
}
```

### Features Section

```html
<section class="features">
  <div class="container">
    <h2>Features</h2>
    <div class="feature-grid">
      <div class="feature">
        <img src="images/icons/feature1.svg" alt="Feature 1">
        <h3>Feature Title</h3>
        <p>Feature description goes here</p>
      </div>
      <!-- More features... -->
    </div>
  </div>
</section>
```

```css
.feature-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  margin-top: 40px;
}
```

### Contact Form

```html
<form id="contact-form">
  <div class="form-group">
    <label for="name">Name</label>
    <input type="text" id="name" name="name" required>
  </div>
  
  <div class="form-group">
    <label for="email">Email</label>
    <input type="email" id="email" name="email" required>
  </div>
  
  <div class="form-group">
    <label for="message">Message</label>
    <textarea id="message" name="message" rows="5" required></textarea>
  </div>
  
  <button type="submit" class="btn btn-primary">Send Message</button>
</form>
```

```javascript
// js/form.js
document.getElementById('contact-form').addEventListener('submit', function(e) {
  e.preventDefault();
  
  const formData = {
    name: document.getElementById('name').value,
    email: document.getElementById('email').value,
    message: document.getElementById('message').value
  };
  
  // Send to backend or email service
  console.log('Form submitted:', formData);
  alert('Thank you for your message!');
});
```

## Responsive Design

### Mobile-First Approach

```css
/* Mobile styles (default) */
.container {
  width: 100%;
  padding: 0 20px;
}

/* Tablet */
@media (min-width: 768px) {
  .container {
    max-width: 720px;
    margin: 0 auto;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  .container {
    max-width: 960px;
  }
}

/* Large Desktop */
@media (min-width: 1280px) {
  .container {
    max-width: 1200px;
  }
}
```

### Responsive Navigation

```html
<nav class="navbar">
  <div class="nav-brand">
    <img src="images/logo.svg" alt="Logo">
  </div>
  
  <button class="nav-toggle" aria-label="Toggle navigation">
    <span></span>
    <span></span>
    <span></span>
  </button>
  
  <ul class="nav-menu">
    <li><a href="index.html">Home</a></li>
    <li><a href="about.html">About</a></li>
    <li><a href="contact.html">Contact</a></li>
  </ul>
</nav>
```

```javascript
// js/navigation.js
const toggle = document.querySelector('.nav-toggle');
const menu = document.querySelector('.nav-menu');

toggle.addEventListener('click', () => {
  menu.classList.toggle('active');
});
```

## Dark Mode

### Toggle Implementation

```html
<button id="theme-toggle" aria-label="Toggle dark mode">
  <span class="icon-sun">☀️</span>
  <span class="icon-moon">🌙</span>
</button>
```

```javascript
// js/main.js
const themeToggle = document.getElementById('theme-toggle');
const html = document.documentElement;

// Load saved theme
const savedTheme = localStorage.getItem('theme') || 'light';
html.setAttribute('data-theme', savedTheme);

themeToggle.addEventListener('click', () => {
  const currentTheme = html.getAttribute('data-theme');
  const newTheme = currentTheme === 'light' ? 'dark' : 'light';
  
  html.setAttribute('data-theme', newTheme);
  localStorage.setItem('theme', newTheme);
});
```

```css
/* css/dark-mode.css */
:root {
  --bg-color: #ffffff;
  --text-color: #333333;
}

[data-theme="dark"] {
  --bg-color: #1a1a1a;
  --text-color: #f0f0f0;
}

body {
  background-color: var(--bg-color);
  color: var(--text-color);
  transition: background-color 0.3s, color 0.3s;
}
```

## SEO Optimization

### Meta Tags

```html
<head>
  <!-- Basic Meta Tags -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Your Page Title - Site Name</title>
  <meta name="description" content="Your page description (150-160 characters)">
  <meta name="keywords" content="keyword1, keyword2, keyword3">
  <meta name="author" content="Your Name">
  
  <!-- Open Graph (Facebook, LinkedIn) -->
  <meta property="og:title" content="Your Page Title">
  <meta property="og:description" content="Your page description">
  <meta property="og:image" content="https://yoursite.com/images/og-image.jpg">
  <meta property="og:url" content="https://yoursite.com">
  <meta property="og:type" content="website">
  
  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="Your Page Title">
  <meta name="twitter:description" content="Your page description">
  <meta name="twitter:image" content="https://yoursite.com/images/twitter-card.jpg">
  
  <!-- Favicon -->
  <link rel="icon" type="image/png" href="images/favicon.png">
  <link rel="apple-touch-icon" href="images/apple-touch-icon.png">
</head>
```

### Structured Data

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Your Company Name",
  "url": "https://yoursite.com",
  "logo": "https://yoursite.com/images/logo.png",
  "contactPoint": {
    "@type": "ContactPoint",
    "telephone": "+1-123-456-7890",
    "contactType": "Customer Service"
  }
}
</script>
```

## Performance Optimization

### Image Optimization

```html
<!-- Responsive images -->
<img 
  src="images/photo-800.jpg" 
  srcset="
    images/photo-400.jpg 400w,
    images/photo-800.jpg 800w,
    images/photo-1200.jpg 1200w
  "
  sizes="(max-width: 600px) 400px, (max-width: 1000px) 800px, 1200px"
  alt="Description"
  loading="lazy"
>

<!-- Modern formats with fallback -->
<picture>
  <source srcset="images/photo.webp" type="image/webp">
  <source srcset="images/photo.jpg" type="image/jpeg">
  <img src="images/photo.jpg" alt="Description">
</picture>
```

### CSS Optimization

```html
<!-- Inline critical CSS -->
<style>
  /* Above-the-fold styles */
  body { font-family: sans-serif; }
  .hero { min-height: 100vh; }
</style>

<!-- Defer non-critical CSS -->
<link rel="preload" href="css/style.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="css/style.css"></noscript>
```

### JavaScript Optimization

```html
<!-- Defer JavaScript -->
<script src="js/main.js" defer></script>

<!-- Async for independent scripts -->
<script src="js/analytics.js" async></script>
```

## Deployment

### GitHub Pages

1. **Push to GitHub:**
```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/username/repo.git
git push -u origin main
```

2. **Enable GitHub Pages:**
- Go to repository Settings
- Navigate to Pages section
- Select source: `main` branch, `/ (root)`
- Save

3. **Access your site:**
`https://username.github.io/repo/`

### Custom Domain

Add `CNAME` file:
```
yourdomain.com
```

Configure DNS:
```
Type: A
Name: @
Value: 185.199.108.153
       185.199.109.153
       185.199.110.153
       185.199.111.153

Type: CNAME
Name: www
Value: username.github.io
```

### Netlify

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Deploy
netlify deploy

# Production deploy
netlify deploy --prod
```

## Accessibility

### ARIA Labels

```html
<button aria-label="Close menu">×</button>
<nav aria-label="Main navigation">...</nav>
<img src="photo.jpg" alt="Descriptive text">
```

### Keyboard Navigation

```css
/* Focus styles */
a:focus, button:focus {
  outline: 2px solid var(--primary-color);
  outline-offset: 2px;
}

/* Skip to content link */
.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  background: var(--primary-color);
  color: white;
  padding: 8px;
}

.skip-link:focus {
  top: 0;
}
```

## Browser Compatibility

Tested on:
- ✅ Chrome/Edge (latest)
- ✅ Firefox (latest)
- ✅ Safari (latest)
- ✅ iOS Safari
- ✅ Chrome Android

## Resources

- [MDN Web Docs](https://developer.mozilla.org/)
- [Can I Use](https://caniuse.com/) - Browser compatibility
- [Web.dev](https://web.dev/) - Best practices
- [CSS-Tricks](https://css-tricks.com/)
- [A11y Project](https://www.a11yproject.com/) - Accessibility

## License

MIT License - see [LICENSE](../../LICENSE) for details.
