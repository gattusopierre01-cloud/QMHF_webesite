#!/bin/bash

# QMHF Website Deployment Script
# Usage: ./deploy.sh [development|staging|production]

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="qmhf-website"
BACKUP_DIR="backups"
LOG_FILE="deployment.log"

# Functions
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1" | tee -a $LOG_FILE
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a $LOG_FILE
    exit 1
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1" | tee -a $LOG_FILE
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1" | tee -a $LOG_FILE
}

# Check if environment is provided
if [ $# -eq 0 ]; then
    error "Please specify environment: development, staging, or production"
fi

ENVIRONMENT=$1

# Validate environment
case $ENVIRONMENT in
    development|staging|production)
        log "Deploying to $ENVIRONMENT environment"
        ;;
    *)
        error "Invalid environment. Use: development, staging, or production"
        ;;
esac

# Pre-deployment checks
log "Running pre-deployment checks..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    error "Node.js is not installed"
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    error "npm is not installed"
fi

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    error "Python3 is not installed"
fi

# Check if required files exist
if [ ! -f "package.json" ]; then
    error "package.json not found"
fi

if [ ! -f "src/index.html" ]; then
    error "Source files not found in src/ directory"
fi

success "Pre-deployment checks passed"

# Create backup
log "Creating backup..."
BACKUP_NAME="${PROJECT_NAME}-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
mkdir -p $BACKUP_DIR
tar -czf "$BACKUP_DIR/$BACKUP_NAME" src/ 2>/dev/null || warning "Backup creation failed"
log "Backup created: $BACKUP_DIR/$BACKUP_NAME"

# Install dependencies
log "Installing dependencies..."
npm install --silent || error "Failed to install dependencies"

# Run tests (non-blocking for deployment)
log "Running tests..."
npm test || warning "Some tests failed, but continuing with deployment"

# Build based on environment
case $ENVIRONMENT in
    development)
        log "Building for development..."
        npm run build:dev || error "Development build failed"
        PORT=8080
        ;;
    staging)
        log "Building for staging..."
        npm run build:dev || error "Staging build failed"
        PORT=8080
        ;;
    production)
        log "Building for production..."
        npm run build:prod || error "Production build failed"
        PORT=8081
        ;;
esac

# Deploy
log "Deploying to $ENVIRONMENT..."
case $ENVIRONMENT in
    development|staging)
        log "Starting development server on port $PORT..."
        npm run serve:dev &
        SERVER_PID=$!
        ;;
    production)
        log "Starting production server on port $PORT..."
        npm run serve:prod &
        SERVER_PID=$!
        ;;
esac

# Wait for server to start
sleep 3

# Health check
log "Performing health check..."
if curl -f -s "http://localhost:$PORT" > /dev/null; then
    success "Health check passed"
else
    error "Health check failed"
fi

# Cleanup old backups (keep last 5)
log "Cleaning up old backups..."
cd $BACKUP_DIR
ls -t *.tar.gz | tail -n +6 | xargs -r rm
cd ..

success "Deployment to $ENVIRONMENT completed successfully!"
log "Website is running at: http://localhost:$PORT"
log "Server PID: $SERVER_PID"
log "To stop the server: kill $SERVER_PID"

# Save deployment info
echo "$(date): Deployed to $ENVIRONMENT (PID: $SERVER_PID)" >> deployment-history.log
