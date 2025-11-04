#!/usr/bin/env python3
"""
System Information Collector

Collects and displays comprehensive system information across platforms.

Usage:
    python system_info.py [--format json|yaml|table]
    python system_info.py --output report.json

Examples:
    python system_info.py
    python system_info.py --format json
    python system_info.py --format yaml --output system.yaml
"""

import argparse
import json
import logging
import platform
import sys
from datetime import datetime
from pathlib import Path
from typing import Dict, Any

try:
    import psutil
except ImportError:
    print("Error: psutil module is required. Install with: pip install psutil")
    sys.exit(1)

try:
    from rich.console import Console
    from rich.table import Table
    RICH_AVAILABLE = True
except ImportError:
    RICH_AVAILABLE = False

try:
    import yaml
    YAML_AVAILABLE = True
except ImportError:
    YAML_AVAILABLE = False

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


def get_system_info() -> Dict[str, Any]:
    """
    Collect comprehensive system information.
    
    Returns:
        Dictionary containing system information
    """
    info = {
        'timestamp': datetime.now().isoformat(),
        'system': {},
        'cpu': {},
        'memory': {},
        'disk': [],
        'network': []
    }
    
    # System information
    info['system'] = {
        'hostname': platform.node(),
        'platform': platform.system(),
        'platform_release': platform.release(),
        'platform_version': platform.version(),
        'architecture': platform.machine(),
        'processor': platform.processor(),
        'python_version': platform.python_version()
    }
    
    # CPU information
    info['cpu'] = {
        'physical_cores': psutil.cpu_count(logical=False),
        'total_cores': psutil.cpu_count(logical=True),
        'max_frequency': f"{psutil.cpu_freq().max:.2f} MHz" if psutil.cpu_freq() else "N/A",
        'current_frequency': f"{psutil.cpu_freq().current:.2f} MHz" if psutil.cpu_freq() else "N/A",
        'cpu_usage_percent': psutil.cpu_percent(interval=1)
    }
    
    # Memory information
    memory = psutil.virtual_memory()
    info['memory'] = {
        'total_gb': round(memory.total / (1024 ** 3), 2),
        'available_gb': round(memory.available / (1024 ** 3), 2),
        'used_gb': round(memory.used / (1024 ** 3), 2),
        'percent_used': memory.percent
    }
    
    # Disk information
    for partition in psutil.disk_partitions():
        try:
            usage = psutil.disk_usage(partition.mountpoint)
            info['disk'].append({
                'device': partition.device,
                'mountpoint': partition.mountpoint,
                'fstype': partition.fstype,
                'total_gb': round(usage.total / (1024 ** 3), 2),
                'used_gb': round(usage.used / (1024 ** 3), 2),
                'free_gb': round(usage.free / (1024 ** 3), 2),
                'percent_used': usage.percent
            })
        except PermissionError:
            continue
    
    # Network information
    for interface, addresses in psutil.net_if_addrs().items():
        for addr in addresses:
            if addr.family == 2:  # IPv4
                info['network'].append({
                    'interface': interface,
                    'address': addr.address,
                    'netmask': addr.netmask
                })
    
    return info


def format_table(info: Dict[str, Any]) -> None:
    """
    Display information as formatted table using Rich.
    
    Args:
        info: System information dictionary
    """
    if not RICH_AVAILABLE:
        print("Rich library not available. Install with: pip install rich")
        format_text(info)
        return
    
    console = Console()
    
    # System Information Table
    console.print("\n[bold yellow]=== SYSTEM INFORMATION ===[/bold yellow]")
    console.print(f"Hostname: {info['system']['hostname']}")
    console.print(f"Timestamp: {info['timestamp']}\n")
    
    system_table = Table(title="System Details")
    system_table.add_column("Property", style="cyan")
    system_table.add_column("Value", style="white")
    
    for key, value in info['system'].items():
        if key != 'hostname':
            system_table.add_row(key.replace('_', ' ').title(), str(value))
    
    console.print(system_table)
    
    # CPU Information Table
    cpu_table = Table(title="\nCPU Information")
    cpu_table.add_column("Property", style="cyan")
    cpu_table.add_column("Value", style="white")
    
    for key, value in info['cpu'].items():
        cpu_table.add_row(key.replace('_', ' ').title(), str(value))
    
    console.print(cpu_table)
    
    # Memory Information Table
    memory_table = Table(title="\nMemory Information")
    memory_table.add_column("Property", style="cyan")
    memory_table.add_column("Value", style="white")
    
    for key, value in info['memory'].items():
        memory_table.add_row(key.replace('_', ' ').title(), str(value))
    
    console.print(memory_table)
    
    # Disk Information Table
    disk_table = Table(title="\nDisk Information")
    disk_table.add_column("Device", style="cyan")
    disk_table.add_column("Mount", style="white")
    disk_table.add_column("Total GB", justify="right")
    disk_table.add_column("Used GB", justify="right")
    disk_table.add_column("Free GB", justify="right")
    disk_table.add_column("Used %", justify="right")
    
    for disk in info['disk']:
        disk_table.add_row(
            disk['device'],
            disk['mountpoint'],
            str(disk['total_gb']),
            str(disk['used_gb']),
            str(disk['free_gb']),
            f"{disk['percent_used']}%"
        )
    
    console.print(disk_table)


def format_text(info: Dict[str, Any]) -> None:
    """
    Display information as plain text.
    
    Args:
        info: System information dictionary
    """
    print("\n=== SYSTEM INFORMATION ===")
    print(f"Hostname: {info['system']['hostname']}")
    print(f"Timestamp: {info['timestamp']}\n")
    
    print("--- System ---")
    for key, value in info['system'].items():
        print(f"{key.replace('_', ' ').title()}: {value}")
    
    print("\n--- CPU ---")
    for key, value in info['cpu'].items():
        print(f"{key.replace('_', ' ').title()}: {value}")
    
    print("\n--- Memory ---")
    for key, value in info['memory'].items():
        print(f"{key.replace('_', ' ').title()}: {value}")
    
    print("\n--- Disks ---")
    for disk in info['disk']:
        print(f"\nDevice: {disk['device']}")
        print(f"  Mount: {disk['mountpoint']}")
        print(f"  Total: {disk['total_gb']} GB")
        print(f"  Used: {disk['used_gb']} GB ({disk['percent_used']}%)")
        print(f"  Free: {disk['free_gb']} GB")


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        '--format',
        choices=['json', 'yaml', 'table', 'text'],
        default='table',
        help='Output format (default: table)'
    )
    parser.add_argument(
        '--output',
        '-o',
        type=str,
        help='Output file path (default: stdout)'
    )
    parser.add_argument(
        '--verbose',
        '-v',
        action='store_true',
        help='Enable verbose logging'
    )
    
    args = parser.parse_args()
    
    if args.verbose:
        logger.setLevel(logging.DEBUG)
    
    logger.info("Collecting system information...")
    
    try:
        info = get_system_info()
        
        if args.output:
            output_path = Path(args.output)
            
            if args.format == 'json' or output_path.suffix == '.json':
                with output_path.open('w') as f:
                    json.dump(info, f, indent=2)
                logger.info(f"System information saved to {output_path}")
            
            elif args.format == 'yaml' or output_path.suffix in ['.yaml', '.yml']:
                if not YAML_AVAILABLE:
                    logger.error("YAML support not available. Install with: pip install pyyaml")
                    sys.exit(1)
                with output_path.open('w') as f:
                    yaml.dump(info, f, default_flow_style=False)
                logger.info(f"System information saved to {output_path}")
            
            else:
                with output_path.open('w') as f:
                    f.write(json.dumps(info, indent=2))
                logger.info(f"System information saved to {output_path}")
        
        else:
            if args.format == 'json':
                print(json.dumps(info, indent=2))
            elif args.format == 'yaml':
                if not YAML_AVAILABLE:
                    logger.error("YAML support not available. Install with: pip install pyyaml")
                    sys.exit(1)
                print(yaml.dump(info, default_flow_style=False))
            elif args.format == 'table':
                format_table(info)
            else:
                format_text(info)
    
    except Exception as e:
        logger.error(f"Error collecting system information: {e}", exc_info=True)
        sys.exit(1)


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        logger.info("\nOperation cancelled by user")
        sys.exit(0)
    except Exception as e:
        logger.error(f"Unexpected error: {e}", exc_info=True)
        sys.exit(1)
