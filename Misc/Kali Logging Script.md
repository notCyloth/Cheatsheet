# Kali Logging Setup Script
This script will set up logging in the ~/logs folder. The logs will be for every terminal and save both commands and output. It will also update the prompt to include times the commands were run.
## Important Notes
- As the logs in ~/logs also save output - passwords displayed will be exposed in these logs.
- Logs older than 5 days are silently deleted to make sure there isn't bloat. If you want to ensure they are safe - move/copy them before then!

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

# Start full session logging once (flush-safe)
if [[ -z "$SCRIPT_RUNNING" ]]; then
  export SCRIPT_RUNNING=1
  script -q -f -a "$LOGFILE"
  exit
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
export TZ="Europe/London"
PROMPT='%B%F{cyan}%D{%H:%M:%S}%f%b %F{green}%n@%m%f %F{yellow}%~%f %F{red}%#%f '

# <<< TERMINAL LOGGING SETUP <<<

EOF

echo "[+] Configuration added to .zshrc"
echo "[+]" Installing ligolo-ng
sudo apt install ligolo-ng -y
echo "[+] Adding common binaries to ~/common_bins"
mkdir -p ~/common_bins/proxies
mkdir -p ~/common_bins/proxies/ligolo
cp /usr/share/windows-resources/mimikatz/Win32/mimikatz.exe ~/common_bins
cp /usr/share/peass/winpeas/winPEASx64.exe ~/common_bins
wget https://github.com/jpillora/chisel/releases/download/v1.11.3/chisel_1.11.3_windows_amd64.zip -q -O ~/common_bins/proxies/chisel.zip
unzip ~/common_bins/proxies/chisel.zip -d ~/common_bins/proxies
rm ~/common_bins/proxies/chisel.zip
wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.8.2/ligolo-ng_agent_0.8.2_windows_amd64.zip -q -O ~/common_bins/proxies/ligolo/ligolo.zip
unzip ~/common_bins/proxies/ligolo/ligolo.zip -d ~/common_bins/proxies/ligolo
rm ~/common_bins/proxies/ligolo/README.md ~/common_bins/proxies/ligolo/license ~/common_bins/proxies/ligolo/ligolo.zip
echo "[*] Binaries installed at ~/common_bins"
echo "[*] Open a new terminal to start logging"
```
