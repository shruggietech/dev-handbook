# Python CLI Template

A professional command-line application template built with Python and Click. Features rich terminal output, configuration management, and comprehensive testing.

## Features

- ✅ Click framework for CLI
- ✅ Rich terminal output (colors, tables, progress bars)
- ✅ Configuration file support (YAML/TOML)
- ✅ Logging and debugging
- ✅ Argument parsing and validation
- ✅ Error handling
- ✅ Unit tests with pytest
- ✅ Packaging and distribution
- ✅ GitHub Actions CI/CD

## Quick Start

### Prerequisites

- Python 3.8 or later
- pip package manager

### Installation

```bash
# Download template
cp -r templates/python-cli my-cli
cd my-cli

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Install in development mode
pip install -e .
```

### Run the CLI

```bash
# Show help
my-cli --help

# Run example command
my-cli hello --name "World"

# With options
my-cli process --input data.txt --output result.txt --verbose
```

## Project Structure

```
python-cli/
├── src/
│   └── my_cli/
│       ├── __init__.py
│       ├── cli.py           # Main CLI entry point
│       ├── commands/        # Command modules
│       │   ├── __init__.py
│       │   ├── hello.py
│       │   └── process.py
│       ├── utils/           # Utility functions
│       │   ├── __init__.py
│       │   ├── config.py
│       │   └── logger.py
│       └── config.yaml      # Default configuration
├── tests/
│   ├── __init__.py
│   ├── test_cli.py
│   └── test_commands.py
├── docs/
│   └── usage.md
├── requirements.txt         # Dependencies
├── requirements-dev.txt     # Development dependencies
├── setup.py                 # Package configuration
├── pyproject.toml          # Modern Python config
├── .gitignore
└── README.md
```

## Commands

### Hello Command

```bash
# Basic usage
my-cli hello --name "Alice"

# With options
my-cli hello --name "Bob" --count 3 --enthusiastic
```

### Process Command

```bash
# Process a file
my-cli process --input data.txt --output result.txt

# With filters
my-cli process --input data.txt --filter "age > 25" --format json

# Dry run
my-cli process --input data.txt --dry-run
```

### Config Command

```bash
# Show current configuration
my-cli config show

# Set configuration value
my-cli config set api.url "https://api.example.com"

# Reset to defaults
my-cli config reset
```

## Configuration

### Config File

Create `~/.my-cli/config.yaml`:

```yaml
# General settings
debug: false
verbose: false

# Output settings
output:
  format: json
  color: true
  
# API settings
api:
  url: https://api.example.com
  timeout: 30
  
# Custom settings
custom:
  key: value
```

### Environment Variables

```bash
# Set via environment
export MY_CLI_DEBUG=true
export MY_CLI_API_URL=https://api.example.com

# Use in CLI
my-cli process --input data.txt
```

## Development

### Setup Development Environment

```bash
# Install development dependencies
pip install -r requirements-dev.txt

# Install pre-commit hooks
pre-commit install
```

### Adding a New Command

1. **Create command file** (`src/my_cli/commands/newcmd.py`):

```python
import click
from rich.console import Console

console = Console()

@click.command()
@click.option('--name', required=True, help='Name parameter')
@click.pass_context
def newcmd(ctx, name):
    """Description of the new command."""
    config = ctx.obj['config']
    logger = ctx.obj['logger']
    
    logger.info(f"Executing newcmd with name: {name}")
    console.print(f"[green]Hello, {name}![/green]")
```

2. **Register command** (`src/my_cli/cli.py`):

```python
from my_cli.commands.newcmd import newcmd

cli.add_command(newcmd)
```

3. **Add tests** (`tests/test_newcmd.py`):

```python
from click.testing import CliRunner
from my_cli.cli import cli

def test_newcmd():
    runner = CliRunner()
    result = runner.invoke(cli, ['newcmd', '--name', 'Test'])
    assert result.exit_code == 0
    assert 'Hello, Test!' in result.output
```

## Testing

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=my_cli tests/

# Run specific test
pytest tests/test_cli.py::test_hello_command

# Watch mode
pytest-watch

# Generate HTML coverage report
pytest --cov=my_cli --cov-report=html tests/
```

## Building and Distribution

### Build Package

```bash
# Build source and wheel distributions
python -m build

# Distributions will be in dist/
ls dist/
# my-cli-1.0.0.tar.gz
# my_cli-1.0.0-py3-none-any.whl
```

### Install from Source

```bash
# Install from local directory
pip install .

# Install in editable mode (for development)
pip install -e .

# Install from wheel
pip install dist/my_cli-1.0.0-py3-none-any.whl
```

### Publish to PyPI

```bash
# Install twine
pip install twine

# Upload to TestPyPI
twine upload --repository testpypi dist/*

# Upload to PyPI
twine upload dist/*

# Install from PyPI
pip install my-cli
```

## Code Style

### Linting

```bash
# Run pylint
pylint src/my_cli

# Run flake8
flake8 src/my_cli

# Run mypy (type checking)
mypy src/my_cli
```

### Formatting

```bash
# Format with black
black src/my_cli tests/

# Check formatting
black --check src/my_cli tests/

# Sort imports
isort src/my_cli tests/
```

## Rich Terminal Features

### Progress Bars

```python
from rich.progress import track
import time

def process_items(items):
    for item in track(items, description="Processing..."):
        # Process item
        time.sleep(0.1)
```

### Tables

```python
from rich.table import Table
from rich.console import Console

console = Console()
table = Table(title="Results")

table.add_column("Name", style="cyan")
table.add_column("Value", style="magenta")

table.add_row("Item 1", "100")
table.add_row("Item 2", "200")

console.print(table)
```

### Panels and Formatting

```python
from rich.panel import Panel
from rich.console import Console

console = Console()

console.print(Panel("Important Message", title="Info"))
console.print("[bold red]Error:[/bold red] Something went wrong")
console.print("[green]✓[/green] Success!")
```

## Logging

### Setup Logger

```python
import logging
from rich.logging import RichHandler

logging.basicConfig(
    level=logging.INFO,
    format="%(message)s",
    handlers=[RichHandler(rich_tracebacks=True)]
)

logger = logging.getLogger(__name__)

logger.info("Information message")
logger.warning("Warning message")
logger.error("Error message")
```

### Use in Commands

```python
@click.command()
@click.option('--verbose', is_flag=True)
@click.pass_context
def mycommand(ctx, verbose):
    logger = ctx.obj['logger']
    
    if verbose:
        logger.setLevel(logging.DEBUG)
    
    logger.debug("Debug information")
    logger.info("Processing started")
```

## Error Handling

### Custom Exceptions

```python
class MyCliError(Exception):
    """Base exception for CLI errors."""
    pass

class ConfigurationError(MyCliError):
    """Configuration related errors."""
    pass

class ProcessingError(MyCliError):
    """Processing related errors."""
    pass
```

### Handle Errors Gracefully

```python
import click
from rich.console import Console

console = Console()

@click.command()
def command():
    try:
        # Command logic
        result = process_data()
    except ConfigurationError as e:
        console.print(f"[red]Configuration Error:[/red] {e}")
        raise click.Abort()
    except Exception as e:
        console.print(f"[red]Unexpected Error:[/red] {e}")
        if ctx.obj.get('debug'):
            raise
        raise click.Abort()
```

## Configuration Management

### Load Configuration

```python
import yaml
from pathlib import Path

def load_config():
    config_path = Path.home() / '.my-cli' / 'config.yaml'
    
    if not config_path.exists():
        return get_default_config()
    
    with config_path.open() as f:
        return yaml.safe_load(f)

def get_default_config():
    return {
        'debug': False,
        'output': {'format': 'json'},
        'api': {'url': 'https://api.example.com'}
    }
```

### Save Configuration

```python
def save_config(config):
    config_path = Path.home() / '.my-cli' / 'config.yaml'
    config_path.parent.mkdir(exist_ok=True)
    
    with config_path.open('w') as f:
        yaml.dump(config, f, default_flow_style=False)
```

## Examples

### File Processing CLI

```python
@click.command()
@click.argument('input_file', type=click.Path(exists=True))
@click.option('--output', '-o', type=click.Path())
@click.option('--format', type=click.Choice(['json', 'csv', 'xml']))
def process(input_file, output, format):
    """Process input file and generate output."""
    from rich.progress import Progress
    
    with Progress() as progress:
        task = progress.add_task("Processing...", total=100)
        
        # Process file
        data = read_file(input_file)
        progress.update(task, advance=50)
        
        result = transform_data(data)
        progress.update(task, advance=30)
        
        write_file(output, result, format)
        progress.update(task, advance=20)
    
    click.echo(f"Processed {input_file} -> {output}")
```

### Interactive Prompts

```python
@click.command()
def setup():
    """Interactive setup wizard."""
    name = click.prompt('Enter your name')
    email = click.prompt('Enter your email')
    
    if click.confirm('Do you want to enable notifications?'):
        notifications = True
    else:
        notifications = False
    
    save_config({
        'user': {'name': name, 'email': email},
        'notifications': notifications
    })
    
    click.echo('Setup complete!')
```

## Troubleshooting

### Command Not Found
```bash
# Ensure package is installed
pip list | grep my-cli

# Reinstall
pip install -e .
```

### Import Errors
```bash
# Verify installation
python -c "import my_cli; print(my_cli.__version__)"

# Check PYTHONPATH
echo $PYTHONPATH
```

### Configuration Issues
```bash
# Check config location
my-cli config show

# Reset to defaults
my-cli config reset
```

## Resources

- [Click Documentation](https://click.palletsprojects.com/)
- [Rich Documentation](https://rich.readthedocs.io/)
- [Python Packaging Guide](https://packaging.python.org/)
- [pytest Documentation](https://docs.pytest.org/)

## License

MIT License - see [LICENSE](../../LICENSE) for details.
