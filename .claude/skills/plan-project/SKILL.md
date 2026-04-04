---
name: plan-project
description: >
  Research-backed comprehensive project planning. Use when planning a new project or initiative.
  Triggered by "make a plan", "I want to start a project", "break down tasks",
  or "create a roadmap".
user-invocable: true
---

# Plan Project Skill

A workflow that coordinates the Researcher and Planner agents to create actionable project plans backed by research. Each agent saves deliverables directly to the Notebook.

## Workflow

### Step 1: Understand the Goal

Accurately understand the project goal/objective presented by the user. Clarify:
- Project goal (what to achieve)
- Scope (what's included, what's not)
- Known constraints (timeline, budget, personnel, tech stack, etc.)
- Definition of success (what does success look like)

Confirm with the user if ambiguous.

### Step 1.5: Retrieve Past Notebook Context

If `NOTEBOOK_PATH` is set, search for past entries related to the project goal:

1. Grep `$NOTEBOOK_PATH/plans/` for keywords from the goal (searching title, tags, and body)
2. Also search for entries where the current project name (or inferred project name from the goal) matches the `project:` frontmatter
3. Read up to 3 matching entries (frontmatter + first 200 characters of body)
4. Prepend the retrieved content to the agent instructions in Steps 2 and 3 in this format:

```
## Related Past Plans (from Notebook)
### [Title] (date: YYYY-MM-DD)
[First 200 characters of body]
```

Skip this step if zero matches or `NOTEBOOK_PATH` is not set.

### Step 2: Research Phase (Researcher)

Invoke the `researcher` agent to gather background knowledge needed for planning:

**Instructions for researcher:**
```
Conduct preliminary research to plan the following project:

[Project Goal]
[User's project goal]

Research items:
1. Similar project cases and lessons learned
2. Best practices and recommended approaches
3. Common pitfalls and failure patterns
4. Required technology, tools, and resources overview
5. Risks to anticipate and countermeasures

Output as a concise research summary.
If NOTEBOOK_PATH is set, save research results to $NOTEBOOK_PATH/research/
```

### Step 3: Planning Phase (Planner)

Invoke the `planner` agent to create a detailed plan based on research results:

**Instructions for planner:**
```
Create a detailed plan for the following project:

[Project Goal]
[User's project goal]

[Constraints]
[User's constraints]

[Research Results]
[researcher's output]

Include the following elements:

1. **Phase Division**: Divide the project into 3-5 phases
2. **Milestones**: Completion criteria for each phase
3. **Task Breakdown**: Specific tasks within each phase (actionable granularity)
4. **Dependencies**: Sequential relationships between tasks
5. **Risks & Mitigations**: 3-5 key risks and their countermeasures
6. **Success Criteria**: Measurable success indicators
```

Include Notebook save instructions in the planner's prompt:
```
If NOTEBOOK_PATH is set, save the plan to $NOTEBOOK_PATH/plans/
```

If `NOTEBOOK_PATH` is not set, skip saving and output results in the conversation only.

### Step 4: Format the Plan

Based on the planner's output, create the final output:

```
## Project Plan: [Project Name]

### Overview
- **Goal**: ...
- **Scope**: ...
- **Estimated Duration**: ...
- **Success Criteria**: ...

---

### Phase 1: [Phase Name] (duration estimate)
**Milestone**: [Completion criteria]

| # | Task | Depends On | Estimate | Notes |
|---|------|-----------|----------|-------|
| 1.1 | ... | - | ... | ... |
| 1.2 | ... | 1.1 | ... | ... |
| ... | ... | ... | ... | ... |

### Phase 2: [Phase Name] (duration estimate)
...

---

### Risk Management

| Risk | Severity | Probability | Mitigation |
|------|----------|-------------|------------|
| ... | High/Med/Low | High/Med/Low | ... |

### Lessons from Research
- [Learnings from similar projects]
- [Pitfalls to avoid]

### Next Steps
- Start with the first task of Phase 1
- Regular `/learning` retrospectives recommended
```

## Output Format

Present the following to the user:
1. Project overview
2. Detailed plan by phase (with tasks, dependencies, and estimates)
3. Risk management table
4. Lessons from research
5. Next steps
6. Notebook save notification if applicable
