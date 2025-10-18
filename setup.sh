#!/bin/bash

# QMHF Website Quick Start Script
# This script sets up the development environment

echo "🚀 Setting up QMHF Website Development Environment..."

# Check prerequisites
echo "📋 Checking prerequisites..."

if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 16+ first."
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 is not installed. Please install Python3 first."
    exit 1
fi

echo "✅ Prerequisites check passed"

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p dist backups logs

# Set up Git hooks
echo "🔧 Setting up Git hooks..."
chmod +x .git/hooks/pre-commit

# Make deployment script executable
echo "🔧 Making deployment script executable..."
chmod +x deploy.sh

# Create initial backup
echo "💾 Creating initial backup..."
npm run backup

echo "✅ Setup complete!"
echo ""
echo "🎯 Quick Commands:"
echo "  Development:  npm run dev"
echo "  Production:   npm run build:prod"
echo "  Deploy:       ./deploy.sh development"
echo "  Test:         npm test"
echo ""
echo "📚 For more information, see README.md"
echo "🌐 Start development server: npm run dev"
