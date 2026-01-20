---
description: Analyze open PRs for merge order and potential concerns
---

# Summarize Open PRs

Analyze all open PRs to determine optimal merge order and flag potential concerns.

## Step 1: Fetch All Open PRs

```bash
gh pr list --repo reown-com/pay-mvp-core-worker --state open --json number,title,body,files,additions,deletions,reviews,createdAt,headRefName,mergeable,mergeStateStatus
```

## Step 2: For Each PR, Gather Details

For each open PR, fetch:

```bash
# Get the diff to understand scope
gh pr diff <PR_NUMBER> --repo reown-com/pay-mvp-core-worker

# Get linked issues
gh pr view <PR_NUMBER> --repo reown-com/pay-mvp-core-worker --json body
```

## Step 3: Analyze Dependencies

From the issue plan, the dependency graph is:

- **Phase 1 (independent)**: #1 (done), #5, #7
- **Phase 2**: #2 (needs #1)
- **Phase 3**: #3 (needs #2), #4 (needs #2 and #5)
- **Phase 4**: #6 (needs #3, #4, #7), then #8

Map each PR to its issue and identify:

1. Which PRs block other PRs
2. Which PRs can be merged in parallel
3. Which PRs have unmet dependencies

## Step 4: Check for Conflicts

For each pair of PRs, consider:

1. Do they touch the same files?
2. Could merging one cause conflicts in another?
3. Are there semantic conflicts (same feature implemented differently)?

```bash
# Compare files changed between PRs
gh pr view <PR1> --repo reown-com/pay-mvp-core-worker --json files -q '.files[].path' > /tmp/pr1_files.txt
gh pr view <PR2> --repo reown-com/pay-mvp-core-worker --json files -q '.files[].path' > /tmp/pr2_files.txt
comm -12 <(sort /tmp/pr1_files.txt) <(sort /tmp/pr2_files.txt)
```

## Step 5: Risk Assessment

For each PR, evaluate:

### Quality Signals

- **Test Coverage**: Does PR add tests? Are existing tests passing?
- **Review Status**: Approved? Changes requested? No reviews?
- **Merge Status**: Mergeable? Has conflicts?
- **Size**: LOC added/removed (large PRs = higher risk)

### Concern Flags

- 🔴 **HIGH RISK**: No tests, security-sensitive, large scope
- 🟡 **MEDIUM RISK**: Partial tests, touches critical paths
- 🟢 **LOW RISK**: Well-tested, isolated changes

## Step 6: Generate Report

### Open PRs Summary

| PR  | Title | Issue | Status | Risk | Blocks | Blocked By |
| --- | ----- | ----- | ------ | ---- | ------ | ---------- |
| #X  | ...   | #Y    | ...    | 🟢   | #A, #B | #C         |

### Recommended Merge Order

1. **First batch** (can merge in parallel):
   - PR #X - <reason>
   - PR #Y - <reason>

2. **Second batch** (after first batch merges):
   - PR #Z - <reason>

3. **Hold for review**:
   - PR #W - <concerns>

### Flagged Concerns

**PR #X**: <specific concern>

- Trade-off: <what's being traded off>
- Recommendation: <merge / hold / needs changes>

**Potential Conflicts**:

- PR #A and PR #B both modify `<file>` - merge A first, then rebase B

### Quick Actions

```bash
# Merge recommended PRs (in order)
gh pr merge <PR_NUMBER> --repo reown-com/pay-mvp-core-worker --squash

# After merging, update other branches
# (run in each worktree)
git fetch origin dev && git rebase origin/dev
```

## Step 7: Cleanup Suggestion

After merging, remind to clean up worktrees:

```bash
# List worktrees
git worktree list

# Remove merged worktrees
git worktree remove <path>
```
