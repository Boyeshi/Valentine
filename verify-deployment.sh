#!/bin/bash

# Quick Deployment Verification Script
# Checks if the website is properly deployed and accessible

set -e

echo "🔍 Valentine Website Deployment Verification"
echo "============================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_check() {
    echo -e "${BLUE}➜${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Extract repository info
REPO_URL=$(git remote get-url origin 2>/dev/null || echo "")
if [ -z "$REPO_URL" ]; then
    print_error "Not a git repository or no remote configured"
    exit 1
fi

# Parse GitHub username and repo name
REPO_INFO=$(echo "$REPO_URL" | sed -E 's#.*(github\.com[:/])(.*)(.git)?$#\2#' | sed 's/\.git$//')
GITHUB_USER=$(echo "$REPO_INFO" | cut -d'/' -f1)
REPO_NAME=$(echo "$REPO_INFO" | cut -d'/' -f2)
SITE_URL="https://${GITHUB_USER}.github.io/${REPO_NAME}/"

echo "Repository: $REPO_INFO"
echo "Expected URL: $SITE_URL"
echo ""

# Check 1: Local files exist
print_check "Checking local files..."
if [ -f "index.html" ] && [ -f "style.css" ] && [ -f "script.js" ]; then
    print_success "All required files present"
else
    print_error "Missing required files (index.html, style.css, script.js)"
    exit 1
fi

# Check 2: Deployment workflow exists
print_check "Checking deployment workflow..."
if [ -f ".github/workflows/deploy.yml" ]; then
    print_success "Deployment workflow configured"
else
    print_error "Deployment workflow not found"
    exit 1
fi

# Check 3: Check if site is accessible
print_check "Checking if website is accessible..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$SITE_URL" 2>/dev/null || echo "000")

if [ "$HTTP_STATUS" = "200" ]; then
    print_success "Website is live and accessible!"
    echo ""
    echo "🎉 Your website is deployed at: $SITE_URL"
    
    # Check if content is correct
    print_check "Verifying content..."
    CONTENT=$(curl -s "$SITE_URL" 2>/dev/null || echo "")
    if echo "$CONTENT" | grep -q "Will you be my Valentine"; then
        print_success "Content verified - website is working correctly!"
    else
        print_warning "Website is accessible but content may not be up to date"
    fi
elif [ "$HTTP_STATUS" = "404" ]; then
    print_error "Website not found (404)"
    echo ""
    echo "Possible reasons:"
    echo "1. GitHub Pages is not enabled"
    echo "2. Deployment workflow hasn't run yet"
    echo "3. Website was deployed but removed"
    echo ""
    echo "To fix this:"
    echo "1. Go to: https://github.com/$REPO_INFO/settings/pages"
    echo "2. Set Source to 'GitHub Actions'"
    echo "3. Run: ./deploy.sh"
elif [ "$HTTP_STATUS" = "000" ]; then
    print_error "Could not connect to website"
    echo ""
    echo "This might mean:"
    echo "1. No internet connection"
    echo "2. GitHub Pages is not set up yet"
    echo "3. Website hasn't been deployed"
else
    print_warning "Unexpected HTTP status: $HTTP_STATUS"
fi

# Check 4: Recent workflow runs
print_check "Checking recent deployments..."
echo ""
echo "To view deployment status:"
echo "→ Actions: https://github.com/$REPO_INFO/actions"
echo "→ Settings: https://github.com/$REPO_INFO/settings/pages"
echo ""

# Summary
echo "======================================"
echo "Quick Links:"
echo "======================================"
echo "📱 Website: $SITE_URL"
echo "🔧 Actions: https://github.com/$REPO_INFO/actions"
echo "⚙️  Settings: https://github.com/$REPO_INFO/settings/pages"
echo "📖 Repo: https://github.com/$REPO_INFO"
echo ""
