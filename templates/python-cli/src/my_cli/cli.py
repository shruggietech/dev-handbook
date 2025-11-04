#!/usr/bin/env python3
"""
Main CLI entry point.
"""

import click
from rich.console import Console

console = Console()


@click.group()
@click.version_option()
@click.option('--verbose', '-v', is_flag=True, help='Enable verbose output')
@click.pass_context
def cli(ctx, verbose):
    """My CLI - A professional command-line application."""
    ctx.ensure_object(dict)
    ctx.obj['verbose'] = verbose


@cli.command()
@click.option('--name', '-n', default='World', help='Name to greet')
@click.pass_context
def hello(ctx, name):
    """Greet someone."""
    if ctx.obj.get('verbose'):
        console.print(f"[dim]Verbose mode enabled[/dim]")
    
    console.print(f"[bold green]Hello, {name}![/bold green]")


@cli.command()
@click.option('--input', '-i', required=True, help='Input file')
@click.option('--output', '-o', help='Output file')
@click.pass_context
def process(ctx, input, output):
    """Process a file."""
    if ctx.obj.get('verbose'):
        console.print(f"[dim]Processing {input}...[/dim]")
    
    try:
        with open(input, 'r') as f:
            content = f.read()
        
        # Example processing
        result = content.upper()
        
        if output:
            with open(output, 'w') as f:
                f.write(result)
            console.print(f"[green]✓[/green] Processed {input} -> {output}")
        else:
            console.print(result)
    
    except FileNotFoundError:
        console.print(f"[red]Error:[/red] File not found: {input}")
        raise click.Abort()
    except Exception as e:
        console.print(f"[red]Error:[/red] {e}")
        raise click.Abort()


if __name__ == '__main__':
    cli()
