---
description: Fix a GitHub issue in a new worktree and submit a PR
argument-hint: <issue-number>
---

# Fix GitHub Issue #$1

You are working in a git worktree for isolated, parallel development. Your goal is to fix issue #$1 while ensuring:

1. **Tests protect the implementation** - Any new code must have tests that would catch regressions
2. **Readability for newcomers** - Code should be self-documenting; another developer should understand it quickly
3. **Loose coupling** - Prefer composition and interfaces over tight dependencies

## Step 1: Setup Worktree

First, create a worktree for this issue:

```bash
# Get the repo root and create worktree directory
REPO_ROOT=$(git rev-parse --show-toplevel)
WORKTREE_DIR="${REPO_ROOT}-worktrees/issue-$1"

# Create worktree from dev branch
git fetch origin dev
git worktree add "$WORKTREE_DIR" -b fix/issue-$1 origin/dev

# Navigate to worktree and install dependencies
cd "$WORKTREE_DIR"
pnpm install
```

**IMPORTANT**: After creating the worktree, you MUST `cd` into it and work there.

## Step 2: Understand the Issue

Fetch and analyze the issue:

```bash
gh issue view $1 --repo reown-com/pay-mvp-core-worker --json title,body,labels,comments
```

Read the issue carefully. Identify:

- What needs to be implemented/fixed
- Dependencies on other issues (check "Depends on" in the body)
- What files will likely need changes
- What tests need to be written

## Step 3: Explore & Plan

Before writing code:

1. Search the codebase for related existing code
2. Understand current patterns and conventions
3. Identify integration points
4. Plan your approach - prefer small, focused changes

## Step 4: Implement with Tests

Follow this order:

1. **Write failing tests first** (TDD approach when possible)
2. **Implement the minimum code** to make tests pass
3. **Refactor** for clarity without changing behavior

Guidelines:

- Each new module should have a corresponding test file
- Use descriptive test names that explain the behavior being tested
- Mock external dependencies (DB, APIs) at boundaries
- Ensure tests would catch common mistakes a new developer might make

## Step 5: Validate

```bash
# Run the full test suite
pnpm test

# Run type checking
tsc --noEmit 2>&1

# Format code
pnpm format
```

All checks must pass before proceeding.

## Step 6: Commit & Create PR

```bash
# Stage all changes
git add -A

# Commit with conventional commit format
git commit -m "feat: <description>

Fixes #$1

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Push the branch
git push -u origin fix/issue-$1

# Create PR targeting dev branch
gh pr create \
  --base dev \
  --title "feat: <title from issue>" \
  --body "## Summary
<Brief description of changes>

## Changes
- <List key changes>

## Testing
- <Describe tests added>
- [ ] All tests pass
- [ ] No type errors (`tsc --noEmit`)

Fixes #$1

🤖 Generated with [Claude Code](https://claude.com/claude-code)"
```

## Step 7: Report Back

After creating the PR, provide:

1. Link to the PR
2. Summary of what was implemented
3. Any concerns or trade-offs made
4. Suggestions for related improvements (don't implement, just note)
