---
name: brainstorm
description: >
  Multi-perspective brainstorming session. Use when the user wants to generate and evaluate ideas
  on a topic. Triggered by idea generation, brainstorming, "any good ideas?",
  wanting new solutions, or creative suggestions.
user-invocable: true
---

# Brainstorm Skill

A workflow that creates an Agent Team of Ideator and Analyst to perform iterative idea divergence and convergence through multi-round discussion.

## Workflow

### Step 1: Understand the Theme

Accurately understand the theme, challenge, or problem presented by the user. If ambiguous, confirm the following before proceeding:
- Target domain (business, technology, creative, etc.)
- Constraints (budget, timeline, tech stack, etc.)
- Required granularity of deliverables

### Step 2: Retrieve Past Notebook Context

If `NOTEBOOK_PATH` is set, search for past entries related to the user's theme:

1. Grep `$NOTEBOOK_PATH/ideas/` for keywords from the theme (searching title, tags, and body)
2. Read up to 3 matching entries (frontmatter + first 200 characters of body)
3. Include the retrieved content as context when creating the team

Skip this step if zero matches or `NOTEBOOK_PATH` is not set.

### Step 3: Create Agent Team

Create a team with the following teammates using their agent definitions from `.claude/agents/`:

**Teammates:**
- `ideator` — generates creative ideas
- `analyst` — evaluates and challenges ideas

**Team instructions:**
```
Theme: [User's theme]
[Past Notebook context if found]

Collaboration protocol:
1. Ideator generates 5-7 ideas with summary, rationale, and impact assessment
2. Analyst evaluates each idea (Feasibility, Impact, Novelty, Risk on 1-5 scale) and provides improvement suggestions
3. Ideator refines weak ideas based on Analyst's feedback, may propose new ideas inspired by the critique
4. Analyst re-evaluates the refined ideas
5. Continue iterating until both agree on a final ranked list (aim for 2-3 rounds)

Rules:
- Output language: Use the language specified by OUTPUT_LANGUAGE env var. If not set, match the user's language (default: English)
- If NOTEBOOK_PATH is set: Ideator saves final ideas to $NOTEBOOK_PATH/ideas/, Analyst saves evaluation to $NOTEBOOK_PATH/reviews/
- Each agent writes its own deliverables with structured frontmatter
```

### Step 4: Synthesis & Ranking

After the team completes its discussion, create the final output:

```
## Brainstorming Results: [Theme]

### Discussion Summary
[Brief description of how ideas evolved through iteration]

### #1: [Idea Name]
- **Overall Score**: X.X / 5.0
- **Summary**: ...
- **Scores**: Feasibility X | Impact X | Novelty X | Risk X
- **Strengths**: ...
- **How it was refined**: ...

### #2: [Idea Name]
...

### #3: [Idea Name]
...

### Other Ideas
- [Idea Name]: Overall Score X.X - [One-line summary]

### Next Steps
- Recommend `/evaluate` for detailed assessment of promising ideas
- Recommend `/plan-project` for turning ideas into projects
```

## Output Format

Present the following to the user:
1. Brief summary of the team discussion and iteration process
2. Top 3 ideas in detail (with scores, evaluation, and how they were refined)
3. List of remaining ideas
4. Next step suggestions
5. Notebook save notification if applicable
