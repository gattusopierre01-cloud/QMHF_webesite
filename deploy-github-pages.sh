#!/bin/bash

# GitHub Pages Deployment Script
# This script prepares the project for GitHub Pages deployment

set -e

echo "🚀 Preparing QMHF Website for GitHub Pages..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Not in a git repository. Please initialize git first."
    exit 1
fi

# Check if GitHub Pages workflow exists
if [ ! -f ".github/workflows/github-pages.yml" ]; then
    echo "❌ GitHub Pages workflow not found. Please ensure .github/workflows/github-pages.yml exists."
    exit 1
fi

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Build for GitHub Pages
echo "🔨 Building for GitHub Pages..."
npm run build:github-pages

# Check if dist directory exists
if [ ! -d "dist" ]; then
    echo "❌ Build failed - dist directory not found."
    exit 1
fi

# Create .nojekyll file to bypass Jekyll processing
echo "📄 Creating .nojekyll file..."
touch dist/.nojekyll

# Create CNAME file if custom domain is specified
if [ ! -z "$1" ]; then
    echo "🌐 Creating CNAME file for custom domain: $1"
    echo "$1" > dist/CNAME
fi

# Verify build
echo "✅ Verifying build..."
if [ -f "dist/index.html" ]; then
    echo "✅ index.html found"
else
    echo "❌ index.html not found in dist/"
    exit 1
fi

if [ -f "dist/css/style.min.css" ]; then
    echo "✅ CSS files found"
else
    echo "❌ CSS files not found"
    exit 1
fi

if [ -f "dist/js/main.min.js" ]; then
    echo "✅ JavaScript files found"
else
    echo "❌ JavaScript files not found"
    exit 1
fi

echo "🎉 GitHub Pages build completed successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Commit and push your changes to the main branch"
echo "2. GitHub Actions will automatically deploy to GitHub Pages"
echo "3. Your site will be available at: https://yourusername.github.io/qmhf-website"
echo ""
echo "🔧 To use a custom domain:"
echo "   ./deploy-github-pages.sh yourdomain.com"
echo ""
echo "📚 For more information, see:"
echo "   https://docs.github.com/en/pages/getting-started-with-github-pages"
