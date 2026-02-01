# Kali Logging Setup Script
This script will set up logging in the ~/logs folder. The logs will be for every terminal and save both commands and output. It will also update the prompt to include times the commands were run.

__**NOTE: AS THIS SAVED OUTPUT, PASSWORDS DISPLAYED WILL ALSO BE STORED IN THESE LOGS!!!**__

Terminal naming scheme examples: ctfname_vpn, ctfname_recon, etc
```bash
#!/usr/bin/env bash

set -e

ZSHRC="$HOME/.zshrc"
LOGDIR="$HOME/logs"
RETENTION_DAYS=5

echo "[*] Setting up terminal logging, titles, and log retention..."

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

# Log directory
export LOGDIR="$HOME/logs"
mkdir -p "$LOGDIR"

# Cleanup logs older than 5 days
find "$LOGDIR" -type f -name "*.log" -mtime +5 -exec rm -f {} \; 2>/dev/null

# Prompt for terminal name once per shell
if [[ -z "$TERM_NAME" ]]; then
  echo -n "Enter terminal name (e.g. recon, web, infra): "
  read TERM_NAME
  export TERM_NAME
fi

# Timestamp for unique log filename
export LOG_TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"

# Log file per terminal session
export LOGFILE="$LOGDIR/${TERM_NAME}_${LOG_TIMESTAMP}.log"

# Start full session logging once
if [[ -z "$SCRIPT_RUNNING" ]]; then
  export SCRIPT_RUNNING=1
  script -q -a "$LOGFILE"
fi

# ---- Terminal title handling (Kali override) ----

# Disable Kali's default title logic
unset precmd_functions

# Force terminal/tab title on every prompt
precmd() {
  print -Pn "\e]0;${TERM_NAME}\a"
}

# ---- Prompt customization ----

# Colored prompt with time
PROMPT='%B%F{cyan}%D{%H:%M:%S}%f%b %F{green}%n@%m%f %F{yellow}%~%f %F{red}%#%f '

# <<< TERMINAL LOGGING SETUP <<<

EOF

echo "[+] Configuration added to .zshrc"
echo "[*] Open a new terminal to start logging"
```
