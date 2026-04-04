<p align="center">
  <img src="assets/banner.svg" alt="Kage Bunshin - AI agents for knowledge work, not code" width="100%">
</p>

<p align="center">

[English](README.md) | [日本語](README_ja.md)

</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <a href="https://github.com/qkitzero/kage-bunshin/stargazers"><img src="https://img.shields.io/github/stars/qkitzero/kage-bunshin?style=social" alt="Stars"></a>
  <img src="https://img.shields.io/badge/Claude%20Code-compatible-blueviolet" alt="Claude Code compatible">
  <a href="https://github.com/qkitzero/kage-bunshin/pulls"><img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" alt="PRs Welcome"></a>
</p>

# Kage Bunshin

Multiple specialized AI agents collaborate on your intellectual work — brainstorming, evaluation, planning, research, and reflection — all within Claude Code.

---

## Features

**Thinking-first agent system** — While most AI agents assist with coding, Kage Bunshin extends your *thinking*. Idea generation, critical evaluation, project planning, research, and retrospectives.

**Notebook** — A dedicated git repository that stores all agent outputs. Ideas, decisions, and learnings persist across projects and sessions. Your knowledge travels with you.

**Multi-perspective collaboration** — Multiple agents with different thinking styles work together on each challenge. The Ideator expands possibilities while the Analyst sharpens them. Blind spots get covered.

**Structured knowledge graph** — All outputs are structured Markdown with frontmatter, tags, and cross-references. Human-readable and machine-searchable.

---

## Quick Start

### Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed

### Setup

1. Clone this repository

```bash
git clone https://github.com/qkitzero/kage-bunshin.git
```

2. Copy the `.claude/` directory to your project

```bash
cp -r kage-bunshin/.claude/ /path/to/your/project/.claude/
```

Or use it directly as a plugin.

3. (Optional) Configure Notebook path

Add the following to your project's `.claude/settings.local.json`:

```json
{
  "env": {
    "NOTEBOOK_PATH": "/path/to/your/notebook-repo"
  },
  "permissions": {
    "additionalDirectories": ["/path/to/your/notebook-repo"]
  }
}
```

4. (Optional) Set output language

```json
{
  "env": {
    "KAGE_BUNSHIN_LANGUAGE": "en"
  }
}
```

5. Launch Claude Code and start using skills!

---

## Usage

Kage Bunshin works through Claude Code skills (slash commands).

### Brainstorm

Ideator and Analyst collaborate for multi-perspective idea generation.

```
/brainstorm "Ideas for a new SaaS app"
```

### Evaluate

Researcher and Analyst collaborate for structured feasibility assessment.

```
/evaluate "Mobile-first task management app"
```

### Plan Project

Researcher and Planner collaborate for research-backed project planning.

```
/plan-project "Building a personal blog"
```

### Learning

Analyst performs structured retrospectives and extracts lessons.

```
/learning "Q1 project retrospective"
```

### Notebook

Search and manage your Notebook.

```
/notebook search "API design"
```

---

## Agents

Kage Bunshin has 4 specialized agents. Each has a unique thinking style and writes its own deliverables.

| Agent | Role | Thinking Style |
|-------|------|---------------|
| Ideator | Divergent thinking, brainstorming | Expands possibilities. Repeatedly asks "What if...?", removing constraints for free thinking |
| Analyst | Critical analysis, risk assessment, quality reviews | Evidence-based analysis. Provides constructive feedback through both evaluation and review |
| Planner | Task breakdown, scheduling | Bird's-eye view with step-by-step decomposition. Realistic plans considering dependencies and risks |
| Researcher | Deep investigation, information gathering | Multi-source verification and systematic organization. Prioritizes primary sources, watches for bias |

---

## Notebook

### What is a Notebook?

A Notebook is a dedicated git repository for storing agent deliverables. It is managed separately from your project repository.

### Why a Separate Repository?

- **Portability**: Your knowledge travels with you across projects
- **Privacy**: Personal thoughts and ideas stay out of project repositories
- **Clean history**: No pollution of your main repo's git history
- **Persistence**: Learnings and insights survive project completion

### Directory Structure

```
notebook-repo/
├── ideas/        # Ideas (ideator)
├── reviews/      # Evaluations & reviews (analyst)
├── research/     # Research reports (researcher)
├── plans/        # Project plans (planner)
├── learnings/    # Retrospectives & lessons (analyst via /learning)
└── index.md      # Master index (for search)
```

### Entry Format

All Notebook entries are Markdown with frontmatter.

```markdown
---
title: Entry name
type: idea | review | research | plan | learning
date: 2026-04-01
project: Project name
tags: [tag1, tag2]
related: [path/to/related.md]
---

Body content goes here.
```

---

## Customization

### Adding Custom Agents

Create a Markdown file in `.claude/agents/`.

```markdown
---
name: my-agent
model: sonnet
description: >
  Agent description.
tools:
  - Read
  - Grep
  - Glob
---

# Agent Name - Kage Bunshin

You are the **[Role Name]** agent of Kage Bunshin.

## Personality & Thinking Style
[Agent's personality and thinking characteristics]

## Output Format
[Define output template]

## Notebook Integration
[Define Notebook save rules]

## Constraints
[Define behavioral constraints]
```

### Modifying Existing Agents

Edit the corresponding Markdown file in `.claude/agents/` directly. You can freely customize thinking style, output format, tools, and more.

### Creating Custom Skills

Create skill definition files in `.claude/skills/` to define new workflows combining multiple agents.

### Extending Notebook Structure

The Notebook directory structure can be freely extended. When adding new categories, update the corresponding agent's Notebook Integration section as well.

---

## Design Philosophy

### A Cognitive Partner

Kage Bunshin is not just a tool — it's a cognitive partner that extends your thinking. Each agent has a unique thinking specialty, and through inter-agent coordination, they enable multi-perspective analysis that would be difficult alone.

### Think *Better*, Not Faster

The goal is not to automate thinking. It's to complement perspectives humans tend to miss, raising the quality of thought. The Analyst verifies your ideas have no gaps. The Ideator presents new possibilities that break fixed assumptions.

### Knowledge That Grows With You

Knowledge accumulated in the Notebook increases in value over time. Past ideas, decision records, and lessons learned cross-reference each other, forming your own personal knowledge graph. Even when projects change or machines change, your knowledge moves with you.

---

## License

MIT License. See [LICENSE](./LICENSE) for details.

---

<p align="center">
  If you find this project useful, please consider giving it a ⭐
</p>
