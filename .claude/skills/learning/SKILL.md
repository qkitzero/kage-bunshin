---
name: learning
description: >
  Structured retrospective and lesson extraction. Use when reflecting on completed work or projects.
  Triggered by "learning", "retrospective", "what did we learn?", "reflection",
  or "what to apply next time".
user-invocable: true
---

# Learning Skill

A workflow that creates an Agent Team of Researcher and Analyst to perform structured retrospectives through evidence-based analysis and discussion.

## Workflow

### Step 1: Understand the Retrospective Target

Accurately understand the retrospective target presented by the user. Clarify:
- Subject (project, sprint, decision, event, etc.)
- Time period (from when to when)
- Stakeholders & context
- Original goals & expectations

Use open questions to help the user elaborate on details.

### Step 2: Retrieve Past Notebook Context

If `NOTEBOOK_PATH` is set, search for past lessons related to the retrospective target:

1. Grep `$NOTEBOOK_PATH/learnings/` and `$NOTEBOOK_PATH/research/` for keywords from the target (searching title, tags, and body)
2. Read up to 3 matching entries (frontmatter + first 200 characters of body)
3. Include the retrieved content as context when creating the team

Skip this step if zero matches or `NOTEBOOK_PATH` is not set.

### Step 3: Create Agent Team

Create a team with the following teammates using their agent definitions from `.claude/agents/`:

**Teammates:**
- `researcher` — gathers evidence, data, and context about what happened
- `analyst` — performs structured retrospective analysis

**Team instructions:**
```
Retrospective target: [Subject]
Time period: [Period]
Original goals: [Goals and expectations]
[Past Notebook context if found]

Collaboration protocol:
1. Researcher gathers evidence: project history, outcomes, metrics, related context from Notebook and codebase
2. Analyst performs initial retrospective analysis (what went well, what didn't, patterns, key learnings)
3. Researcher challenges the analysis — verifies claims against evidence, surfaces overlooked factors
4. Analyst refines the analysis based on Researcher's input, deepens root cause analysis
5. Continue iterating until both agree the lessons are well-evidenced and actionable (aim for 2-3 rounds)

Rules:
- Output language: Use the language specified by OUTPUT_LANGUAGE env var. If not set, match the user's language (default: English)
- If NOTEBOOK_PATH is set: Researcher saves evidence summary to $NOTEBOOK_PATH/research/, Analyst saves retrospective to $NOTEBOOK_PATH/learnings/
- Each agent writes its own deliverables with structured frontmatter (Analyst must use type: learning)
```

### Step 4: Final Output

```
## Retrospective: [Subject]

### Discussion Summary
[How the retrospective analysis evolved through team discussion]

### Time Period & Context
[Overview]

---

### What Went Well
1. **[Item]**: [Description]
   - Evidence: [Supporting data from Researcher]
2. ...

### What Didn't Go Well
1. **[Item]**: [Description]
   - Root cause: ...
   - Evidence: [Supporting data from Researcher]
2. ...

### Patterns
- [Recurring trends observed, validated by evidence]

### What to Do Differently
| Action | Priority | Notes |
|--------|----------|-------|
| ... | High | ... |

### Key Learnings
1. **[Lesson Title]**: [Generalized learning]
2. ...
3. ...

---

### Notebook Save
- [Save status and location]
```

## Output Format

Present the following to the user:
1. Brief summary of the team discussion process
2. What went well / What didn't go well (with evidence)
3. Discovered patterns
4. Specific improvement actions (with priority)
5. Key lessons (3)
6. Notebook save status
