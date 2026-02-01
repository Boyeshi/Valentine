# 🚀 How to Deploy the Valentine Website

## Overview

This document explains how to deploy the Valentine website to GitHub Pages. The deployment is **already configured** and happens **automatically**!

## 🎯 Three Ways to Deploy

### Method 1: Automatic Deployment (Easiest)
Simply push your changes to the `main` branch:

```bash
git add .
git commit -m "Update website"
git push origin main
```

✅ **That's it!** GitHub Actions will automatically deploy your changes within 30 seconds.

### Method 2: Using the Deployment Script

We've created a helper script to make deployment even easier:

```bash
./deploy.sh
```

This script will:
1. Check your git status
2. Let you test the website locally
3. Push changes to GitHub
4. Provide links to monitor deployment

### Method 3: Manual Workflow Trigger

Deploy without pushing new code:

1. Visit [GitHub Actions](https://github.com/Boyeshi/Valentine/actions)
2. Click "Deploy to GitHub Pages" workflow
3. Click "Run workflow" button
4. Select the `main` branch
5. Click "Run workflow" to deploy

## 🔍 Check Deployment Status

### Using the Verification Script

```bash
./verify-deployment.sh
```

This will check:
- ✓ Local files are present
- ✓ Deployment workflow is configured
- ✓ Website is accessible online
- ✓ Content is correct

### Manual Verification

1. **Check Actions Tab**: https://github.com/Boyeshi/Valentine/actions
   - Green checkmark ✓ = Success
   - Red X ✗ = Failed (click to see logs)

2. **Visit the Live Site**: https://boyeshi.github.io/Valentine/

3. **Check GitHub Pages Settings**: https://github.com/Boyeshi/Valentine/settings/pages
   - Should show: "Your site is live at https://boyeshi.github.io/Valentine/"

## ⚙️ Initial Setup (One-Time Only)

If this is your first time deploying, ensure GitHub Pages is enabled:

### Step 1: Enable GitHub Pages
1. Go to [Repository Settings](https://github.com/Boyeshi/Valentine/settings)
2. Click "Pages" in the left sidebar
3. Under "Build and deployment" section:
   - **Source**: Select "GitHub Actions"
4. Click "Save"

### Step 2: Verify Workflow Permissions
1. Go to [Actions Settings](https://github.com/Boyeshi/Valentine/settings/actions)
2. Under "Workflow permissions":
   - Ensure "Read and write permissions" is selected
   - Or ensure "pages: write" is allowed

### Step 3: First Deployment
```bash
# Push to main branch to trigger first deployment
git push origin main

# Or manually trigger from Actions tab
```

## 📊 Deployment Workflow

The deployment happens in these steps:

```
1. Push to main branch
   ↓
2. GitHub Actions workflow triggers
   ↓
3. Checkout code
   ↓
4. Setup GitHub Pages
   ↓
5. Upload website files
   ↓
6. Deploy to GitHub Pages
   ↓
7. Website is live! 🎉
```

**Time to deploy**: ~30-60 seconds

## 🧪 Test Locally Before Deploying

Always test your changes locally first:

```bash
# Start a local web server
python3 -m http.server 8000

# Open in your browser
# http://localhost:8000
```

Or simply open `index.html` directly in your browser.

## 📁 What Gets Deployed

All files in the repository root:
- ✅ `index.html` - Main page
- ✅ `style.css` - Styles
- ✅ `script.js` - JavaScript
- ✅ `README.md` - Documentation
- ❌ `.git/` - Not deployed (automatically excluded)
- ❌ `.github/` - Not deployed (automatically excluded)

## 🐛 Troubleshooting

### Problem: "Resource not accessible by integration" Error

**Solution:**
1. Go to [Settings → Pages](https://github.com/Boyeshi/Valentine/settings/pages)
2. Ensure Source is set to "GitHub Actions" (not "Deploy from a branch")
3. Check workflow permissions in [Actions Settings](https://github.com/Boyeshi/Valentine/settings/actions)

### Problem: Website Shows 404 Error

**Solutions:**
1. **Check GitHub Pages is enabled**
   - Go to Settings → Pages
   - Source should be "GitHub Actions"

2. **Check workflow ran successfully**
   - Go to [Actions tab](https://github.com/Boyeshi/Valentine/actions)
   - Latest run should have green checkmark ✓

3. **Wait a few minutes**
   - First deployment can take 5-10 minutes
   - DNS propagation may be needed

4. **Check branch name**
   - Workflow only deploys from `main` branch
   - Ensure you pushed to the correct branch

### Problem: Changes Not Showing on Live Site

**Solutions:**
1. **Clear browser cache**
   - Hard refresh: `Ctrl + Shift + R` (Windows/Linux)
   - Hard refresh: `Cmd + Shift + R` (Mac)
   - Or open in incognito/private window

2. **Verify workflow ran**
   - Check [Actions tab](https://github.com/Boyeshi/Valentine/actions)
   - Latest workflow should be green ✓

3. **Check correct branch**
   - Only `main` branch auto-deploys
   - Use: `git branch --show-current` to check

4. **Wait a bit**
   - CDN caching can take 2-3 minutes to update

### Problem: Workflow Fails

**Solutions:**
1. **Check workflow logs**
   - Go to [Actions tab](https://github.com/Boyeshi/Valentine/actions)
   - Click on the failed workflow
   - Read error messages in logs

2. **Common issues:**
   - Missing permissions → Check Actions settings
   - GitHub Pages not enabled → Enable in Settings
   - Invalid workflow file → Check `.github/workflows/deploy.yml`

## 🎓 Understanding the Workflow

The deployment workflow is in `.github/workflows/deploy.yml`:

```yaml
name: Deploy to GitHub Pages

# Triggers
on:
  push:
    branches: [main]  # Auto-deploy on push to main
  workflow_dispatch:   # Manual trigger from UI

# Permissions needed
permissions:
  contents: read      # Read repository
  pages: write        # Write to GitHub Pages
  id-token: write     # Verify identity

# Deployment job
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - Checkout code
      - Setup Pages
      - Upload files
      - Deploy to Pages
```

## 📚 Additional Resources

- **Quick Guide**: See [DEPLOY-QUICK.md](DEPLOY-QUICK.md)
- **Detailed Setup**: See [DEPLOYMENT.md](DEPLOYMENT.md)
- **GitHub Pages Docs**: https://docs.github.com/en/pages
- **Actions Documentation**: https://docs.github.com/en/actions

## 🔗 Important Links

| Resource | URL |
|----------|-----|
| 🌐 Live Website | https://boyeshi.github.io/Valentine/ |
| 🔧 Actions (Deploy Status) | https://github.com/Boyeshi/Valentine/actions |
| ⚙️ Pages Settings | https://github.com/Boyeshi/Valentine/settings/pages |
| 📖 Repository | https://github.com/Boyeshi/Valentine |
| 🚀 Workflows | https://github.com/Boyeshi/Valentine/actions/workflows/deploy.yml |

## ✅ Deployment Checklist

Before deploying:
- [ ] Test locally: `python3 -m http.server 8000`
- [ ] Verify all changes work correctly
- [ ] Commit with meaningful message: `git commit -m "Description"`
- [ ] Push to main: `git push origin main`

After deploying:
- [ ] Check Actions tab for green checkmark ✓
- [ ] Visit live site: https://boyeshi.github.io/Valentine/
- [ ] Test website functionality
- [ ] Clear cache if changes don't show

## 🎉 Success Indicators

You'll know deployment succeeded when:
1. ✅ GitHub Actions shows green checkmark
2. ✅ Actions tab shows "Deploy to GitHub Pages" completed
3. ✅ Settings → Pages shows "Your site is live"
4. ✅ Website loads at https://boyeshi.github.io/Valentine/
5. ✅ Changes are visible on the live site

## 💡 Tips & Best Practices

1. **Always test locally** before deploying
2. **Use meaningful commit messages** to track changes
3. **Monitor the Actions tab** during deployment
4. **Keep deployments small** and incremental
5. **Branch protection**: Consider protecting the `main` branch
6. **Review before merge**: Use pull requests for code review

## 🚨 Important Notes

- ⚠️ Deployment only happens on push to `main` branch
- ⚠️ First deployment may take 5-10 minutes
- ⚠️ Subsequent deployments take 30-60 seconds
- ⚠️ Browser cache may show old version (hard refresh!)
- ⚠️ Changes to workflow file require re-triggering

## 🆘 Need Help?

If you're still having issues:

1. **Check the logs**:
   - Go to Actions tab → Click failed workflow → Read logs

2. **Verify setup**:
   ```bash
   ./verify-deployment.sh
   ```

3. **Review documentation**:
   - [DEPLOYMENT.md](DEPLOYMENT.md) - Detailed setup
   - [DEPLOY-QUICK.md](DEPLOY-QUICK.md) - Quick start

4. **GitHub Support**:
   - [GitHub Pages Documentation](https://docs.github.com/en/pages)
   - [GitHub Community Forum](https://github.community)

---

**Happy Deploying! 🎀💕**

*This website auto-deploys with every push to main. It's that simple!*
