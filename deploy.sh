#!/bin/bash

# Deployment Script for Valentine Website
# This script helps deploy the website to GitHub Pages

set -e

echo "🎀 Valentine Website Deployment Script 🎀"
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
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

# Check if we're in a git repository
if [ ! -d .git ]; then
    print_error "Error: Not a git repository. Please run this script from the repository root."
    exit 1
fi

print_step "Checking repository status..."
if [ -n "$(git status --porcelain)" ]; then
    print_warning "You have uncommitted changes:"
    git status --short
    echo ""
    read -p "Do you want to continue without committing? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Deployment cancelled. Please commit your changes first."
        exit 1
    fi
fi

print_step "Checking current branch..."
CURRENT_BRANCH=$(git branch --show-current)
echo "Current branch: $CURRENT_BRANCH"

if [ "$CURRENT_BRANCH" != "main" ]; then
    print_warning "You're not on the 'main' branch."
    echo "Automatic deployment only works when pushing to 'main'."
    echo ""
    read -p "Do you want to switch to main branch? (y/N) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_step "Switching to main branch..."
        git checkout main
        git pull origin main
        print_success "Switched to main branch"
    else
        print_warning "Staying on $CURRENT_BRANCH branch"
    fi
fi

print_step "Running local test server..."
echo "Starting server on http://localhost:8000"
echo "Press Ctrl+C to stop the server and continue deployment"
echo ""

# Start the server and wait for user to stop it
python3 -m http.server 8000 || {
    print_error "Failed to start local server"
    print_warning "Continuing with deployment anyway..."
}

echo ""
print_step "Preparing deployment..."

# Check if there are any changes to push
if [ -n "$(git log origin/$(git branch --show-current)..HEAD 2>/dev/null)" ]; then
    print_step "Pushing changes to GitHub..."
    git push origin $(git branch --show-current)
    print_success "Changes pushed successfully!"
    echo ""
    echo "The GitHub Actions workflow will automatically deploy your changes."
else
    print_warning "No new commits to push."
    echo ""
    read -p "Do you want to trigger a manual deployment? (y/N) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_step "To manually trigger deployment:"
        echo "1. Go to: https://github.com/$(git remote get-url origin | sed -E 's#.*(github\.com[:/])(.*)(.git)?$#\2#' | sed 's/\.git$//')/actions"
        echo "2. Click on 'Deploy to GitHub Pages' workflow"
        echo "3. Click 'Run workflow' button"
        echo "4. Select branch and click 'Run workflow'"
        echo ""
        print_warning "Note: You can also use GitHub CLI with: gh workflow run deploy.yml"
    fi
fi

echo ""
print_success "Deployment process initiated!"
echo ""
echo "📋 Next Steps:"
echo "1. Monitor deployment: https://github.com/$(git remote get-url origin | sed -E 's#.*(github\.com[:/])(.*)(.git)?$#\2#' | sed 's/\.git$//')/actions"
REPO_PATH=$(git remote get-url origin | sed -E 's#.*(github\.com[:/])(.*)(.git)?$#\2#' | sed 's/\.git$//')
GITHUB_USER=$(echo "$REPO_PATH" | cut -d'/' -f1)
REPO_NAME=$(echo "$REPO_PATH" | cut -d'/' -f2)
echo "2. Once deployed, visit: https://${GITHUB_USER}.github.io/${REPO_NAME}/"
echo ""
print_success "Done! 💕"
