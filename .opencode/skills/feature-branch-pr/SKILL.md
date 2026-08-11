---
name: feature-branch-pr
description: Automate Git workflow: create feature branch from main/master, commit changes with auto-generated messages, and open PRs with auto-generated descriptions. Use when user wants to commit changes, create branches, or open PRs.
---

Automate the Git/GitHub workflow: create feature branches, commit changes with auto-generated messages, and open PRs with auto-generated descriptions.

## Process

### 1. Detect current branch

Run `git branch --show-current` to get the current branch name.

- If on `main` or `master` → proceed to step 2 (create feature branch)
- If on a feature branch → skip to step 3 (stage and commit)

**Completion criterion:** Current branch name captured and decision made.

### 2. Create feature branch (if on main/master)

1. Check for uncommitted changes: `git status --porcelain`
2. If changes exist, ask user: "You're on main/master with uncommitted changes. Create a feature branch first?"
3. Ask user: "What's the feature name?" (e.g., "add-login-page")
4. Create and switch to feature branch: `git checkout -b feature/<name>`
5. Display: "Created and switched to feature/<name>"

**Completion criterion:** On feature branch with name confirmed.

### 3. Stage changes

1. Run `git status` to check for changes
2. If no changes → display "No changes to commit" and stop
3. Stage changes: `git add .`
4. Confirm staging: `git diff --cached --stat`
5. If no staged changes → display "No changes to commit" and stop

**Completion criterion:** Changes staged and ready to commit.

### 4. Generate commit message

Analyze staged changes with `git diff --cached` to generate a commit message following conventional commits format:

**Type detection:**
- New files only → `feat`
- Modified files → Analyze changes:
  - Documentation (*.md, *.txt) → `docs`
  - Tests (*test*, *spec*) → `test`
  - Config files → `chore`
  - Code logic changes → `fix` or `feat` based on scope
  - Code formatting/style → `style`
  - Code restructuring → `refactor`
- Deleted files → `refactor` or `feat`

**Scope detection:**
- Use the common directory prefix of changed files
- If files span multiple directories, use the most prominent one
- Omit scope if changes are too diverse

**Description rules:**
- Imperative mood ("add" not "added" or "adds")
- Lowercase first letter
- No period at end
- Keep under 50 characters
- Focus on *what* changed, not *how*

**Example:** `feat(auth): add login page with OAuth support`

### 5. Commit changes

1. Run `git commit -m "<generated message>"`
2. Verify commit: `git log -1 --oneline`
3. Display: "Committed: <message>"

**Completion criterion:** Changes committed successfully.

### 6. Ask about PR

Ask user: "Do you want to open a PR? (yes/no)"

- If no → display "Done! Changes committed to feature/<name>" and stop
- If yes → proceed to step 7

**Completion criterion:** User decision received.

### 7. Detect base branch

1. Check if `main` exists: `git branch --list main`
2. Check if `master` exists: `git branch --list master`
3. If both exist, ask user which to use as base
4. If only one exists, use that one
5. If neither exists, ask user for base branch name

**Completion criterion:** Base branch identified.

### 8. Generate PR description

Analyze the feature branch changes to generate a PR description:

1. Get commit history: `git log <base-branch>..HEAD --oneline`
2. Get diff summary: `git diff <base-branch>...HEAD --stat`
3. Get full diff: `git diff <base-branch>...HEAD`

**Generate description with:**

```markdown
## Summary
[1-2 sentences describing overall purpose of changes]

## Changes
- [Bullet point for each significant change, derived from commits and diff]

## Testing
- [How to test these changes, if discernible from code]
- [Any test files added/modified]

## Related
[List of commits from feature branch]
```

**Completion criterion:** PR description generated.

### 9. Create PR

1. Check gh CLI is available: `gh --version`
2. Check authentication: `gh auth status`
3. If not authenticated → display instructions and stop
4. Check for existing PR: `gh pr list --head feature/<name>`
5. If PR exists → display existing PR URL and stop
6. Create PR:
   ```bash
   gh pr create \
     --base <base-branch> \
     --head feature/<name> \
     --title "<commit message>" \
     --body "<generated description>"
   ```
7. Extract PR URL from output
8. Display: `🚀 your PR is opened take a look: <PR_URL>`

**Completion criterion:** PR created and URL displayed.

## Edge Cases

- **No changes to commit:** Stop with message "No changes to commit"
- **gh CLI missing:** Display "GitHub CLI (gh) is not installed. Install from https://cli.github.com/"
- **gh not authenticated:** Display "Run 'gh auth login' to authenticate with GitHub"
- **PR already exists:** Display "PR already exists: <URL>"
- **Empty diff after commits:** Don't create PR, display message
- **User cancels:** Gracefully stop at any prompt with "Operation cancelled"

## Examples

### Scenario 1: On main, create new feature
```
$ git branch --show-current
main

→ You're on main. What's the feature name?
user: add-dark-mode

→ Created and switched to feature/add-dark-mode
→ Changes staged: 3 files changed, 45 insertions(+), 12 deletions(-)
→ Committed: feat(ui): add dark mode toggle
→ Do you want to open a PR? (yes/no)
user: yes

→ 🚀 your PR is opened take a look: https://github.com/user/repo/pull/42
```

### Scenario 2: On feature branch, commit directly
```
$ git branch --show-current
feature/add-login

→ Changes staged: 2 files changed, 28 insertions(+), 5 deletions(-)
→ Committed: feat(auth): implement login form validation
→ Do you want to open a PR? (yes/no)
user: no

→ Done! Changes committed to feature/add-login
```
