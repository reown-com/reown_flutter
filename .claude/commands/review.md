---
description: Review a pull request thoroughly
argument-hint: <pr-number>
---

# Review Pull Request #$1

You are reviewing PR #$1 with the following priorities:

1. **Would tests catch regressions?** - If someone changes this code incorrectly, will tests fail?
2. **Can a newcomer understand this?** - Is the code self-documenting?
3. **Is coupling appropriate?** - Are dependencies explicit and minimal?

## Step 1: Check for Local Worktree

First, check if there's a local worktree for this PR (most reviews will have one):

```bash
# Get PR details including linked issue and branch
PR_INFO=$(gh pr view $1 --json title,body,headRefName,files,additions,deletions,commits,reviews,comments)
echo "$PR_INFO"

# Extract issue number from PR body (looks for "Fixes #X" or "Closes #X")
ISSUE_NUM=$(echo "$PR_INFO" | jq -r '.body' | grep -oE '(Fixes|Closes|Resolves) #[0-9]+' | grep -oE '[0-9]+' | head -1)

# Check for worktree
REPO_ROOT=$(git rev-parse --show-toplevel)
WORKTREE_DIR="${REPO_ROOT}-worktrees/issue-${ISSUE_NUM}"

if [ -n "$ISSUE_NUM" ] && [ -d "$WORKTREE_DIR" ]; then
  echo "✅ Found local worktree at: $WORKTREE_DIR"
  echo "Will review from local files for better context."
else
  echo "ℹ️  No local worktree found. Will review from remote diff."
fi
```

If a worktree exists, `cd` into it and review from local files. Otherwise, fetch the diff:

```bash
gh pr diff $1
```

## Step 2: Understand Context

1. What issue does this PR fix? (Check for "Fixes #X" in the body)
2. Fetch the linked issue if present to understand requirements
3. Identify the scope of changes

## Step 3: Review Checklist

### Code Quality

- [ ] **Naming**: Are variables, functions, and files named clearly?
- [ ] **Single Responsibility**: Does each function/module do one thing well?
- [ ] **Error Handling**: Are errors handled appropriately, not swallowed?
- [ ] **No Dead Code**: Is all code reachable and necessary?

### Testing

- [ ] **Test Coverage**: Are new code paths tested?
- [ ] **Test Quality**: Do tests verify behavior, not implementation details?
- [ ] **Edge Cases**: Are boundary conditions tested?
- [ ] **Failure Modes**: Are error paths tested?
- [ ] **Regression Protection**: Would these tests catch common mistakes?

### Architecture

- [ ] **Loose Coupling**: Are dependencies injected, not hard-coded?
- [ ] **Appropriate Abstractions**: Not over-engineered, not under-abstracted?
- [ ] **Consistent Patterns**: Does this follow existing codebase conventions?
- [ ] **No Breaking Changes**: Does this maintain backward compatibility?

### Security (if applicable)

- [ ] **Input Validation**: Is user input validated?
- [ ] **No Secrets**: Are there any hardcoded credentials?
- [ ] **SQL/Command Injection**: Are queries parameterized?

## Step 4: Deep Dive

For each file changed:

1. **If worktree exists**: `cd` into the worktree and read files directly from there for the most accurate context
2. Read the full file (not just the diff) to understand context
3. Check if tests exist for the changed code
4. Look for potential issues the author might have missed

## Step 5: Submit Review

Submit findings as a PR comment (same user, can't self-approve):

```bash
gh pr comment $1 --body "<your review summary>"
```

## Step 6: Report Summary

Provide a structured summary:

### PR #$1 Review Summary

**Verdict**: [APPROVE / REQUEST CHANGES / COMMENT]

**What's Good**:

- <positive observations>

**Concerns**:

- <issues found, if any>

**Suggestions** (optional improvements):

- <non-blocking suggestions>

**Risk Assessment**: [LOW / MEDIUM / HIGH]

- <reasoning for risk level>
