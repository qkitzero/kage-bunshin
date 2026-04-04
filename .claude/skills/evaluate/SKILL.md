---
name: evaluate
description: >
  Structured multi-dimensional evaluation. Use when assessing the feasibility of ideas or proposals.
  Triggered by "is this feasible?", "feasibility?", "should we do this?", "Go/No-Go decision",
  decision support, or proposal evaluation.
user-invocable: true
---

# Evaluate Skill

A workflow that coordinates the Researcher and Analyst agents to perform multi-dimensional evaluation of ideas and proposals.

## Workflow

### Step 1: Understand the Evaluation Target

Accurately understand the idea, proposal, or plan presented by the user. Clarify:
- Overview of the evaluation target
- Context (market, organization, technical environment, etc.)
- Any priority evaluation axes if specified

### Step 1.5: Retrieve Past Notebook Context

If `NOTEBOOK_PATH` is set, search for past entries related to the evaluation target:

1. Grep `$NOTEBOOK_PATH/reviews/` for keywords from the target (searching title, tags, and body)
2. Read up to 3 matching entries (frontmatter + first 200 characters of body)
3. Prepend the retrieved content to the agent instructions in Steps 2 and 3 in this format:

```
## Related Past Evaluations (from Notebook)
### [Title] (date: YYYY-MM-DD)
[First 200 characters of body]
```

Skip this step if zero matches or `NOTEBOOK_PATH` is not set.

### Step 2: Research Phase (Researcher)

Invoke the `researcher` agent to gather background information needed for evaluation:

**Instructions for researcher:**
```
Conduct background research to evaluate the following proposal/idea:

[Evaluation target description]

Research items:
1. Similar cases and precedents (successes and failures)
2. Current market/technology landscape and trends
3. Key competitors or alternatives
4. Anticipated risks or barriers
5. Key resources/technology needed for implementation

Output as a concise research summary.
If NOTEBOOK_PATH is set, save research results to $NOTEBOOK_PATH/research/
```

### Step 3: Evaluation Phase (Analyst)

Invoke the `analyst` agent to perform structured evaluation based on research results:

**Instructions for analyst:**
```
Provide a structured evaluation of the following proposal, based on research results:

[Evaluation Target]
[Evaluation target description]

[Research Results]
[researcher's output]

Score on the following 6 dimensions (1-5 each) with rationale:

1. Feasibility: Technically and resource-wise achievable?
2. Market Fit: Is there demand? Is the timing right?
3. Effort: Size of required investment (smaller = higher score)
4. Risk: Size of risk (smaller = higher score)
5. Innovation: Degree of novelty and differentiation
6. Impact: Magnitude of effect if implemented

Provide an overall recommendation of Go / Conditional Go / No-Go.
If NOTEBOOK_PATH is set, save evaluation results to $NOTEBOOK_PATH/reviews/
```

### Step 4: Final Output

```
## Evaluation Results: [Subject]

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
1. Decision Matrix (6-dimension score table)
2. Go / Conditional Go / No-Go recommendation with reasoning
3. Strengths and risks summary
4. Research summary
5. Next step suggestions
6. Notebook save notification if applicable
