#!/bin/bash
# =================================================================================
# AGENT SKILLS SYNC-BACK SCRIPT
# =================================================================================
# Use this script to push your local project's agent improvements back to your
# central 'agent-skills' repository.
#
# Usage: ./scripts/sync-upstream.sh [path/to/agent-skills-repo]
# =================================================================================

set -e

# Default to sibling directory if not provided
TARGET_REPO="$1"

# 1. Resolve Target Repo
if [ -z "$TARGET_REPO" ]; then
    echo "🤔 Where is your central 'agent-skills' repository located?"
    echo "   (Press Enter to check default: ../agent-skills)"
    read -r USER_INPUT
    TARGET_REPO="${USER_INPUT:-../agent-skills}"
fi

# Resolve absolute path
if [[ "$TARGET_REPO" != /* ]]; then
    TARGET_REPO="$(pwd)/$TARGET_REPO"
fi

# 2. Validation
if [ ! -d "$TARGET_REPO/.git" ]; then
    echo "❌ Error: '$TARGET_REPO' is not a valid Git repository."
    echo "   Please clone your central repo first: git clone https://github.com/jesvinxavi/backlog-agent-orchestration.git"
    exit 1
fi

if [ ! -d "$TARGET_REPO/.agent/skills" ]; then
    echo "❌ Error: Target repo does not look like the agent-skills package (missing .agent/skills)."
    exit 1
fi

echo "🚀 Syncing changes FROM $(pwd) TO $TARGET_REPO..."

# 3. The Sync (Rsync with update flag to only copy newer files, but simple cp is safer for "overwriting upstream")
# We want to overwrite upstream with OUR valid changes.

# Sync Skills
echo "📦 Syncing Skills..."
cp -R .agent/skills/* "$TARGET_REPO/.agent/skills/"

# Sync Workflows
echo "⚡ Syncing Workflows..."
cp -R .agent/workflows/* "$TARGET_REPO/.agent/workflows/"

# Sync Config
echo "⚙️  Syncing Config..."
cp backlog/config.yml "$TARGET_REPO/backlog/config.yml"
cp backlog/AGENTS.md "$TARGET_REPO/backlog/AGENTS.md"

# Sync Templates
if [ -d "backlog/templates" ]; then
    echo "📝 Syncing Templates..."
    # Ensure dir exists
    mkdir -p "$TARGET_REPO/backlog/templates"
    cp -R backlog/templates/* "$TARGET_REPO/backlog/templates/"
fi

# Sync Docs
echo "📚 Syncing Docs..."
cp backlog/docs/SKILLS-SYSTEM.md "$TARGET_REPO/backlog/docs/"
if [ -f "backlog/KNOWLEDGE.md" ]; then
    # We DON'T sync KNOWLEDGE.md fully, as it's project specific, 
    # BUT we might want to sync KNOWLEDGE-STARTER if we edited it.
    # For now, let's leave KNOWLEDGE.md out to avoid polluting the template with project-specific logs.
    echo "   (Skipping KNOWLEDGE.md as it is project-specific)"
fi

# 4. Success Message
echo ""
echo "✅ Sync Complete!"
echo "👉 Now go to the target repo and commit the changes:"
echo ""
echo "   cd $TARGET_REPO"
echo "   git status"
echo "   git add ."
echo "   git commit -m 'feat: sync improvements from project XYZ'"
echo "   git push"
echo ""
