---
name: notebook
description: >
  Notebook management, search, and organization. Use for all Notebook operations.
  Triggered by "find past ideas", "search Notebook", "show knowledge base",
  "organize records", or "check saved content".
user-invocable: true
---

# Notebook Skill

A workflow for performing search, browse, organize, and stats operations on the Notebook.

## Prerequisites

First check the `NOTEBOOK_PATH` environment variable.

**If not set:**
```
Notebook is not configured.

Setup instructions:
1. Create a git repository for your Notebook
2. Add the following to .claude/settings.local.json:
   {
     "env": {
       "NOTEBOOK_PATH": "/path/to/your/notebook-repo"
     },
     "permissions": {
       "additionalDirectories": ["/path/to/your/notebook-repo"]
     }
   }
3. Restart Claude Code
```

Display this and exit. The following workflow only executes when Notebook is configured.

## Workflow

### Step 1: Determine the Operation

Classify the user's request into one of these operations:

| Operation | Trigger Examples |
|-----------|-----------------|
| **search** | "find...", "any records about...?", "anything saved about...?" |
| **browse** | "show recent records", "list entries", "what's in the Notebook?" |
| **organize** | "organize tags", "update cross-references", "add related links" |
| **stats** | "Notebook statistics", "how much is stored?", "show breakdown" |

### Step 2: Execute the Operation

Operate directly on the `$NOTEBOOK_PATH` path using the following tools.

#### search

1. Glob for filename matching
2. Grep frontmatter tags, title, type for matching
3. Grep body for keyword matching

Output results in this format:
- File path, title, type, date
- Relevant snippet (2 lines before/after the match)

#### browse

1. Glob to retrieve all entries
2. Read frontmatter of each file
3. Group by type, sort by date descending

#### organize

1. Read target entries
2. Edit frontmatter tags / related fields
3. Update index.md (table format with date, title, type, path)

Confirm changes with the user before making modifications.

#### stats

1. Glob to count all entries
2. Grep to aggregate by type and project
3. Aggregate tag frequency

### Step 3: Format and Output Results

Format operation results for easy reading and present to the user.

Based on results, suggest related skills:
- For search results with ideas → "You can re-evaluate with `/evaluate`"
- For old plans → "You can reflect with `/learning`"
- For entries with few related links → "You can add cross-references with `/notebook organize`"

## Output Format

Present formatted results appropriate to the operation. Always include:
1. Operation results
2. Suggested next actions
