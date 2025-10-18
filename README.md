# QMHF Website Development & Deployment Guide

## Overview

This document outlines the development and deployment framework for the Queen Mary Hedge Fund website, implementing best software engineering practices for both development and production environments.

## Project Structure

```
qmhf-website/
├── src/                    # Source files
│   ├── css/               # Stylesheets
│   ├── js/                # JavaScript files
│   ├── images/            # Image assets
│   ├── videos/            # Video assets
│   ├── about/             # About pages
│   ├── team/              # Team pages
│   ├── research/          # Research pages
│   └── *.html             # Main HTML files
├── dist/                  # Built files (generated)
├── config/                # Environment configurations
├── backups/               # Automated backups
├── package.json           # Node.js dependencies & scripts
├── build.config.json      # Build configuration
├── deploy.sh              # Deployment script
├── .gitworkflow           # Git workflow documentation
└── README.md              # This file
```

## Development Workflow

### Prerequisites

- Node.js (>=16.0.0)
- npm (>=8.0.0)
- Python 3
- Git

### Getting Started

1. Clone the repository
2. Install dependencies: `npm install`
3. Start development server: `npm run dev`

### Available Scripts

#### Development

- `npm run dev` - Start development server with live reload
- `npm run build:dev` - Build for development (unminified)
- `npm run serve:dev` - Serve development build on port 8080
- `npm run watch` - Watch for changes and rebuild automatically

#### Production

- `npm run build:prod` - Build for production (minified & optimized)
- `npm run serve:prod` - Serve production build on port 8081
- `npm run deploy:production` - Build and deploy to production

#### Testing & Quality

- `npm test` - Run all tests (linting + HTML validation)
- `npm run lint` - Run ESLint on JavaScript files
- `npm run validate:html` - Validate HTML files

#### Maintenance

- `npm run backup` - Create backup of source files
- `npm run clean` - Clean build directory

## Deployment

### Automated Deployment

Use the deployment script for automated deployments:

```bash
# Development deployment
./deploy.sh development

# Staging deployment
./deploy.sh staging

# Production deployment
./deploy.sh production
```

### Manual Deployment

```bash
# Development
npm run deploy:staging

# Production
npm run deploy:production
```

## Environment Configuration

### Development Environment

- **Port**: 8080
- **Debug**: Enabled
- **Minification**: Disabled
- **Source Maps**: Enabled
- **Analytics**: Disabled

### Production Environment

- **Port**: 8081
- **Debug**: Disabled
- **Minification**: Enabled
- **Source Maps**: Disabled
- **Analytics**: Enabled
- **Compression**: Enabled
- **Security Headers**: Enabled

## Git Workflow

### Branch Strategy

- `main` - Production-ready code
- `develop` - Integration branch
- `staging` - Pre-production testing
- `feature/*` - Feature development
- `bugfix/*` - Bug fixes
- `hotfix/*` - Critical fixes

### Commit Convention

```
type(scope): description

feat(research): add portfolio builder functionality
fix(nav): resolve dropdown positioning issue
docs(readme): update deployment instructions
```

### Pre-commit Hooks

Automated checks run before each commit:

- Code quality checks
- File size warnings
- Console.log detection
- Linting validation

## Build Process

### Development Build

- Copies source files to dist/
- Preserves original formatting
- Enables debugging features
- Fast build times

### Production Build

- Minifies HTML, CSS, and JavaScript
- Removes comments and debug code
- Optimizes images and assets
- Enables compression and caching
- Generates source maps for debugging

## Monitoring & Maintenance

### Health Checks

- Automated health checks after deployment
- Server status monitoring
- Error reporting (production only)

### Backups

- Automated backups before each deployment
- Retention policy: Keep last 5 backups
- Manual backup creation available

### Logging

- Development: Debug level logging
- Production: Error level logging
- Deployment history tracking

## Security Considerations

### Production Security

- Security headers enabled
- Content compression
- Error reporting without sensitive data
- API key protection

### Development Security

- Debug mode enabled
- Detailed error messages
- Console logging available

## Troubleshooting

### Common Issues

1. **Port already in use**: Kill existing processes or use different ports
2. **Build failures**: Check Node.js version and dependencies
3. **Deployment failures**: Verify environment configuration

### Getting Help

- Check deployment logs: `tail -f deployment.log`
- Review build configuration: `build.config.json`
- Validate environment settings: `config/*.env`

## Best Practices

### Code Quality

- Use conventional commit messages
- Write descriptive commit messages
- Keep commits atomic and focused
- Regular code reviews

### Deployment

- Always test in staging before production
- Use automated deployment scripts
- Monitor deployments closely
- Keep backups before major changes

### Maintenance

- Regular dependency updates
- Security patch management
- Performance monitoring
- Regular backup verification

## Support

For technical support or questions about the deployment process, contact the development team or refer to the project documentation.
