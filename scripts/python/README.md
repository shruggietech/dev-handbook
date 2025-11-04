# Python Scripts

This directory contains cross-platform Python utilities for automation and development tasks.

## Available Scripts

### Setup and Configuration
- `setup_dev_environment.py` - Configure development environment
- `configure_git.py` - Interactive Git configuration

### Utilities
- `system_info.py` - Cross-platform system information
- `file_organizer.py` - Organize files by type or date

### Git Automation
- `git_bulk_operations.py` - Batch operations on repositories
- `git_stats.py` - Generate repository statistics

## Prerequisites

- Python 3.8 or later
- pip package manager

## Setup

```bash
# Create virtual environment (recommended)
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

## Usage

```bash
# Run a script
python script_name.py

# Get help
python script_name.py --help

# Run with arguments
python script_name.py --argument value
```

## Common Dependencies

Install these packages for most scripts:

```bash
pip install click rich pyyaml requests psutil gitpython
```

## Best Practices

- Use virtual environments
- Follow PEP 8 style guide
- Include type hints
- Write docstrings
- Handle errors properly

## Contributing

When adding new scripts:
1. Follow Python best practices
2. Include comprehensive docstrings
3. Add type hints
4. Include usage examples
5. Add to requirements.txt if needed
6. Update this README

## Resources

- [Python Documentation](https://docs.python.org/3/)
- [PEP 8 Style Guide](https://pep8.org/)
- [Click Documentation](https://click.palletsprojects.com/)
- [Rich Documentation](https://rich.readthedocs.io/)
