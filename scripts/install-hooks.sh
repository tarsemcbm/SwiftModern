#!/bin/sh

echo "📦 Installing git hooks..."

# Get the project root directory
PROJECT_ROOT="$(git rev-parse --show-toplevel)"

# Check if hooks exist
if [ ! -d "$PROJECT_ROOT/scripts/hooks" ]; then
    echo "❌ hooks directory not found"
    exit 1
fi

# Copy pre-commit hook
if [ -f "$PROJECT_ROOT/scripts/hooks/pre-commit" ]; then
    cp "$PROJECT_ROOT/scripts/hooks/pre-commit" "$PROJECT_ROOT/.git/hooks/pre-commit"
    chmod +x "$PROJECT_ROOT/.git/hooks/pre-commit"
    echo "✅ Installed pre-commit hook"
fi

# Copy pre-push hook
if [ -f "$PROJECT_ROOT/scripts/hooks/pre-push" ]; then
    cp "$PROJECT_ROOT/scripts/hooks/pre-push" "$PROJECT_ROOT/.git/hooks/pre-push"
    chmod +x "$PROJECT_ROOT/.git/hooks/pre-push"
    echo "✅ Installed pre-push hook"
fi

echo ""
echo "✅ Git hooks installed successfully!"
echo ""
echo "Active hooks:"
echo "  - pre-commit: Runs SwiftLint before each commit"
echo "  - pre-push: Prevents direct push to main/develop branches"
echo ""
echo "To bypass hooks temporarily:"
echo "  - Commit: git commit --no-verify"
echo "  - Push: git push --no-verify"
