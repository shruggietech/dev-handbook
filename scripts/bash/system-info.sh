#!/bin/bash
#
# system-info.sh - Display comprehensive system information
#
# Description:
#   Collects and displays detailed system information including:
#   - Operating system details
#   - Hardware specs (CPU, memory, disk)
#   - Network configuration
#
# Usage:
#   ./system-info.sh [--output json|text]
#
# Options:
#   --output FORMAT    Output format (json or text), default is text
#   --help            Show this help message
#
# Examples:
#   ./system-info.sh
#   ./system-info.sh --output json
#
# Author: ShruggieTech
# Version: 1.0

set -euo pipefail

# Configuration
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default values
OUTPUT_FORMAT="text"

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m' # No Color

# Functions
usage() {
    cat << EOF
Usage: $SCRIPT_NAME [OPTIONS]

Display comprehensive system information.

Options:
    --output FORMAT    Output format (json or text), default is text
    -h, --help        Show this help message

Examples:
    $SCRIPT_NAME
    $SCRIPT_NAME --output json

EOF
}

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

get_os_info() {
    local os_name os_version os_kernel
    
    if [[ -f /etc/os-release ]]; then
        os_name=$(. /etc/os-release && echo "$NAME")
        os_version=$(. /etc/os-release && echo "$VERSION")
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        os_name="macOS"
        os_version=$(sw_vers -productVersion)
    else
        os_name=$(uname -s)
        os_version="Unknown"
    fi
    
    os_kernel=$(uname -r)
    
    echo "$os_name|$os_version|$os_kernel"
}

get_cpu_info() {
    local cpu_model cpu_cores
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        cpu_model=$(sysctl -n machdep.cpu.brand_string)
        cpu_cores=$(sysctl -n hw.ncpu)
    else
        cpu_model=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)
        cpu_cores=$(grep -c "processor" /proc/cpuinfo)
    fi
    
    echo "$cpu_model|$cpu_cores"
}

get_memory_info() {
    local total_mem free_mem used_mem
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        total_mem=$(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024}')
        free_mem=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//' | awk '{print $1*4096/1024/1024/1024}')
    else
        total_mem=$(free -g | awk '/^Mem:/ {print $2}')
        free_mem=$(free -g | awk '/^Mem:/ {print $4}')
    fi
    
    used_mem=$(echo "$total_mem - $free_mem" | bc)
    
    echo "$total_mem|$used_mem|$free_mem"
}

get_disk_info() {
    df -h | grep -E "^/dev/" | awk '{print $1"|"$2"|"$3"|"$4"|"$5"|"$6}'
}

get_network_info() {
    if command -v ip &> /dev/null; then
        ip -o -4 addr show | awk '{print $2"|"$4}' | cut -d/ -f1
    elif command -v ifconfig &> /dev/null; then
        ifconfig | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}'
    fi
}

output_text() {
    local os_info cpu_info mem_info
    
    IFS='|' read -r os_name os_version os_kernel <<< "$(get_os_info)"
    IFS='|' read -r cpu_model cpu_cores <<< "$(get_cpu_info)"
    IFS='|' read -r total_mem used_mem free_mem <<< "$(get_memory_info)"
    
    echo -e "${YELLOW}=== SYSTEM INFORMATION ===${NC}"
    echo "Hostname: $(hostname)"
    echo "Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    
    echo -e "${CYAN}--- Operating System ---${NC}"
    echo "OS Name: $os_name"
    echo "OS Version: $os_version"
    echo "Kernel: $os_kernel"
    echo ""
    
    echo -e "${CYAN}--- Processor ---${NC}"
    echo "Model: $cpu_model"
    echo "Cores: $cpu_cores"
    echo ""
    
    echo -e "${CYAN}--- Memory ---${NC}"
    echo "Total: ${total_mem} GB"
    echo "Used: ${used_mem} GB"
    echo "Free: ${free_mem} GB"
    echo ""
    
    echo -e "${CYAN}--- Disks ---${NC}"
    echo "Device | Size | Used | Avail | Use% | Mounted"
    echo "-------|------|------|-------|------|--------"
    get_disk_info | while IFS='|' read -r device size used avail percent mount; do
        echo "$device | $size | $used | $avail | $percent | $mount"
    done
    echo ""
    
    echo -e "${CYAN}--- Network ---${NC}"
    get_network_info
}

output_json() {
    local os_info cpu_info mem_info
    
    IFS='|' read -r os_name os_version os_kernel <<< "$(get_os_info)"
    IFS='|' read -r cpu_model cpu_cores <<< "$(get_cpu_info)"
    IFS='|' read -r total_mem used_mem free_mem <<< "$(get_memory_info)"
    
    cat << EOF
{
  "timestamp": "$(date -u '+%Y-%m-%dT%H:%M:%SZ')",
  "hostname": "$(hostname)",
  "os": {
    "name": "$os_name",
    "version": "$os_version",
    "kernel": "$os_kernel"
  },
  "cpu": {
    "model": "$cpu_model",
    "cores": $cpu_cores
  },
  "memory": {
    "total_gb": $total_mem,
    "used_gb": $used_mem,
    "free_gb": $free_mem
  }
}
EOF
}

main() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --output)
                OUTPUT_FORMAT="$2"
                shift 2
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    # Validate output format
    if [[ ! "$OUTPUT_FORMAT" =~ ^(json|text)$ ]]; then
        log_error "Invalid output format: $OUTPUT_FORMAT"
        log_error "Valid options are: json, text"
        exit 1
    fi
    
    # Generate output
    if [[ "$OUTPUT_FORMAT" == "json" ]]; then
        output_json
    else
        output_text
    fi
}

# Entry point
main "$@"
