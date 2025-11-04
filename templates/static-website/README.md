# Static Website Template

A modern, responsive static website template built with HTML5, CSS3, and vanilla JavaScript.

## Features

- Responsive design (mobile-first)
- Modern CSS Grid and Flexbox
- Vanilla JavaScript (no framework)
- SEO optimized
- Cross-browser compatible
- Dark mode support
- GitHub Pages ready

## Quick Start

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
├── index.html          # Homepage
├── about.html          # About page
├── contact.html        # Contact page
├── css/
│   ├── style.css       # Main styles
│   └── responsive.css  # Media queries
├── js/
│   ├── main.js         # Main JavaScript
│   └── navigation.js   # Menu handling
├── images/             # Images and assets
└── README.md
```

## Customization

### Update Site Information

Edit `index.html`:

```html
<title>Your Site Name</title>
<meta name="description" content="Your site description">
```

### Change Colors

Edit `css/style.css`:

```css
:root {
  --primary-color: #007bff;
  --secondary-color: #6c757d;
  --text-color: #333;
  --background-color: #fff;
}
```

### Add Pages

1. Create new HTML file
2. Copy structure from `index.html`
3. Add to navigation menu

## Deployment

### GitHub Pages

1. Push to GitHub
2. Go to Settings > Pages
3. Select source branch
4. Your site will be at `https://username.github.io/repo/`

### Custom Domain

Add `CNAME` file with your domain:
```
yourdomain.com
```

## Browser Support

- Chrome/Edge (latest)
- Firefox (latest)
- Safari (latest)
- iOS Safari
- Chrome Android

## License

MIT License - see [LICENSE](../../LICENSE) for details.
