# Contributing to ShruggieTech Dev Handbook

Thank you for your interest in contributing to the ShruggieTech Dev Handbook! This document provides guidelines for contributing to this project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Getting Started](#getting-started)
- [Contribution Workflow](#contribution-workflow)
- [Style Guidelines](#style-guidelines)
- [Commit Messages](#commit-messages)
- [Pull Requests](#pull-requests)

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive environment for everyone. We expect all contributors to:

- Be respectful and professional
- Welcome newcomers and help them learn
- Accept constructive criticism gracefully
- Focus on what's best for the community
- Show empathy towards others

### Unacceptable Behavior

- Harassment or discriminatory language
- Personal attacks or trolling
- Publishing others' private information
- Inappropriate sexual content
- Other conduct that could be considered unprofessional

## How Can I Contribute?

### Reporting Bugs

Before submitting a bug report:
- Check existing issues to avoid duplicates
- Verify the bug in the latest version
- Collect relevant information (OS, versions, steps to reproduce)

**Bug Report Template:**
```markdown
## Description
Brief description of the bug

## Steps to Reproduce
1. Step one
2. Step two
3. Step three

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- OS: [e.g., Windows 11, macOS 13, Ubuntu 22.04]
- Version: [e.g., v1.2.3]
- Browser: [if applicable]

## Additional Context
Screenshots, logs, or other relevant information
```

### Suggesting Enhancements

Enhancement suggestions are welcome! Please:
- Check if the enhancement has already been suggested
- Provide a clear and detailed explanation
- Explain why this enhancement would be useful
- Include examples of how it would work

**Enhancement Template:**
```markdown
## Feature Description
Clear description of the proposed feature

## Problem It Solves
What problem does this solve?

## Proposed Solution
How should this work?

## Alternatives Considered
Other approaches you've considered

## Additional Context
Mockups, examples, or references
```

### Contributing Documentation

Documentation improvements are always appreciated:
- Fix typos and grammatical errors
- Clarify confusing sections
- Add missing information
- Create new guides or tutorials
- Update outdated content

### Contributing Code

Code contributions include:
- New scripts or templates
- Bug fixes
- Performance improvements
- New features
- Test improvements

### Contributing Scripts

When adding new scripts:
- Follow the appropriate language style guide
- Include comprehensive documentation
- Add usage examples
- Include error handling
- Add tests if applicable

### Contributing Templates

When adding new templates:
- Ensure complete, working project
- Include comprehensive README
- Follow best practices for the technology
- Include example configuration
- Add to docs/templates/

## Getting Started

### 1. Fork the Repository

Click the "Fork" button on GitHub to create your copy.

### 2. Clone Your Fork

```bash
git clone https://github.com/YOUR-USERNAME/dev-handbook.git
cd dev-handbook
```

### 3. Add Upstream Remote

```bash
git remote add upstream https://github.com/shruggietech/dev-handbook.git
```

### 4. Create a Branch

```bash
git checkout -b feature/your-feature-name
```

## Contribution Workflow

### 1. Keep Your Fork Updated

```bash
git fetch upstream
git checkout main
git merge upstream/main
```

### 2. Make Your Changes

- Follow the [Code Standards](docs/best-practices/code-standards.md)
- Test your changes thoroughly
- Update documentation as needed

### 3. Commit Your Changes

Follow our [commit message guidelines](#commit-messages):

```bash
git add .
git commit -m "feat: add new feature"
```

### 4. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

### 5. Create Pull Request

- Go to the original repository on GitHub
- Click "New Pull Request"
- Select your fork and branch
- Fill out the PR template
- Submit the pull request

## Style Guidelines

### Documentation

- Use Markdown for all documentation
- Follow consistent formatting
- Include code examples where helpful
- Keep line length reasonable (80-100 characters)
- Use proper heading hierarchy
- Include table of contents for long documents

### Code

Follow language-specific guidelines:
- **JavaScript/TypeScript**: [Airbnb Style Guide](https://github.com/airbnb/javascript)
- **Python**: [PEP 8](https://pep8.org/)
- **PowerShell**: [PowerShell Practice and Style](https://poshcode.gitbook.io/powershell-practice-and-style/)
- **Bash**: [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)

### File Organization

```
dev-handbook/
├── docs/                    # Documentation
│   ├── getting-started/
│   ├── scripts/
│   ├── templates/
│   └── best-practices/
├── scripts/                 # Scripts
│   ├── powershell/
│   ├── bash/
│   └── python/
└── templates/              # Templates
    ├── nodejs-api/
    ├── python-cli/
    └── static-website/
```

## Commit Messages

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Examples

```
feat(scripts): add git-sync-all PowerShell script

Add PowerShell script to sync multiple Git repositories.
Includes error handling and verbose output option.

Closes #123
```

```
docs(templates): update Node.js API template documentation

- Add deployment section
- Update environment variables
- Fix code examples
```

```
fix(scripts): resolve path handling in cleanup script

Fix issue where script failed with spaces in directory names.
Now properly quotes all path variables.

Fixes #456
```

## Pull Requests

### PR Title

Use the same format as commit messages:
```
feat: add new PowerShell script for system info
```

### PR Description Template

```markdown
## Description
Brief description of changes made

## Type of Change
- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Template addition/update
- [ ] Script addition/update

## Changes Made
- Change 1
- Change 2
- Change 3

## Testing Done
Describe how you tested your changes

## Checklist
- [ ] My code follows the style guidelines
- [ ] I have performed a self-review
- [ ] I have commented my code where necessary
- [ ] I have updated the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests (if applicable)
- [ ] All tests pass (if applicable)

## Related Issues
Fixes #(issue number)
Related to #(issue number)

## Screenshots (if applicable)
Add screenshots to help explain your changes
```

### Review Process

1. **Automated Checks**: Wait for CI/CD to complete
2. **Code Review**: Address reviewer feedback
3. **Update as Needed**: Make requested changes
4. **Approval**: Get approval from maintainers
5. **Merge**: Maintainers will merge when ready

### After Merge

- Delete your branch
- Update your local main branch
- Close any related issues

## Questions?

If you have questions:
- Check existing documentation
- Search existing issues
- Ask in issue comments
- Create a new discussion

## Recognition

Contributors will be:
- Listed in the project contributors
- Credited in release notes for significant contributions
- Appreciated for all contributions, large and small!

## License

By contributing, you agree that your contributions will be licensed under the same MIT License that covers this project.

---

Thank you for contributing to the ShruggieTech Dev Handbook! 🎉
