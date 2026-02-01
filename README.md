# Valentine 💖

A cute interactive Valentine's Day proposal website where the "No" button runs away! 

## 🌐 Live Demo

Visit the live website at: **https://boyeshi.github.io/Valentine/**

## ✨ Features

- **Interactive "Yes" Button**: Click it to see a sweet success message! 💕
- **Elusive "No" Button**: Try to click it... if you can! It moves around every time you get close! 🏃‍♂️
- **Beautiful Design**: Purple gradient background with smooth animations
- **Fully Responsive**: Works great on desktop and mobile devices 📱

## 🚀 How to Use

1. Open the website
2. Try clicking the "No" button (spoiler: it will run away!)
3. Click the "Yes" button to see the happy message! 🎉

## 💻 Local Development

Simply open `index.html` in your web browser to run locally.

Or use a local server:
```bash
python3 -m http.server 8000
# Then visit http://localhost:8000
```

## 🚀 Deployment

This website automatically deploys to GitHub Pages when changes are pushed to the `main` branch.

### Quick Deployment

```bash
# Option 1: Use deployment script (recommended)
./deploy.sh

# Option 2: Manual deployment
git add .
git commit -m "Your changes"
git push origin main

# Option 3: Verify deployment status
./verify-deployment.sh
```

See [DEPLOY-QUICK.md](DEPLOY-QUICK.md) for quick start guide or [DEPLOYMENT.md](DEPLOYMENT.md) for detailed instructions.

**First-time setup required:** GitHub Pages must be enabled in repository settings with "GitHub Actions" as the source.

## 📄 Files

- `index.html` - Main HTML structure
- `style.css` - Styling and animations  
- `script.js` - Interactive button behavior
- `.github/workflows/deploy.yml` - GitHub Pages deployment workflow