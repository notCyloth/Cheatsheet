# Kali Logging Setup Script
This script will set up logging in the ~/logs folder. The logs will be for every terminal and save both commands and output. It will also update the prompt to include times the commands were run.
```bash
#!/usr/bin/env bash

set -e

ZSHRC="$HOME/.zshrc"
LOGDIR="$HOME/logs"
RETENTION_DAYS=5

echo "[*] Setting up terminal logging, timestamps, and log rotation..."

# Ensure log directory exists
mkdir -p "$LOGDIR"

# Backup .zshrc once
if [[ ! -f "${ZSHRC}.bak_terminal_logging" ]]; then
  cp "$ZSHRC" "${ZSHRC}.bak_terminal_logging"
  echo "[+] Backed up .zshrc to .zshrc.bak_terminal_logging"
fi

MARKER="# >>> TERMINAL LOGGING SETUP >>>"

if grep -q "$MARKER" "$ZSHRC"; then
  echo "[!] Terminal logging already configured in .zshrc"
  exit 0
fi

cat >> "$ZSHRC" <<'EOF'

# >>> TERMINAL LOGGING SETUP >>>

# Directory for terminal logs
export LOGDIR="$HOME/logs"
mkdir -p "$LOGDIR"

# Cleanup logs older than 5 days
find "$LOGDIR" -type f -name "*.log" -mtime +5 -exec rm -f {} \; 2>/dev/null

# Prompt for terminal name once per shell
if [[ -z "$TERM_NAME" ]]; then
  echo -n "Enter terminal name (e.g. recon, web, infra): "
  read TERM_NAME
  export TERM_NAME

  # Set terminal/tab title
  printf '\033]0;%s\007' "$TERM_NAME"
fi

# Timestamp for unique log file (down to seconds)
export LOG_TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"

# Log file per terminal per session
export LOGFILE="$LOGDIR/${TERM_NAME}_${LOG_TIMESTAMP}.log"

# Start full session logging once
if [[ -z "$SCRIPT_RUNNING" ]]; then
  export SCRIPT_RUNNING=1
  script -q -a "$LOGFILE"
fi

# Colored prompt with time
PROMPT='%B%F{cyan}%D{%H:%M:%S}%f%b %F{green}%n@%m%f %F{yellow}%~%f %F{red}%#%f '

# <<< TERMINAL LOGGING SETUP <<<

EOF

echo "[+] Configuration added to .zshrc"
echo "[*] Open a new terminal to start logging"

```
