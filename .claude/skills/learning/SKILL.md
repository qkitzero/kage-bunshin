---
name: learning
description: >
  Structured retrospective and lesson extraction. Use when reflecting on completed work or projects.
  Triggered by "learning", "retrospective", "what did we learn?", "reflection",
  or "what to apply next time".
user-invocable: true
---

# Learning Skill

A workflow that uses the Analyst agent to perform structured retrospectives and persist lessons learned.

## Workflow

### Step 1: Understand the Retrospective Target

Accurately understand the retrospective target presented by the user. Clarify:
- Subject (project, sprint, decision, event, etc.)
- Time period (from when to when)
- Stakeholders & context
- Original goals & expectations

Use open questions to help the user elaborate on details.

### Step 1.5: Retrieve Past Notebook Context

If `NOTEBOOK_PATH` is set, search for past lessons related to the retrospective target:

1. Grep `$NOTEBOOK_PATH/learnings/` for keywords from the target (searching title, tags, and body)
2. Read up to 3 matching entries (frontmatter + first 200 characters of body)
3. Prepend the retrieved content to the agent instructions in Step 2 in this format:

```
## Related Past Lessons (from Notebook)
### [Title] (date: YYYY-MM-DD)
[First 200 characters of body]
```

Skip this step if zero matches or `NOTEBOOK_PATH` is not set.

### Step 2: Analysis Phase (Analyst)

Invoke the `analyst` agent to perform structured analysis:

**Instructions for analyst:**
```
Perform a structured retrospective analysis on the following:

[Retrospective Target]
[Target description]

[Time Period & Context]
[Period and background information]

[Original Goals]
[Goals and expectations]

Analyze using the following framework:

1. **What went well**
   - Identify 3-5 success factors
   - Analyze why they worked

2. **What didn't go well**
   - Identify 3-5 problems/challenges
   - Root cause analysis

3. **Patterns**
   - Recurring patterns observed
   - Connections to similar past experiences

4. **What to do differently**
   - Specific, actionable improvement actions
   - Priority for each action (High / Medium / Low)

5. **Key Learnings**
   - The 3 most important lessons from this experience
   - Express in a generalizable form applicable to other contexts

If NOTEBOOK_PATH is set:
- Save retrospective and lessons to $NOTEBOOK_PATH/learnings/YYYY-MM-DD-{slug}.md (frontmatter type must be `learning`)
```

### Step 3: Final Output

```
## Retrospective: [Subject]

### Time Period & Context
[Overview]

---

### What Went Well
1. **[Item]**: [Description]
2. ...

### What Didn't Go Well
1. **[Item]**: [Description]
   - Root cause: ...
2. ...

### Patterns
- [Recurring trends observed]

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
1. What went well / What didn't go well
2. Discovered patterns
3. Specific improvement actions (with priority)
4. Key lessons (3)
5. Notebook save status
