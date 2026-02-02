#!/usr/bin/env bash

DISCORD_WEBHOOK_URL="https://discord.com/api/webhooks/1467945949543530506/A5Qs5WLNU-o28HmsAZekLDz-9vfFYEP3e68teqCFll_l3SUe6FG4x5Y-5_9s0-ozsj7t"

CPU_THRESHOLD=10        # %
MEM_THRESHOLD=10        # %
DISK_THRESHOLD=85       # %
PROCESS_THRESHOLD=500   # count
DISK_PATH="/"           # mount point

HOSTNAME="$(hostname)"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
ALERTS=()

send_discord_alert() {
  local message="$1"

  curl -s -X POST "$DISCORD_WEBHOOK_URL" \
    -H "Content-Type: application/json" \
    -d "{\"username\":\"Linux Monitor\",\"content\":\"$message\"}" \
    >/dev/null
}

# ---------------- CPU ----------------
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_USAGE=${CPU_USAGE%.*}

if (( CPU_USAGE > CPU_THRESHOLD )); then
  ALERTS+=("🔥 CPU usage high: ${CPU_USAGE}% (threshold ${CPU_THRESHOLD}%)")
fi

# ---------------- Memory ----------------
MEM_USAGE=$(free | awk '/Mem:/ { printf("%.0f"), $3/$2 * 100 }')

if (( MEM_USAGE > MEM_THRESHOLD )); then
  ALERTS+=("🧠 Memory usage high: ${MEM_USAGE}% (threshold ${MEM_THRESHOLD}%)")
fi

# ---------------- Disk ----------------
DISK_USAGE=$(df -P "$DISK_PATH" | awk 'NR==2 {print $5}' | tr -d '%')

if (( DISK_USAGE > DISK_THRESHOLD )); then
  ALERTS+=("💾 Disk usage high on ${DISK_PATH}: ${DISK_USAGE}% (threshold ${DISK_THRESHOLD}%)")
fi

# ---------------- Processes ----------------
PROCESS_COUNT=$(ps -e --no-headers | wc -l)

if (( PROCESS_COUNT > PROCESS_THRESHOLD )); then
  ALERTS+=("⚙️ Process count high: ${PROCESS_COUNT} (threshold ${PROCESS_THRESHOLD})")
fi

# ---------------- Send Alert ----------------
if (( ${#ALERTS[@]} > 0 )); then
  MESSAGE="**🚨 System Alert on ${HOSTNAME}**\n**Time:** ${TIMESTAMP}\n\n"
  for alert in "${ALERTS[@]}"; do
    MESSAGE+="- ${alert}\n"
  done

  send_discord_alert "$MESSAGE"
fi

