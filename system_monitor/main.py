"""
Author: Sujith Thirumalaisamy
Date: 2026-02-03
Description:
    A Linux system health monitoring script that checks CPU, memory,
    disk usage, and process count with predefined thresholds.
    Sends an alert message to a Discord channel via a webhook on exceeds.
"""

import os
import sys
import psutil
import requests
import socket
from datetime import datetime

DISCORD_WEBHOOK_URL = os.getenv("DISCORD_WEBHOOK_NOTIFICATION_URL")

CPU_THRESHOLD = 70
MEM_THRESHOLD = 70
DISK_THRESHOLD = 85
PROCESS_THRESHOLD = 500
DISK_PATH = "/"

if not DISCORD_WEBHOOK_URL:
    print("DISCORD_WEBHOOK_NOTIFICATION_URL must be set.")
    sys.exit(1)

def send_discord_alert(message: str):
    payload = {
        "username": "Linux Monitor",
        "content": message
    }
    try:
        requests.post(DISCORD_WEBHOOK_URL, json=payload, timeout=5)
    except Exception as e:
        print(f"Failed to send Discord alert: {e}")


def check_system_health():
    alerts = []
    hostname = socket.gethostname()
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    cpu_usage = psutil.cpu_percent(interval=1)
    if cpu_usage > CPU_THRESHOLD:
        alerts.append(f"CPU: {cpu_usage}% (threshold {CPU_THRESHOLD}%)")

    mem = psutil.virtual_memory()
    mem_usage = mem.percent
    if mem_usage > MEM_THRESHOLD:
        alerts.append(f"Memory: {mem_usage}% (threshold {MEM_THRESHOLD}%)")

    disk = psutil.disk_usage(DISK_PATH)
    disk_usage = disk.percent
    if disk_usage > DISK_THRESHOLD:
        alerts.append(f"Disk: {DISK_PATH}: {disk_usage}% (threshold {DISK_THRESHOLD}%)")

    process_count = len(psutil.pids())
    if process_count > PROCESS_THRESHOLD:
        alerts.append(f"Process: {process_count} (threshold {PROCESS_THRESHOLD})")

    if alerts:
        message = f"System Alert on `{hostname}`\nTime: `{timestamp}`\n\n"
        message += "\n".join(f"> {a}" for a in alerts)
        send_discord_alert(message)

if __name__ == "__main__":
    check_system_health()
