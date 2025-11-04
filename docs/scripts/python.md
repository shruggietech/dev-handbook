# Python Scripts

Cross-platform Python utilities for automation and development tasks.

## Available Scripts

### Setup and Configuration

#### `setup_dev_environment.py`
Configures development environment with Python tools.

**Usage**:
```bash
python setup_dev_environment.py [--install-packages] [--configure-venv]
```

**Features**:
- Creates virtual environments
- Installs common packages
- Configures IDE settings
- Sets up pre-commit hooks

#### `configure_git.py`
Interactive Git configuration tool.

**Usage**:
```bash
python configure_git.py
```

### Utilities

#### `system_info.py`
Cross-platform system information collector.

**Usage**:
```bash
python system_info.py [--format json|yaml|table]
```

**Output**:
```json
{
  "os": "Linux",
  "platform": "Ubuntu 22.04",
  "python_version": "3.11.0",
  "cpu_count": 8,
  "memory_total": "16 GB"
}
```

#### `file_organizer.py`
Organizes files by type, date, or custom rules.

**Usage**:
```bash
python file_organizer.py --source ~/Downloads --dest ~/Organized --by-type
```

**Options**:
- `--by-type`: Organize by file extension
- `--by-date`: Organize by modification date
- `--dry-run`: Preview without moving files

### Git Automation

#### `git_bulk_operations.py`
Performs batch operations on multiple repositories.

**Usage**:
```bash
python git_bulk_operations.py --action pull --repos-dir ~/projects
```

**Actions**:
- `pull`: Pull latest changes
- `status`: Check repository status
- `branch`: List branches
- `cleanup`: Remove merged branches

#### `git_stats.py`
Generates Git repository statistics.

**Usage**:
```bash
python git_stats.py --repo . --output report.html
```

### API and Web

#### `api_tester.py`
Tests REST APIs with configurable requests.

**Usage**:
```bash
python api_tester.py --config api-tests.yaml
```

**Config Example**:
```yaml
tests:
  - name: Get Users
    method: GET
    url: https://api.example.com/users
    expected_status: 200
```

#### `web_scraper.py`
Simple web scraping utility.

**Usage**:
```bash
python web_scraper.py --url https://example.com --selector ".article" --output data.json
```

### Data Processing

#### `csv_processor.py`
Processes and transforms CSV files.

**Usage**:
```bash
python csv_processor.py --input data.csv --output processed.csv --filter "age > 25"
```

#### `json_formatter.py`
Formats and validates JSON files.

**Usage**:
```bash
python json_formatter.py --input data.json --indent 2 --sort-keys
```

## Installation

### Requirements
- Python 3.8 or later
- pip package manager

### Setup
```bash
# Clone the repository
git clone https://github.com/shruggietech/dev-handbook.git
cd dev-handbook/scripts/python

# Create virtual environment (recommended)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### Dependencies

Common packages used across scripts:

```txt
# requirements.txt
requests>=2.28.0
click>=8.0.0
pyyaml>=6.0
rich>=13.0.0
gitpython>=3.1.0
psutil>=5.9.0
```

## Script Structure

All scripts follow this standard structure:

```python
#!/usr/bin/env python3
"""
Script description and purpose.

Usage:
    python script_name.py [options]
"""

import argparse
import logging
import sys
from pathlib import Path

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--verbose', '-v', action='store_true')
    
    args = parser.parse_args()
    
    if args.verbose:
        logger.setLevel(logging.DEBUG)
    
    # Script logic here
    logger.info("Script execution started")


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        logger.info("Script interrupted by user")
        sys.exit(1)
    except Exception as e:
        logger.error(f"Error: {e}", exc_info=True)
        sys.exit(1)
```

## Common Patterns

### Argument Parsing with Click
```python
import click

@click.command()
@click.option('--name', '-n', required=True, help='Your name')
@click.option('--count', '-c', default=1, help='Number of times')
@click.option('--verbose', '-v', is_flag=True, help='Verbose output')
def main(name, count, verbose):
    """Example CLI tool."""
    for _ in range(count):
        click.echo(f'Hello, {name}!')

if __name__ == '__main__':
    main()
```

### Configuration Management
```python
import yaml
from pathlib import Path

def load_config(config_path: str) -> dict:
    """Load configuration from YAML file."""
    path = Path(config_path)
    if not path.exists():
        raise FileNotFoundError(f"Config not found: {config_path}")
    
    with path.open() as f:
        return yaml.safe_load(f)

config = load_config('config.yaml')
```

### Error Handling
```python
class ScriptError(Exception):
    """Custom exception for script errors."""
    pass

def process_file(filepath: str):
    """Process a file with error handling."""
    try:
        with open(filepath) as f:
            data = f.read()
        return data
    except FileNotFoundError:
        logger.error(f"File not found: {filepath}")
        raise ScriptError(f"Cannot process {filepath}")
    except PermissionError:
        logger.error(f"Permission denied: {filepath}")
        raise ScriptError(f"Cannot access {filepath}")
```

### Progress Bars
```python
from rich.progress import track
from time import sleep

def process_items(items):
    """Process items with progress bar."""
    for item in track(items, description="Processing..."):
        # Process item
        sleep(0.1)
```

## Environment Variables

Use environment variables for configuration:

```python
import os
from pathlib import Path

# Get environment variable with default
API_KEY = os.getenv('SHRUGGIE_API_KEY', 'default-key')
API_URL = os.getenv('SHRUGGIE_API_URL', 'https://api.example.com')

# Load from .env file
from dotenv import load_dotenv
load_dotenv()

# Or specify path
env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)
```

## Best Practices

### Code Style
- Follow [PEP 8](https://pep8.org/) style guide
- Use type hints for function parameters
- Write docstrings for modules, classes, and functions
- Use f-strings for formatting
- Keep functions small and focused

### Example with Best Practices
```python
#!/usr/bin/env python3
"""Module for processing user data."""

from typing import List, Dict, Optional
import logging

logger = logging.getLogger(__name__)


def process_users(
    users: List[Dict[str, str]], 
    filter_active: bool = True
) -> List[Dict[str, str]]:
    """
    Process list of users with optional filtering.
    
    Args:
        users: List of user dictionaries
        filter_active: Whether to filter for active users only
        
    Returns:
        Processed list of users
        
    Raises:
        ValueError: If users list is empty
    """
    if not users:
        raise ValueError("Users list cannot be empty")
    
    result = []
    for user in users:
        if filter_active and not user.get('active', False):
            continue
        result.append(user)
    
    logger.info(f"Processed {len(result)} users")
    return result
```

### Testing
```python
# test_script.py
import unittest
from script import process_users

class TestProcessUsers(unittest.TestCase):
    def test_filter_active_users(self):
        users = [
            {'name': 'Alice', 'active': True},
            {'name': 'Bob', 'active': False},
        ]
        result = process_users(users, filter_active=True)
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]['name'], 'Alice')

if __name__ == '__main__':
    unittest.main()
```

## Virtual Environments

Always use virtual environments:

```bash
# Create virtual environment
python -m venv venv

# Activate (Linux/macOS)
source venv/bin/activate

# Activate (Windows)
venv\Scripts\activate

# Install packages
pip install -r requirements.txt

# Freeze dependencies
pip freeze > requirements.txt

# Deactivate
deactivate
```

## Common Tools

### Useful Libraries
- **click**: CLI creation
- **rich**: Beautiful terminal output
- **requests**: HTTP requests
- **gitpython**: Git operations
- **pyyaml**: YAML parsing
- **python-dotenv**: Environment variables
- **psutil**: System information
- **pandas**: Data processing
- **black**: Code formatting
- **pylint**: Linting

### Development Tools
```bash
# Code formatting
black script.py

# Linting
pylint script.py

# Type checking
mypy script.py

# Running tests
pytest tests/

# Coverage
pytest --cov=. tests/
```

## Debugging

### Using pdb
```python
import pdb

def buggy_function():
    x = 10
    pdb.set_trace()  # Debugger breakpoint
    y = x * 2
    return y
```

### Logging Levels
```python
import logging

logger = logging.getLogger(__name__)

logger.debug("Detailed information for debugging")
logger.info("General informational messages")
logger.warning("Warning messages")
logger.error("Error messages")
logger.critical("Critical issues")
```

## Resources

- [Python Documentation](https://docs.python.org/3/)
- [PEP 8 Style Guide](https://pep8.org/)
- [Python Package Index (PyPI)](https://pypi.org/)
- [Real Python Tutorials](https://realpython.com/)
- [Python Best Practices](https://docs.python-guide.org/)
