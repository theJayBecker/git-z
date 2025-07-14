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

# Bash/Zsh alias setup
if [[ "$USER_SHELL" == "bash" || "$USER_SHELL" == "zsh" ]]; then
  PROFILE_FILE="$HOME/.bashrc"
  [[ "$USER_SHELL" == "zsh" ]] && PROFILE_FILE="$HOME/.zshrc"

  if ! grep -q "alias git='git-z'" "$PROFILE_FILE"; then
    echo "alias git='git-z'" >> "$PROFILE_FILE"
    echo "🪄 Alias added to $PROFILE_FILE"
  else
    echo "ℹ️ Alias already exists in $PROFILE_FILE"
  fi

# Fish shell setup
elif [[ "$USER_SHELL" == "fish" ]]; then
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
else
  echo "⚠️ Unsupported shell: $USER_SHELL — please add git → git-z manually"
fi

# Ensure ~/.local/bin is in PATH
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
  echo "🔧 Adding $INSTALL_DIR to PATH..."
  if [[ "$USER_SHELL" == "fish" ]]; then
    fish -c "set -U fish_user_paths $INSTALL_DIR \$fish_user_paths"
  else
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$PROFILE_FILE"
  fi
fi

echo ""
echo "✅ Installation complete."
if [[ "$USER_SHELL" == "fish" ]]; then
  echo "👉 Open a new terminal or run: source ~/.config/fish/config.fish"
else
  echo "👉 Open a new terminal or run: source $PROFILE_FILE"
fi
echo "👉 Then try: git halp"
