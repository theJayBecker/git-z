#!/usr/bin/env bash

set -e

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="git-z"
SCRIPT_SOURCE="$(pwd)/$SCRIPT_NAME"

echo "📦 Installing git-z from local repo..."

# Validate script presence
if [[ ! -f "$SCRIPT_SOURCE" ]]; then
  echo "❌ Could not find $SCRIPT_NAME in current directory."
  echo "Make sure you're running this script from the root of the git-z repo."
  exit 1
fi

# Create bin dir if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Copy the script to ~/.local/bin
cp "$SCRIPT_SOURCE" "$INSTALL_DIR/$SCRIPT_NAME"
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"
echo "✅ Copied $SCRIPT_NAME to $INSTALL_DIR"

# Detect shell
USER_SHELL="$(basename "$SHELL")"
echo "🧠 Detected shell: $USER_SHELL"
echo ""

# Check if fish is installed
FISH_INSTALLED=false
if command -v fish >/dev/null 2>&1; then
  FISH_INSTALLED=true
  echo "🐟 Fish shell detected as installed"
fi

# Bash/Zsh alias setup
PROFILE_FILE=""
if [[ "$USER_SHELL" == "bash" || "$USER_SHELL" == "zsh" ]]; then
  PROFILE_FILE="$HOME/.bashrc"
  [[ "$USER_SHELL" == "zsh" ]] && PROFILE_FILE="$HOME/.zshrc"

  if ! grep -q "alias git='git-z'" "$PROFILE_FILE"; then
    echo "alias git='git-z'" >> "$PROFILE_FILE"
    echo "🪄 Alias added to $PROFILE_FILE"
  else
    echo "ℹ️ Alias already exists in $PROFILE_FILE"
  fi
elif [[ "$USER_SHELL" == "fish" ]]; then
  # If current shell is fish, we'll still set up bashrc if it exists
  if [[ -f "$HOME/.bashrc" ]]; then
    PROFILE_FILE="$HOME/.bashrc"
    if ! grep -q "alias git='git-z'" "$PROFILE_FILE"; then
      echo "alias git='git-z'" >> "$PROFILE_FILE"
      echo "🪄 Alias added to $PROFILE_FILE"
    else
      echo "ℹ️ Alias already exists in $PROFILE_FILE"
    fi
  fi
else
  echo "⚠️ Unsupported shell: $USER_SHELL"
  # Still try to set up bashrc if it exists
  if [[ -f "$HOME/.bashrc" ]]; then
    PROFILE_FILE="$HOME/.bashrc"
    if ! grep -q "alias git='git-z'" "$PROFILE_FILE"; then
      echo "alias git='git-z'" >> "$PROFILE_FILE"
      echo "🪄 Alias added to $PROFILE_FILE"
    else
      echo "ℹ️ Alias already exists in $PROFILE_FILE"
    fi
  fi
fi

# Fish shell setup (if fish is installed, regardless of current shell)
if [[ "$FISH_INSTALLED" == true ]]; then
  FUNC_PATH="$HOME/.config/fish/functions/git.fish"
  mkdir -p "$(dirname "$FUNC_PATH")"

  # Use single-quoted heredoc to prevent Bash variable expansion
  cat <<'EOF' > "$FUNC_PATH"
function git
  if status --is-interactive
    set cmd (string join " " (bash -c "command -v git-z") $argv)
    eval $cmd
  else
    command git $argv
  end
end
EOF

  echo "🐟 Fish function created at $FUNC_PATH"
fi

# Ensure ~/.local/bin is in PATH
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
  echo "🔧 Adding $INSTALL_DIR to PATH..."
  if [[ "$FISH_INSTALLED" == true ]]; then
    fish -c "set -U fish_user_paths $INSTALL_DIR \$fish_user_paths" 2>/dev/null || true
  fi
  if [[ -n "$PROFILE_FILE" ]]; then
    if ! grep -q "export PATH.*$INSTALL_DIR" "$PROFILE_FILE"; then
      echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$PROFILE_FILE"
    fi
  fi
fi

echo ""
echo "✅ Installation complete."
RELOAD_COMMANDS=()
if [[ "$FISH_INSTALLED" == true ]]; then
  RELOAD_COMMANDS+=("source ~/.config/fish/config.fish")
fi
if [[ -n "$PROFILE_FILE" ]]; then
  RELOAD_COMMANDS+=("source $PROFILE_FILE")
fi
if [[ ${#RELOAD_COMMANDS[@]} -gt 0 ]]; then
  echo "👉 Open a new terminal or run: ${RELOAD_COMMANDS[0]}"
  if [[ ${#RELOAD_COMMANDS[@]} -gt 1 ]]; then
    for cmd in "${RELOAD_COMMANDS[@]:1}"; do
      echo "   or run: $cmd"
    done
  fi
fi
echo "👉 Then try: git halp"
