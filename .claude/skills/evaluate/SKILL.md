---
name: evaluate
description: >
  Structured multi-dimensional evaluation. Use when assessing the feasibility of ideas or proposals.
  Triggered by "is this feasible?", "feasibility?", "should we do this?", "Go/No-Go decision",
  decision support, or proposal evaluation.
user-invocable: true
---

# Evaluate Skill

A workflow that creates an Agent Team of Researcher and Analyst to perform multi-dimensional evaluation through iterative investigation and assessment.

## Workflow

### Step 1: Understand the Evaluation Target

Accurately understand the idea, proposal, or plan presented by the user. Clarify:
- Overview of the evaluation target
- Context (market, organization, technical environment, etc.)
- Any priority evaluation axes if specified

### Step 2: Retrieve Past Notebook Context

If `NOTEBOOK_PATH` is set, search for past entries related to the evaluation target:

1. Grep `$NOTEBOOK_PATH/reviews/` and `$NOTEBOOK_PATH/research/` for keywords from the target
2. Read up to 3 matching entries (frontmatter + first 200 characters of body)
3. Include the retrieved content as context when creating the team

Skip this step if zero matches or `NOTEBOOK_PATH` is not set.

### Step 3: Create Agent Team

Create a team with the following teammates using their agent definitions from `.claude/agents/`:

**Teammates:**
- `researcher` — gathers background information and evidence
- `analyst` — performs structured evaluation and scoring

**Team instructions:**
```
Evaluation target: [Description]
[Past Notebook context if found]

Collaboration protocol:
1. Researcher investigates: similar cases, market/tech landscape, competitors, risks, required resources
2. Analyst performs initial evaluation based on research (6 dimensions: Feasibility, Market Fit, Effort, Risk, Innovation, Impact)
3. Analyst identifies information gaps and requests additional research from Researcher
4. Researcher conducts targeted follow-up investigation
5. Analyst refines scores and produces final Go / Conditional Go / No-Go recommendation
6. Continue iterating until Analyst is confident in the assessment (aim for 2-3 rounds)

Rules:
- Output language: Use the language specified by OUTPUT_LANGUAGE env var. If not set, match the user's language (default: English)
- If NOTEBOOK_PATH is set: Researcher saves to $NOTEBOOK_PATH/research/, Analyst saves to $NOTEBOOK_PATH/reviews/
- Each agent writes its own deliverables with structured frontmatter
```

### Step 4: Final Output

```
## Evaluation Results: [Subject]

### Investigation Summary
[How the research and evaluation evolved through discussion]

### Decision Matrix

| Dimension | Score | Rationale |
|-----------|-------|-----------|
| Feasibility | X/5 | ... |
| Market Fit | X/5 | ... |
| Effort | X/5 | ... |
| Risk | X/5 | ... |
| Innovation | X/5 | ... |
| Impact | X/5 | ... |
| **Overall** | **X.X/5** | |

### Recommendation: [Go / Conditional Go / No-Go]

**Reason:** [2-3 sentence overall judgment]

### Strengths / Risks & Concerns / Research Summary

### Next Steps
- If Go: Recommend `/plan-project` for project planning
- If further research needed: Present specific research points
```

## Output Format

Present the following to the user:
1. Brief summary of the team investigation process
2. Decision Matrix (6-dimension score table)
3. Go / Conditional Go / No-Go recommendation with reasoning
4. Strengths and risks summary
5. Next step suggestions
6. Notebook save notification if applicable
