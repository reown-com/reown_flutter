---
description: Respond to PR review feedback and push fixes
argument-hint: [pr-number]
---

# Respond to PR Review Feedback

You are addressing review feedback on a PR. If a PR number is provided, use #$1. Otherwise, detect the current branch and find its PR.

## Step 1: Identify the PR

```bash
# If PR number provided, use it; otherwise get from current branch
if [ -n "$1" ]; then
  PR_NUMBER=$1
else
  PR_NUMBER=$(gh pr view --json number -q .number 2>/dev/null)
fi

echo "Working on PR #$PR_NUMBER"
```

## Step 2: Fetch Review Comments

```bash
# Get all reviews and comments
gh pr view $PR_NUMBER --json reviews,comments,reviewRequests

# Get review threads (includes line comments)
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
gh api repos/$REPO/pulls/$PR_NUMBER/comments
```

## Step 3: Analyze Feedback

Categorize each piece of feedback:

1. **Must Fix**: Blocking issues, bugs, security concerns
2. **Should Fix**: Valid improvements, better practices
3. **Consider**: Suggestions, style preferences (discuss if disagreeing)
4. **Won't Fix**: Explain reasoning if pushing back

## Step 4: Address Feedback

For each actionable item:

1. Make the necessary code changes
2. Ensure tests still pass (or add new tests if needed)
3. Keep changes focused - only address the feedback, don't scope creep

```bash
# Run tests after changes
pnpm test

# Type check
pnpm run typecheck
```

## Step 5: Commit Updates

Use a clear commit message that references the feedback:

```bash
git add -A
git commit -m "fix: address review feedback

- <summary of changes made>
- <another change>

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

git push
```

## Step 6: Reply to Comments

For each review comment, reply to acknowledge:

```bash
# Reply to a specific review comment
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
gh api repos/$REPO/pulls/$PR_NUMBER/comments/{comment_id}/replies \
  -f body="Done - <brief explanation of change>"
```

Or use the PR conversation:

```bash
gh pr comment $PR_NUMBER --body "Addressed feedback:
- ✅ <item 1>
- ✅ <item 2>
- 💬 <item discussed/pushed back on with reasoning>"
```

## Step 7: Request Re-review (if needed)

```bash
gh pr edit $PR_NUMBER --add-reviewer <reviewer-username>
```

## Step 8: Report Summary

Provide:

1. List of changes made
2. Any feedback you pushed back on (with reasoning)
3. Outstanding items (if any)
4. Current PR status
