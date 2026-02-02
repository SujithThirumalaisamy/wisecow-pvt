# System resource monitor

Python script to monitor CPU, memory, disk usage, and process count on a Linux system, Sends alerts to a Discord channel via webhook when threshold is exceeded

- Check CPU, memory, and disk usage and processes
- Sends alert messages to Discord if thresholds are exceeded

Set the Discord webhook URL as an environment variable:

```bash
export DISCORD_WEBHOOK_NOTIFICATION_URL="https://discord.com/api/webhooks/..."
```
