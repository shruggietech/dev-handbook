# Code Standards

This document outlines the code standards and conventions used across ShruggieTech projects. Following these guidelines ensures consistency, maintainability, and quality.

## General Principles

### Code Quality
- Write clean, readable, and self-documenting code
- Follow the principle of least surprise
- Keep functions/methods small and focused
- Use meaningful names for variables, functions, and classes
- Avoid premature optimization
- Write code for humans, not machines

### DRY (Don't Repeat Yourself)
- Extract repeated code into functions
- Use configuration files for repeated values
- Create reusable components and modules

### SOLID Principles
- **S**ingle Responsibility Principle
- **O**pen/Closed Principle
- **L**iskov Substitution Principle
- **I**nterface Segregation Principle
- **D**ependency Inversion Principle

## Language-Specific Standards

### JavaScript/TypeScript

#### Naming Conventions
```javascript
// Variables and functions: camelCase
const userName = 'John';
function getUserData() {}

// Constants: UPPER_SNAKE_CASE
const MAX_RETRY_COUNT = 3;

// Classes: PascalCase
class UserService {}

// Private members: prefix with _
class MyClass {
  _privateMethod() {}
}
```

#### Code Style
```javascript
// Use const by default, let when needed
const config = { port: 3000 };
let counter = 0;

// Use arrow functions for callbacks
array.map(item => item.value);

// Use template literals
const message = `Hello, ${name}!`;

// Destructuring
const { name, email } = user;

// Default parameters
function greet(name = 'Guest') {}

// Async/await over promises
async function fetchData() {
  try {
    const data = await api.get('/users');
    return data;
  } catch (error) {
    console.error(error);
  }
}
```

#### Tools
- **ESLint**: Linting
- **Prettier**: Code formatting
- **TypeScript**: Type safety
- **Jest**: Testing

### Python

#### Naming Conventions
```python
# Variables and functions: snake_case
user_name = 'John'
def get_user_data():
    pass

# Constants: UPPER_SNAKE_CASE
MAX_RETRY_COUNT = 3

# Classes: PascalCase
class UserService:
    pass

# Private members: prefix with _
class MyClass:
    def _private_method(self):
        pass
```

#### Code Style
```python
# Follow PEP 8
# Maximum line length: 88 characters (Black default)

# Type hints
def greet(name: str) -> str:
    return f"Hello, {name}!"

# List comprehensions (when readable)
squares = [x**2 for x in range(10)]

# Context managers
with open('file.txt') as f:
    content = f.read()

# Docstrings
def calculate_total(items: list[dict]) -> float:
    """
    Calculate total price of items.
    
    Args:
        items: List of item dictionaries with 'price' key
        
    Returns:
        Total price as float
        
    Raises:
        ValueError: If items list is empty
    """
    if not items:
        raise ValueError("Items list cannot be empty")
    return sum(item['price'] for item in items)
```

#### Tools
- **Black**: Code formatting
- **Pylint/Flake8**: Linting
- **mypy**: Type checking
- **pytest**: Testing

### PowerShell

#### Naming Conventions
```powershell
# Functions: Verb-Noun (approved verbs)
function Get-UserData {}
function Set-Configuration {}
function New-Resource {}

# Variables: camelCase or PascalCase
$userName = "John"
$MaxRetryCount = 3

# Parameters: PascalCase
param(
    [Parameter(Mandatory = $true)]
    [string]$UserName
)
```

#### Code Style
```powershell
# Comment-based help
<#
.SYNOPSIS
    Brief description

.DESCRIPTION
    Detailed description

.PARAMETER Name
    Parameter description

.EXAMPLE
    Get-UserData -UserName "john"
#>

# Use approved verbs
Get-Verb

# Error handling
try {
    $result = Get-Item $Path
} catch {
    Write-Error "Failed to get item: $_"
}

# Pipeline support
function Get-FilteredUsers {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [string]$Name
    )
    
    process {
        # Process each pipeline item
    }
}
```

#### Tools
- **PSScriptAnalyzer**: Linting
- **Pester**: Testing
- **PowerShell FormatterSettings**: Formatting

### Bash

#### Naming Conventions
```bash
# Variables: snake_case
user_name="John"

# Constants: UPPER_SNAKE_CASE
readonly MAX_RETRY_COUNT=3

# Functions: snake_case
get_user_data() {
    local user_id=$1
    # function body
}
```

#### Code Style
```bash
# Use strict mode
set -euo pipefail

# Use local variables
function my_function() {
    local my_var="value"
}

# Quote variables
echo "${user_name}"

# Use [[ ]] for conditionals
if [[ -f "${file}" ]]; then
    echo "File exists"
fi

# Use $() over backticks
current_date=$(date +%Y-%m-%d)

# Function documentation
# get_user_data - Retrieves user data
#
# Arguments:
#   $1 - User ID
# Returns:
#   User data as JSON
get_user_data() {
    local user_id=$1
    curl -s "api/users/${user_id}"
}
```

#### Tools
- **ShellCheck**: Linting
- **shfmt**: Formatting
- **bats**: Testing

## Comments and Documentation

### When to Comment
✅ **Do comment:**
- Complex algorithms or business logic
- Workarounds or non-obvious solutions
- API documentation (functions, classes)
- TODOs and FIXMEs
- Assumptions and constraints

❌ **Don't comment:**
- Obvious code
- Redundant information
- Commented-out code (use version control)

### Comment Style
```javascript
// Single-line comment for simple notes

/*
 * Multi-line comment for longer explanations
 * that span multiple lines
 */

/**
 * JSDoc/Docstring for API documentation
 * @param {string} name - User name
 * @returns {Object} User object
 */
function getUser(name) {}
```

## Code Review Standards

### Before Submitting
- [ ] Code follows style guidelines
- [ ] All tests pass
- [ ] No linting errors
- [ ] Documentation updated
- [ ] Self-review completed
- [ ] Commit messages are clear

### Review Checklist
- [ ] Code is readable and maintainable
- [ ] Logic is correct and efficient
- [ ] Error handling is appropriate
- [ ] Tests cover new functionality
- [ ] No security vulnerabilities
- [ ] No hardcoded secrets or credentials
- [ ] Documentation is accurate

### Review Comments
- Be constructive and respectful
- Explain the "why" not just "what"
- Suggest alternatives
- Distinguish between requirements and suggestions
- Approve when satisfied, not perfect

## Testing Standards

### Test Coverage
- Aim for 80%+ code coverage
- Focus on critical paths
- Test edge cases and error conditions
- Test public APIs, not internals

### Test Structure
```javascript
// Arrange-Act-Assert pattern
describe('UserService', () => {
  it('should create a new user', () => {
    // Arrange
    const userData = { name: 'John', email: 'john@example.com' };
    
    // Act
    const user = userService.create(userData);
    
    // Assert
    expect(user.name).toBe('John');
    expect(user.email).toBe('john@example.com');
  });
});
```

### Test Naming
```python
def test_user_creation_with_valid_data():
    """Test that user is created successfully with valid data."""
    pass

def test_user_creation_with_invalid_email_raises_error():
    """Test that creating user with invalid email raises ValueError."""
    pass
```

## File Organization

### Directory Structure
```
project/
├── src/              # Source code
├── tests/            # Test files
├── docs/             # Documentation
├── scripts/          # Build/utility scripts
├── config/           # Configuration files
├── .github/          # GitHub workflows
├── .gitignore
├── README.md
└── LICENSE
```

### File Naming
- Use lowercase with hyphens for files: `user-service.js`
- Or snake_case: `user_service.py`
- Match file names to primary export/class
- Use descriptive names

## Error Handling

### Guidelines
- Always handle errors
- Fail fast and explicitly
- Provide meaningful error messages
- Log errors appropriately
- Don't swallow exceptions silently

### Examples
```javascript
// Bad
try {
  doSomething();
} catch (e) {}

// Good
try {
  doSomething();
} catch (error) {
  logger.error('Failed to do something:', error);
  throw new ApplicationError('Operation failed', { cause: error });
}
```

## Security Best Practices

### Never
- ❌ Hardcode credentials or secrets
- ❌ Commit secrets to version control
- ❌ Use weak encryption
- ❌ Trust user input without validation
- ❌ Expose sensitive data in logs or errors

### Always
- ✅ Use environment variables for secrets
- ✅ Validate and sanitize inputs
- ✅ Use parameterized queries (SQL)
- ✅ Keep dependencies updated
- ✅ Follow principle of least privilege
- ✅ Use HTTPS/TLS in production

## Performance Considerations

### Guidelines
- Measure before optimizing
- Optimize algorithms before code
- Consider time and space complexity
- Use appropriate data structures
- Cache when beneficial
- Lazy load when possible
- Minimize network requests
- Use database indexes

### Examples
```javascript
// Bad - O(n²)
for (let i = 0; i < array1.length; i++) {
  for (let j = 0; j < array2.length; j++) {
    if (array1[i] === array2[j]) {
      // ...
    }
  }
}

// Good - O(n)
const set = new Set(array2);
for (const item of array1) {
  if (set.has(item)) {
    // ...
  }
}
```

## Version Control

### Commit Messages
```
Type: Brief description (50 chars max)

Detailed explanation of what and why (not how).
Wrap at 72 characters.

Fixes #123
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Code style (formatting)
- `refactor`: Code refactoring
- `test`: Tests
- `chore`: Maintenance

### Branch Naming
```
feature/user-authentication
bugfix/login-error
hotfix/security-patch
docs/api-documentation
```

## Resources

- [Clean Code by Robert C. Martin](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882)
- [JavaScript Style Guide by Airbnb](https://github.com/airbnb/javascript)
- [PEP 8 - Python Style Guide](https://pep8.org/)
- [Google Style Guides](https://google.github.io/styleguide/)
