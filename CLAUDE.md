# Kage Bunshin - Second Brain Agent System

An OSS agent system for Claude Code where multiple specialized agents collaborate on intellectual work beyond coding.

## Architecture

### Agents (`.claude/agents/`)
4 specialized agents. Each has a unique thinking style and writes its own deliverables.
- **ideator** - Divergent thinking, brainstorming, creative idea generation
- **analyst** - Critical analysis, risk assessment, quality reviews, feasibility evaluation
- **planner** - Task breakdown, scheduling, dependency management
- **researcher** - Deep investigation, information gathering, multi-source verification

### Skills (`.claude/skills/`)
Workflows that orchestrate multiple agents.
- `/brainstorm` - Multi-perspective ideation via ideator + analyst
- `/evaluate` - Structured evaluation via researcher + analyst
- `/plan-project` - Goal decomposition via researcher + planner
- `/learning` - Retrospective and lesson extraction via analyst
- `/notebook` - Notebook search and management

### Notebook
A **separate repository** for storing user-specific data. All deliverables are structured as Markdown with frontmatter.

#### Notebook Setup
```json
// .claude/settings.local.json
{
  "env": {
    "NOTEBOOK_PATH": "/path/to/your/notebook-repo"
  },
  "permissions": {
    "additionalDirectories": ["/path/to/your/notebook-repo"]
  }
}
```

- `NOTEBOOK_PATH`: Absolute path to the Notebook repository
- `additionalDirectories`: Required because the Notebook is an external repository outside Claude Code's default file access scope

#### Notebook Directory Structure
```
notebook-repo/
├── ideas/        # ideator
├── reviews/      # analyst
├── research/     # researcher
├── plans/        # planner
└── learnings/    # analyst via /learning
```

#### Notebook Entry Format
```markdown
---
title: Entry name
type: idea | review | research | plan | learning
date: YYYY-MM-DD
project: Project name
tags: [tag1, tag2]
related: [path/to/related.md]
---
Body
```

### Language Configuration
```json
// .claude/settings.local.json
{
  "env": {
    "OUTPUT_LANGUAGE": "en"
  }
}
```

- `OUTPUT_LANGUAGE`: Set the output language (`en`, `ja`, etc.). If not set, agents match the user's input language (default: English).

## Rules
- At the start of a new session, if `NOTEBOOK_PATH` is set, scan the Notebook for recent entries (list files in each directory, read the latest 3 across all types) to understand the user's current context and ongoing work
- Each agent writes its own deliverables
- If Notebook is not configured, skip persistence and output results only
- Each agent does not work outside its area of expertise
- Skills always operate through multi-agent coordination
- Output language follows `OUTPUT_LANGUAGE` setting, or matches the user's language (default: English)
- All Notebook writes must include structured frontmatter
