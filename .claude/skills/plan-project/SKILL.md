---
name: plan-project
description: >
  Research-backed comprehensive project planning. Use when planning a new project or initiative.
  Triggered by "make a plan", "I want to start a project", "break down tasks",
  or "create a roadmap".
user-invocable: true
---

# Plan Project Skill

A workflow that creates an Agent Team of Researcher and Planner to create actionable project plans through iterative research and planning refinement.

## Workflow

### Step 1: Understand the Goal

Accurately understand the project goal/objective presented by the user. Clarify:
- Project goal (what to achieve)
- Scope (what's included, what's not)
- Known constraints (timeline, budget, personnel, tech stack, etc.)
- Definition of success (what does success look like)

Confirm with the user if ambiguous.

### Step 2: Retrieve Past Notebook Context

If `NOTEBOOK_PATH` is set, search for past entries related to the project goal:

1. Grep `$NOTEBOOK_PATH/plans/` and `$NOTEBOOK_PATH/research/` for keywords from the goal
2. Also search for entries where the project name matches the `project:` frontmatter
3. Read up to 3 matching entries (frontmatter + first 200 characters of body)
4. Include the retrieved content as context when creating the team

Skip this step if zero matches or `NOTEBOOK_PATH` is not set.

### Step 3: Create Agent Team

Create a team with the following teammates using their agent definitions from `.claude/agents/`:

**Teammates:**
- `researcher` — gathers background knowledge and best practices
- `planner` — creates structured plans with tasks and dependencies

**Team instructions:**
```
Project goal: [User's goal]
Constraints: [User's constraints]
[Past Notebook context if found]

Collaboration protocol:
1. Researcher investigates: similar projects, best practices, pitfalls, required tech/resources, risks
2. Planner creates initial plan (phases, milestones, tasks, dependencies, risks)
3. Researcher reviews the plan for feasibility gaps — flags unrealistic estimates, missing risks, or overlooked dependencies based on research findings
4. Planner refines the plan based on Researcher's feedback
5. Continue iterating until both agree the plan is realistic and actionable (aim for 2-3 rounds)

Rules:
- Output language: Use the language specified by OUTPUT_LANGUAGE env var. If not set, match the user's language (default: English)
- If NOTEBOOK_PATH is set: Researcher saves to $NOTEBOOK_PATH/research/, Planner saves to $NOTEBOOK_PATH/plans/
- Each agent writes its own deliverables with structured frontmatter
```

### Step 4: Format the Plan

After the team completes its discussion, create the final output:

```
## Project Plan: [Project Name]

### Planning Summary
[How the plan evolved through researcher-planner discussion]

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
1. Brief summary of the team planning process
2. Project overview
3. Detailed plan by phase (with tasks, dependencies, and estimates)
4. Risk management table
5. Lessons from research
6. Next steps
7. Notebook save notification if applicable
