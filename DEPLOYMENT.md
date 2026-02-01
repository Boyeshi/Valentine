# Deployment Guide for Valentine Website

## GitHub Pages Setup

To enable GitHub Pages for this repository and make the website accessible at `https://boyeshi.github.io/Valentine/`, follow these steps:

### Step 1: Enable GitHub Pages
1. Go to your repository on GitHub: `https://github.com/Boyeshi/Valentine`
2. Click on **Settings** (gear icon)
3. In the left sidebar, click on **Pages** (under "Code and automation")
4. Under **Source**, select **GitHub Actions**
5. Save the changes

### Step 2: Trigger the Deployment
After enabling GitHub Pages with GitHub Actions as the source:
- The deployment workflow will automatically run when you push to the `main` branch
- You can also manually trigger it by:
  1. Going to **Actions** tab
  2. Selecting the "Deploy to GitHub Pages" workflow
  3. Clicking **Run workflow** → **Run workflow**

### Step 3: Verify Deployment
- Go to the **Actions** tab to see the deployment progress
- Once the workflow completes successfully (green checkmark), your site will be live at:
  - `https://boyeshi.github.io/Valentine/`

### Troubleshooting

#### "Resource not accessible by integration" Error
This error occurs when GitHub Pages is not enabled or the workflow doesn't have proper permissions. Make sure:
- GitHub Pages is enabled in repository settings
- **Source** is set to **GitHub Actions** (not "Deploy from a branch")
- The workflow has the required permissions (already configured in the workflow file)

#### Site Not Loading
If the site doesn't load after deployment:
1. Check the Actions tab for any workflow failures
2. Verify GitHub Pages is enabled in Settings → Pages
3. Wait a few minutes for DNS propagation
4. Clear your browser cache and try again

#### Changes Not Reflecting
- Changes only deploy when pushed to the `main` branch
- Check if the workflow ran successfully in the Actions tab
- You can manually trigger the workflow from the Actions tab

## Local Development

To test the website locally:
```bash
# Using Python's built-in HTTP server
python3 -m http.server 8000

# Then open http://localhost:8000 in your browser
```

Or simply open `index.html` directly in your web browser.
