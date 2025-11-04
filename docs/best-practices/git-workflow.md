# Git Workflow

This guide outlines the Git workflow and best practices for ShruggieTech projects. Following these conventions ensures smooth collaboration and maintainable project history.

## Branching Strategy

### Main Branches

#### `main` (or `master`)
- Production-ready code
- Always stable and deployable
- Protected branch (requires PR and reviews)
- Tagged for releases

#### `develop` (optional, for larger projects)
- Integration branch for features
- Contains latest development changes
- Merged to `main` for releases

### Supporting Branches

#### Feature Branches
- Branch from: `main` or `develop`
- Merge back to: `main` or `develop`
- Naming: `feature/description` or `feature/issue-123`

```bash
# Create feature branch
git checkout -b feature/user-authentication main

# Work on feature
git add .
git commit -m "feat: add user authentication"

# Push to remote
git push -u origin feature/user-authentication
```

#### Bugfix Branches
- Branch from: `main` or `develop`
- Merge back to: `main` or `develop`
- Naming: `bugfix/description` or `bugfix/issue-123`

```bash
git checkout -b bugfix/login-error main
```

#### Hotfix Branches
- Branch from: `main`
- Merge back to: `main` and `develop`
- Naming: `hotfix/description` or `hotfix/issue-123`

```bash
# Create hotfix
git checkout -b hotfix/security-patch main

# After fix, merge to main
git checkout main
git merge --no-ff hotfix/security-patch
git tag -a v1.0.1 -m "Security patch"

# Merge to develop
git checkout develop
git merge --no-ff hotfix/security-patch

# Delete hotfix branch
git branch -d hotfix/security-patch
```

#### Release Branches (for larger projects)
- Branch from: `develop`
- Merge back to: `main` and `develop`
- Naming: `release/v1.0.0`

```bash
git checkout -b release/v1.0.0 develop
# Bump version, update changelog
git checkout main
git merge --no-ff release/v1.0.0
git tag -a v1.0.0 -m "Release version 1.0.0"
```

## Commit Guidelines

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

#### Type
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style (formatting, missing semicolons, etc.)
- `refactor`: Code refactoring (no feature change, no bug fix)
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks (build, dependencies, etc.)
- `ci`: CI/CD changes
- `revert`: Revert previous commit

#### Scope (optional)
Component or module affected: `auth`, `api`, `database`, `ui`

#### Subject
- Use imperative mood: "add" not "added" or "adds"
- Don't capitalize first letter
- No period at the end
- Max 50 characters

#### Body (optional)
- Explain what and why, not how
- Wrap at 72 characters
- Separate from subject with blank line

#### Footer (optional)
- Reference issues: `Fixes #123`, `Closes #456`
- Breaking changes: `BREAKING CHANGE: description`

### Examples

#### Simple Commit
```
feat: add user authentication
```

#### Detailed Commit
```
feat(auth): add JWT-based authentication

Implement JWT authentication to replace session-based auth.
This provides better scalability and enables stateless API.

- Add JWT middleware
- Update user model with token methods
- Add refresh token endpoint

Fixes #123
```

#### Breaking Change
```
refactor(api): change user endpoint response format

BREAKING CHANGE: User endpoint now returns snake_case instead
of camelCase. Update client code accordingly.
```

## Pull Request Workflow

### Creating a Pull Request

1. **Ensure branch is up to date**
```bash
git checkout main
git pull origin main
git checkout feature/my-feature
git rebase main
```

2. **Push to remote**
```bash
git push origin feature/my-feature
```

3. **Create PR on GitHub**
- Use descriptive title
- Fill out PR template
- Link related issues
- Add reviewers
- Add appropriate labels

### PR Title Format
```
Type: Brief description

Examples:
feat: Add user authentication
fix: Resolve login redirect issue
docs: Update API documentation
```

### PR Description Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Changes Made
- Change 1
- Change 2
- Change 3

## Testing
How the changes were tested

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] All tests passing
- [ ] No new warnings

## Related Issues
Fixes #123
Related to #456
```

### Review Process

**For Authors:**
- Respond to all comments
- Make requested changes
- Mark conversations as resolved
- Request re-review when ready

**For Reviewers:**
- Review within 24-48 hours
- Be constructive and respectful
- Test the changes locally if needed
- Approve when satisfied

### Merging

**Options:**
1. **Merge Commit** - Preserves all commits and merge history
2. **Squash and Merge** - Combines commits into one (recommended for features)
3. **Rebase and Merge** - Linear history without merge commits

**After Merge:**
```bash
# Delete local branch
git branch -d feature/my-feature

# Delete remote branch (if not auto-deleted)
git push origin --delete feature/my-feature

# Update local main
git checkout main
git pull origin main
```

## Working with Remotes

### Basic Operations
```bash
# Add remote
git remote add origin https://github.com/user/repo.git

# View remotes
git remote -v

# Fetch changes
git fetch origin

# Pull changes
git pull origin main

# Push changes
git push origin feature/branch-name
```

### Syncing Fork
```bash
# Add upstream remote
git remote add upstream https://github.com/original/repo.git

# Fetch upstream
git fetch upstream

# Merge upstream changes
git checkout main
git merge upstream/main

# Push to your fork
git push origin main
```

## Best Practices

### Do's ✅

- **Commit often** - Small, focused commits
- **Write clear messages** - Explain what and why
- **Pull before push** - Avoid conflicts
- **Review own changes** - Before committing
- **Keep commits atomic** - One logical change per commit
- **Use branches** - Never commit directly to main
- **Test before committing** - Ensure tests pass
- **Update .gitignore** - Don't commit generated files

### Don'ts ❌

- **Don't commit secrets** - Use environment variables
- **Don't commit large files** - Use Git LFS if needed
- **Don't rewrite public history** - No force push to main
- **Don't commit incomplete work** - Use stash instead
- **Don't mix concerns** - Keep commits focused
- **Don't skip code review** - Even for small changes

## Useful Commands

### Checking Status
```bash
# View status
git status

# View diff
git diff

# View staged diff
git diff --staged

# View commit history
git log --oneline --graph --all
```

### Undoing Changes
```bash
# Discard unstaged changes
git checkout -- file.txt

# Unstage file
git reset HEAD file.txt

# Amend last commit
git commit --amend

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1
```

### Stashing
```bash
# Stash changes
git stash

# Stash with message
git stash save "WIP: feature implementation"

# List stashes
git stash list

# Apply stash
git stash apply

# Apply and remove stash
git stash pop

# Drop stash
git stash drop
```

### Cleaning
```bash
# Remove untracked files (dry run)
git clean -n

# Remove untracked files
git clean -f

# Remove untracked files and directories
git clean -fd
```

### Rebasing
```bash
# Rebase on main
git checkout feature/branch
git rebase main

# Interactive rebase (last 3 commits)
git rebase -i HEAD~3

# Continue after resolving conflicts
git rebase --continue

# Abort rebase
git rebase --abort
```

### Cherry-picking
```bash
# Cherry-pick specific commit
git cherry-pick abc123

# Cherry-pick without committing
git cherry-pick --no-commit abc123
```

## Handling Conflicts

### Resolving Merge Conflicts

1. **Identify conflicts**
```bash
git status
# Look for files marked as "both modified"
```

2. **Open conflicted files**
```
<<<<<<< HEAD
Current branch content
=======
Incoming branch content
>>>>>>> feature/branch
```

3. **Resolve conflicts**
- Edit the file to keep desired changes
- Remove conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)

4. **Mark as resolved**
```bash
git add file.txt
```

5. **Complete merge**
```bash
git commit
```

### Preventing Conflicts

- Pull frequently
- Communicate with team about file changes
- Keep branches short-lived
- Resolve conflicts promptly

## Tags and Releases

### Creating Tags
```bash
# Lightweight tag
git tag v1.0.0

# Annotated tag (recommended)
git tag -a v1.0.0 -m "Release version 1.0.0"

# Tag specific commit
git tag -a v1.0.0 abc123 -m "Release version 1.0.0"

# Push tags
git push origin v1.0.0
git push origin --tags  # All tags
```

### Semantic Versioning
```
MAJOR.MINOR.PATCH

1.0.0 - Initial release
1.1.0 - New features (backwards compatible)
1.1.1 - Bug fixes
2.0.0 - Breaking changes
```

### Viewing Tags
```bash
# List tags
git tag

# Show tag details
git show v1.0.0

# Checkout tag
git checkout v1.0.0
```

## Git Configuration

### User Configuration
```bash
# Set name and email
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# View configuration
git config --list
```

### Useful Aliases
```bash
# Add to ~/.gitconfig or use git config --global alias.name command

[alias]
  st = status
  co = checkout
  br = branch
  ci = commit
  unstage = reset HEAD --
  last = log -1 HEAD
  lg = log --oneline --graph --all --decorate
  amend = commit --amend --no-edit
```

### Editor
```bash
# Set default editor
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "vim"          # Vim
```

## .gitignore

### Common Patterns
```gitignore
# Dependencies
node_modules/
venv/
__pycache__/

# Build outputs
dist/
build/
*.pyc
*.class

# IDE
.vscode/
.idea/
*.swp

# OS
.DS_Store
Thumbs.db

# Environment
.env
.env.local

# Logs
*.log
logs/

# Temporary files
*.tmp
*.temp
```

### Global .gitignore
```bash
# Create global ignore file
touch ~/.gitignore_global

# Configure git to use it
git config --global core.excludesfile ~/.gitignore_global
```

## Resources

- [Git Documentation](https://git-scm.com/doc)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Git Flight Rules](https://github.com/k88hudson/git-flight-rules)
- [Learn Git Branching](https://learngitbranching.js.org/)
