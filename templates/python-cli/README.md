# Python CLI Template

A professional command-line application template built with Python and Click.

## Features

- Click framework for CLI
- Rich terminal output
- Configuration management
- Argument parsing and validation
- Error handling
- Example commands

## Quick Start

### Prerequisites

- Python 3.8 or later
- pip package manager

### Installation

```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Install in development mode
pip install -e .
```

### Usage

```bash
# Show help
my-cli --help

# Run example command
my-cli hello --name "World"

# Process command
my-cli process --input data.txt
```

## Project Structure

```
python-cli/
├── src/
│   └── my_cli/
│       ├── __init__.py
│       ├── cli.py          # Main CLI entry
│       └── commands/       # Command modules
├── requirements.txt
├── setup.py
└── README.md
```

## Available Commands

### hello
Greet the user.

```bash
my-cli hello --name "Alice"
```

### process
Process files or data.

```bash
my-cli process --input file.txt --output result.txt
```

## Configuration

Create `~/.my-cli/config.yaml`:

```yaml
debug: false
verbose: false
output:
  format: json
```

## Development

```bash
# Install development dependencies
pip install -r requirements-dev.txt

# Run tests
pytest

# Run linter
pylint src/my_cli

# Format code
black src/my_cli
```

## Building

```bash
# Build package
python -m build

# Install from wheel
pip install dist/my_cli-1.0.0-py3-none-any.whl
```

## License

MIT License - see [LICENSE](../../LICENSE) for details.
