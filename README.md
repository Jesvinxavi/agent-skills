# Agent Skills (Elite Configuration)

This repository serves as the **"Brain"** for AI Agents in your projects. It contains specialized Skills, Workflows, and Configurations designed to supercharge your development process.

It is designed to be used with the **Backlog.md CLI** tool.

## 🚀 Usage

To install these skills into a new or existing project, run the installation script:

```bash
# Installs Backlog.md CLI + This Configuration
curl -sL https://raw.githubusercontent.com/Jesvinxavi/agent-skills/main/scripts/scaffold-agents.sh | bash
```

## 🛠️ Dependencies

This configuration relies on the **Backlog.md** command-line tool to function.

*   **Tool**: `backlog` (CLI)
*   **Package**: `backlog.md` (NPM)
*   **Source**: [GitHub - MrLesk/Backlog.md](https://github.com/MrLesk/Backlog.md)

The installation script automatically handles the installation of the CLI tool (`npm install -g backlog.md`) if it is not already present.

## 📂 Structure

*   **`.agent/skills`**: Specialized capabilities for the agent (e.g., `project-decomposer`, `frontend-mastery`).
*   **`.agent/workflows`**: Standardized procedures for common tasks (e.g., `/create-feature`, `/finish-task`).
*   **`backlog/templates`**: Pre-defined templates for Tasks, Specs, and Docs.
*   **`backlog/config.yml`**: Optimized configuration for agent-driven development.
