# SwiftModern

Learning modern Swift development by building real projects. Focusing on Swift concurrency (async/await, actors, tasks) and SwiftUI because that's where iOS development is headed.
This is my playground for understanding how concurrency actually works in Swift and getting comfortable with SwiftUI's declarative approach. Lots of experiments, some mistakes, and hopefully some useful examples along the way.
What I'm working on:

Getting async/await to click in my brain
Building UIs with SwiftUI instead of fighting with storyboards
Understanding actors and why they matter
Making apps that don't freeze or crash from threading issues

Just a collection of projects and code as I figure out modern Swift. If you're learning this stuff too, maybe you'll find something useful here.


## Setup

After cloning the repository, run the setup script:
```bash
./setup.sh
```

This will:
- Check if SwiftLint is installed
- Install git hooks for automated linting and branch protection

### Manual Setup

If you prefer manual setup:

1. **Install SwiftLint:**
```bash
   brew install swiftlint
```

2. **Install git hooks:**
```bash
   ./scripts/install-hooks.sh
```

## Development

### Git Hooks

This project uses git hooks to ensure code quality and workflow:

- **pre-commit**: Runs SwiftLint before each commit
  - Auto-checks code style and quality
  - To bypass: `git commit --no-verify`

- **pre-push**: Prevents direct pushes to protected branches
  - Blocks pushes to `main` and `develop`
  - Forces use of Pull Requests
  - To bypass: `git push --no-verify` (not recommended)

### SwiftLint

Run SwiftLint manually:
```bash
# Lint all files
swiftlint

# Auto-fix violations
swiftlint --fix

# Lint specific file
swiftlint lint --path SwiftModern/ContentView.swift
```

## Branch Protection

### GitHub Settings
- `main` and `develop` branches are protected on GitHub
- All changes must go through Pull Requests
- CI checks must pass before merging

### Local Protection
- Pre-push hook prevents accidental direct pushes
- Enforces PR workflow even locally

## Workflow
```
feature/something → PR to develop → PR to main
```

### Creating a Feature Branch
```bash
# Start from develop
git checkout develop
git pull

# Create feature branch
git checkout -b feature/my-feature

# Work on your changes
# ... make changes ...

# Commit (pre-commit hook runs SwiftLint)
git add .
git commit -m "Add my feature"

# Push feature branch (pre-push hook allows this)
git push origin feature/my-feature

# Create PR on GitHub: feature/my-feature → develop
```

### Attempting to Push to Protected Branches
```bash
# This will be blocked by pre-push hook
git checkout main
git push  # ❌ Blocked!

# Error: Direct push to main is not allowed!
```

## Project Structure
```
SwiftModern/
├── SwiftModern/          # Main app code
├── SwiftModernTests/     # Unit tests
├── SwiftModernUITests/   # UI tests
├── scripts/
│   └── hooks/           # Shared git hooks
│       ├── pre-commit   # SwiftLint check
│       └── pre-push     # Branch protection
├── .github/
│   └── workflows/       # CI/CD workflows
└── .swiftlint.yml       # SwiftLint configuration
```

## Topics Covered

- Swift Concurrency: async/await, actors, task groups
- SwiftUI: declarative UI, state management, animations
- Modern Swift patterns and best practices
- Testing and CI/CD

## Troubleshooting

### Bypassing Hooks (Emergency Only)

If you absolutely need to bypass hooks:
```bash
# Bypass pre-commit
git commit --no-verify

# Bypass pre-push
git push --no-verify
```

**Note:** Only use `--no-verify` when absolutely necessary. Hooks exist to maintain code quality and workflow.

### Reinstalling Hooks

If hooks stop working:
```bash
./scripts/install-hooks.sh
```
