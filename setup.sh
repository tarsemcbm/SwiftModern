#!/bin/sh

echo "🚀 Setting up SwiftModern project..."
echo ""

# Check if SwiftLint is installed
if ! command -v swiftlint >/dev/null 2>&1; then
    echo "⚠️  SwiftLint not found"
    echo "   Install with: brew install swiftlint"
    SWIFTLINT_INSTALLED=false
else
    echo "✅ SwiftLint found ($(swiftlint version))"
    SWIFTLINT_INSTALLED=true
fi

# Install hooks
echo ""
echo "📦 Installing git hooks..."
./scripts/install-hooks.sh

echo ""
echo "✅ Setup complete!"

if [ "$SWIFTLINT_INSTALLED" = false ]; then
    echo ""
    echo "⚠️  Don't forget to install SwiftLint!"
fi
