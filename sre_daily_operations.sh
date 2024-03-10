#!/bin/bash

# Configuration
SRE_EMAIL="amr.abunemr1998@gmail.com"
CRITICAL_DATA_DIR="/data/critical"
BACKUP_DIR="backup"
LOG_DIR="./sre_daily_operations_logs"
DATE=$(date +%Y%m%d)

# Function to log messages
log_message() {
    local logfile="$1"
    local message="$2"
    echo "$(date +"%Y-%m-%d %T") - $message" >> "$logfile"
}


# Function to check disk space
check_disk_space() {
    local threshold=85
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    if (( $(echo "$disk_usage > $threshold" | bc -l) )); then
        return 1
    fi
}

# Task 1: Log Analysis
log_analysis() {
    local logfile="$LOG_DIR/log_analysis.log"
    log_message "$logfile" "Starting log analysis"
    log_message "$logfile" "Log analysis completed"
}

# Task 2: System Health Checks
system_health_checks() {
    local logfile="$LOG_DIR/system_health.log"
    log_message "$logfile" "Starting system health checks"
    local error=false

    # Check CPU and memory usage
    local cpu_usage=$(top -bn1 | awk 'NR==3 {print $2}' | cut -d '.' -f1)
    local memory_usage=$(free | awk '/Mem/ {printf("%.2f"), $3/$2 * 100}')

    if (( $(echo "$cpu_usage > 85" | bc -l) )) || (( $(echo "$memory_usage > 85" | bc -l) )); then
        log_message "$logfile" "High CPU or memory usage detected"
        error=true
    fi

    # Check disk space
    if check_disk_space; then
        log_message "$logfile" "High disk usage detected"
        error=true
    fi

    if [ "$error" = true ]; then
        # Send email notification to SRE
        echo "High resource usage detected so Please Investigate." | mail -s "Resource Usage Alert" "$SRE_EMAIL"
        log_message "$logfile" "Email notification sent to $SRE_EMAIL"
    fi

    log_message "$logfile" "System Health Checks Completed"
}

# Task 3: Backup Management
backup_management() {
    mkdir -p "$BACKUP_DIR"
    local logfile="$BACKUP_DIR/backup_management.log"
    log_message "$logfile" "Starting Backup Management"
    
    # Perform daily backup
    local backup_file="$BACKUP_DIR/backup_$DATE.tar.gz"
    if [ -d "$CRITICAL_DATA_DIR" ]; then
        tar -czf "$backup_file" "$CRITICAL_DATA_DIR" && log_message "$logfile" "Backup Created: $backup_file"
    else
        log_message "$logfile" "Critical data directory not found. Backup aborted."
    fi

    # Remove backups older than 7 days
    find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +7 -delete && log_message "$logfile" "Old Backups Removed"
    
    log_message "$logfile" "Backup Management Completed"
}

# Main function
main() {
    # Create log directory if not exists
    mkdir -p "$LOG_DIR"
    mkdir -p "$BACKUP_DIR"


    log_analysis
    system_health_checks
    backup_management
}

# Run main function
main
