# Git Usage

A beginner-friendly guide to using Git for version control, covering everything from basic operations to advanced workflows.

## Prerequisites

This guide assumes you have Git installed and configured with your name and email. If you haven't done this yet, refer to these resources:

- [Official Git Installation Guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [First-Time Git Setup](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)

## Recommended Global Configuration

Before diving into Git usage, set these configurations to avoid common pitfalls and improve your workflow. You can apply these settings manually or use one of the provided scripts:

**Automated Setup:**

- **Bash:** Run `scripts/bash/setup-git-config.sh` (see [Bash Scripts](#/scripts/bash))
- **PowerShell:** Run `scripts/powershell/Setup-GitConfig.ps1` (see [PowerShell Scripts](#/scripts/powershell))

**Manual Configuration:**

```bash
# Prevent accidental rebase during pull (use explicit merge strategy)
git config --global pull.rebase false

# Automatically stash changes before rebase to prevent conflicts
git config --global rebase.autoStash true

# Update dependent branches automatically during rebase (Git 2.38+)
git config --global rebase.updateRefs true

# Show more helpful output during rebase conflicts
git config --global rebase.instructionFormat "(%an <%ae>) %s"

# Use a more readable default branch name
git config --global init.defaultBranch main

# Enable color output for better readability
git config --global color.ui auto
```

These settings help prevent the frustrating scenarios where commits appear to vanish or you end up in a detached HEAD state during rebasing operations.

## Basic Git Usage

This section covers the fundamental Git operations you'll use daily.

### Cloning a Repository

To create a local copy of an existing repository:

```bash
# Clone via HTTPS
git clone https://github.com/username/repository.git

# Clone via SSH (recommended for frequent contributors)
git clone git@github.com:username/repository.git

# Clone into a specific directory
git clone https://github.com/username/repository.git my-project
```

After cloning, navigate into the repository directory:

```bash
cd repository
```

### Checking Repository Status

Always check what's changed before making commits:

```bash
# See which files have been modified
git status

# See detailed line-by-line changes
git diff

# See changes that are staged for commit
git diff --staged
```

### Making Your First Commit

The basic workflow for tracking and committing changes:

```bash
# Stage a specific file
git add filename.txt

# Stage all modified files
git add .

# Stage all files with a specific extension
git add *.py

# Commit staged changes with a message
git commit -m "Add initial project structure"

# Stage and commit in one step (for tracked files only)
git commit -am "Update documentation"
```

**Commit Message Best Practices:**

- Use present tense ("Add feature" not "Added feature")
- Keep the first line under 50 characters
- Be descriptive but concise
- Reference issue numbers when applicable (e.g., "Fix login bug (#123)")

### Pushing Changes

Send your local commits to the remote repository:

```bash
# Push to the default remote (usually 'origin') and branch
git push

# Push to a specific remote and branch
git push origin main

# Push a new local branch to remote for the first time
git push -u origin feature-branch
```

The `-u` flag sets up tracking so future pushes can use just `git push`.

### Pulling Changes

Get the latest changes from the remote repository:

```bash
# Fetch and merge changes from the default remote
git pull

# Pull from a specific remote and branch
git pull origin main

# Fetch changes without merging (safer approach)
git fetch
git merge origin/main
```

### Working with Branches

Branches let you work on features without affecting the main codebase:

```bash
# List all local branches
git branch

# List all branches (local and remote)
git branch -a

# Create a new branch
git branch feature-name

# Switch to an existing branch
git checkout feature-name

# Create and switch to a new branch in one command
git checkout -b feature-name

# Delete a local branch (after merging)
git branch -d feature-name

# Force delete a branch (if not merged)
git branch -D feature-name
```

### Viewing History

Review what's happened in your repository:

```bash
# View commit history
git log

# View condensed one-line history
git log --oneline

# View history with a visual branch graph
git log --graph --oneline --all

# View changes in the last N commits
git log -n 5

# View commits by a specific author
git log --author="John Doe"
```

### Undoing Changes

Fix mistakes before they become permanent:

```bash
# Discard changes in a specific file (restore to last commit)
git checkout -- filename.txt

# Unstage a file (keep the changes)
git reset filename.txt

# Undo the last commit but keep changes staged
git reset --soft HEAD~1

# Undo the last commit and unstage changes
git reset HEAD~1

# Completely discard the last commit and all changes
git reset --hard HEAD~1
```

**Warning:** `git reset --hard` permanently deletes uncommitted changes. Use with caution.

## Advanced Git Usage

Once you're comfortable with the basics, these advanced techniques will improve your workflow.

### Feature Branch Workflow

A structured approach to developing new features:

1. **Create a feature branch from main:**

    ```bash
    git checkout main
    git pull origin main
    git checkout -b feature/user-authentication
    ```

2. **Work on your feature:**

    ```bash
    git add .
    git commit -m "Implement user login endpoint"
    ```

3. **Keep your branch updated with main:**

    ```bash
    git checkout main
    git pull origin main
    git checkout feature/user-authentication
    git merge main
    ```

4. **Push your feature branch:**

    ```bash
    git push -u origin feature/user-authentication
    ```

### Creating Pull Requests

Pull Requests (PRs) are how you propose changes to a repository:

1. Push your feature branch to the remote repository
2. Navigate to the repository on GitHub/GitLab/Bitbucket
3. Click "New Pull Request" or "Create Pull Request"
4. Select your feature branch as the source and `main` as the target
5. Write a clear description of what your changes do
6. Request reviews from team members
7. Address any feedback by pushing additional commits to the same branch
8. Once approved, merge the PR (options: merge commit, squash, or rebase)

**PR Best Practices:**

- Keep PRs focused on a single feature or fix
- Write descriptive titles and descriptions
- Link to related issues
- Keep PRs reasonably sized (aim for under 400 lines changed)
- Respond promptly to review comments

### Rebasing

Rebasing rewrites commit history to create a cleaner, linear history. Use it to incorporate changes from one branch into another.

**When to Rebase:**

- Updating your feature branch with the latest main branch changes
- Cleaning up your local commit history before creating a PR
- **Never** rebase commits that have been pushed to a shared branch

**Basic Rebase:**

```bash
# Update your feature branch with main branch changes
git checkout feature/user-authentication
git rebase main
```

If conflicts occur:

```bash
# Fix conflicts in the affected files, then:
git add conflicted-file.txt
git rebase --continue

# Or abort the rebase if things go wrong
git rebase --abort
```

**Interactive Rebase (for cleaning up commits):**

```bash
# Rebase the last 3 commits interactively
git rebase -i HEAD~3
```

This opens an editor where you can:

- `pick` = keep the commit as-is
- `reword` = change the commit message
- `squash` = combine with the previous commit
- `drop` = delete the commit

**Safe Rebasing Workflow:**

```bash
# 1. Make sure your working directory is clean
git status

# 2. Fetch the latest changes
git fetch origin

# 3. Rebase your feature branch onto main
git checkout feature/user-authentication
git rebase origin/main

# 4. If successful, force push (only for branches you own)
git push --force-with-lease origin feature/user-authentication
```

The `--force-with-lease` flag is safer than `--force` because it checks that no one else has pushed to the branch since your last fetch.

### Cherry-Picking Commits

Apply specific commits from one branch to another:

```bash
# Apply a specific commit to your current branch
git cherry-pick abc123def

# Apply multiple commits
git cherry-pick abc123 def456 ghi789

# Cherry-pick without committing (to modify before committing)
git cherry-pick -n abc123
```

### Stashing Changes

Temporarily save uncommitted changes without committing:

```bash
# Stash current changes
git stash

# Stash with a descriptive message
git stash save "WIP: refactoring authentication"

# List all stashes
git stash list

# Apply the most recent stash
git stash apply

# Apply and remove the most recent stash
git stash pop

# Apply a specific stash
git stash apply stash@{2}

# Delete a specific stash
git stash drop stash@{0}

# Delete all stashes
git stash clear
```

### Resolving Merge Conflicts

When Git can't automatically merge changes, you'll need to resolve conflicts manually:

1. **Identify conflicted files:**

    ```bash
    git status
    ```

2. **Open the conflicted file(s).** Look for conflict markers:

    ```
    <<<<<<< HEAD
    Your changes
    =======
    Their changes
    >>>>>>> branch-name
    ```

3. **Edit the file to resolve conflicts** by choosing which changes to keep or combining them.

4. **Mark as resolved and continue:**

    ```bash
    git add resolved-file.txt
    git commit
    ```

### Tagging Releases

Mark specific points in history as important (usually for releases):

```bash
# Create a lightweight tag
git tag v1.0.0

# Create an annotated tag (recommended)
git tag -a v1.0.0 -m "Release version 1.0.0"

# Tag a specific commit
git tag -a v1.0.0 abc123 -m "Release version 1.0.0"

# List all tags
git tag

# Push a specific tag to remote
git push origin v1.0.0

# Push all tags to remote
git push origin --tags

# Delete a local tag
git tag -d v1.0.0

# Delete a remote tag
git push origin --delete v1.0.0
```

### Working with Remotes

Manage connections to remote repositories:

```bash
# List remote repositories
git remote -v

# Add a new remote
git remote add upstream https://github.com/original/repository.git

# Change a remote's URL
git remote set-url origin git@github.com:username/repository.git

# Remove a remote
git remote remove upstream

# Fetch from a specific remote
git fetch upstream

# Rename a remote
git remote rename origin old-origin
```

### Advanced Log and Diff Commands

```bash
# View commits that changed a specific file
git log -- path/to/file.txt

# View actual changes in commits
git log -p

# View commits between two branches
git log main..feature-branch

# View changes between two commits
git diff abc123..def456

# View changes in a specific commit
git show abc123

# Find who changed each line of a file
git blame filename.txt

# Search commit messages
git log --grep="bug fix"
```

## Tips and Best Practices

- **Commit often:** Make small, focused commits rather than large, sprawling ones
- **Write meaningful commit messages:** Your future self will thank you
- **Pull before you push:** Always fetch the latest changes before pushing to avoid conflicts
- **Don't commit sensitive data:** Use `.gitignore` to exclude credentials, API keys, and local config files
- **Test before committing:** Make sure your code works before committing
- **Use branches for everything:** Never work directly on `main`
- **Keep main stable:** Only merge thoroughly tested and reviewed code
- **Delete merged branches:** Clean up branches after they've been merged to keep the repository tidy

## Common Troubleshooting

### Accidentally committed to main instead of a branch

```bash
# Create a new branch with your changes
git branch feature-name

# Reset main to match the remote
git reset --hard origin/main

# Switch to your new branch
git checkout feature-name
```

### Need to change the last commit message

```bash
# Amend the most recent commit message
git commit --amend -m "New commit message"

# If already pushed, force push (only if you own the branch)
git push --force-with-lease
```

### Accidentally deleted uncommitted changes

If you used `git reset --hard`, the changes are likely gone. However, if you just deleted files:

```bash
# Restore a deleted file
git checkout HEAD -- filename.txt
```

### Pushed commits to the wrong branch

```bash
# On the wrong branch, note the commit hash
git log

# Switch to the correct branch
git checkout correct-branch

# Cherry-pick the commits
git cherry-pick abc123

# Switch back and remove the commits from the wrong branch
git checkout wrong-branch
git reset --hard HEAD~1
git push --force-with-lease
```

## Additional Resources

- [Pro Git Book](https://git-scm.com/book/en/v2) - Comprehensive free book
- [GitHub Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials)
- [Interactive Git Branching Tutorial](https://learngitbranching.js.org/)
