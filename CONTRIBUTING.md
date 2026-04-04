# Contributing to Kage Bunshin

Thank you for your interest in contributing! This guide will help you get started.

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed
- Git

## Setting Up the Development Environment

1. Fork and clone the repository

```bash
git clone https://github.com/<your-username>/kage-bunshin.git
cd kage-bunshin
```

2. (Optional) Set up a Notebook repository for testing

```bash
mkdir ../kage-bunshin-notebook
cd ../kage-bunshin-notebook
git init
```

3. Configure `.claude/settings.local.json`

```json
{
  "env": {
    "NOTEBOOK_PATH": "/path/to/your/notebook-repo",
    "OUTPUT_LANGUAGE": "en"
  },
  "permissions": {
    "additionalDirectories": ["/path/to/your/notebook-repo"]
  }
}
```

4. Launch Claude Code and test a skill

```
/brainstorm "test topic"
```

## Project Structure

```
.claude/
├── agents/          # Agent definitions (Markdown)
│   ├── ideator.md
│   ├── analyst.md
│   ├── planner.md
│   └── researcher.md
├── skills/          # Skill workflows (Markdown)
│   ├── brainstorm/
│   ├── evaluate/
│   ├── plan-project/
│   ├── learning/
│   └── notebook/
├── settings.json
└── settings.local.json
```

## Creating a Custom Agent

Create a new Markdown file in `.claude/agents/`:

```markdown
---
name: my-agent
model: opus
description: >
  What this agent does and when to use it.
tools:
  - Read
  - Write
  - Grep
  - Glob
---

# My Agent - Kage Bunshin

You are the **My Agent** agent of Kage Bunshin.

## Personality & Thinking Style
[Define how this agent thinks]

## Output Format
[Define the output template]

## Notebook Integration
[Define save paths and frontmatter]

## Constraints
[Define behavioral boundaries]
```

## Creating a Custom Skill

Create a new directory in `.claude/skills/` with a `SKILL.md`:

```markdown
---
name: my-skill
description: >
  What this skill does and when to trigger it.
user-invocable: true
---

# My Skill

## Workflow

### Step 1: Understand the Input
[Parse user request]

### Step 1.5: Retrieve Past Notebook Context
[Search relevant Notebook entries]

### Step 2: Agent Phase
[Invoke agent(s) with instructions]

### Step 3: Final Output
[Format and present results]
```

Key guidelines for skills:
- Skills orchestrate one or more agents
- Include a Step 1.5 for Notebook context retrieval
- Specify Notebook save paths in agent instructions

## Pull Request Process

1. Create a feature branch from `develop`

```bash
git checkout develop
git checkout -b feature/your-feature
```

2. Make your changes and commit

- Write clear commit messages
- Reference issue numbers where applicable (e.g., `#11`)

3. Push and create a pull request targeting `develop`

```bash
git push -u origin feature/your-feature
```

4. Wait for review — we aim to respond within a few days

## Code of Conduct

Be respectful and constructive. We welcome contributions from everyone regardless of experience level.
