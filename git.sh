#!/usr/bin/env bash
set -euo pipefail

SSH_KEY_PATH="$HOME/.ssh/id_ed25519"

# Update and install required packages
pkg update && yes | pkg upgrade
yes | pkg install git openssh

# Retrieve existing git values (if any)
EXISTING_NAME="$(git config --global user.name 2>/dev/null || true)"
EXISTING_EMAIL="$(git config --global user.email 2>/dev/null || true)"

# Prompts for name and email (use -r to avoid mangling backslashes)
read -r -p "Name for git (user.name) [${EXISTING_NAME:-empty}]: " GIT_USER_INPUT
GIT_USER="${GIT_USER_INPUT:-$EXISTING_NAME}"

read -r -p "Email for git (user.email) [${EXISTING_EMAIL:-empty}]: " GIT_EMAIL_INPUT
GIT_EMAIL="${GIT_EMAIL_INPUT:-$EXISTING_EMAIL}"

# Optional passphrase (use -r -s for raw, silent input)
echo "Passphrase for the key. Leave empty and press Enter to create the key without a passphrase."
read -r -s -p "Passphrase: " PASSPHRASE
echo
if [ -n "$PASSPHRASE" ]; then
  read -r -s -p "Confirm passphrase: " PASSPHRASE2
  echo
  if [ "$PASSPHRASE" != "$PASSPHRASE2" ]; then
    echo "Passphrases do not match. Aborting."
    exit 1
  fi
fi

# Create .ssh directory with secure permissions
mkdir -p "$(dirname "$SSH_KEY_PATH")"
chmod 700 "$(dirname "$SSH_KEY_PATH")" || true

# Avoid overwriting without confirmation (use -r for the single-char read)
if [ -f "$SSH_KEY_PATH" ] || [ -f "${SSH_KEY_PATH}.pub" ]; then
  read -r -n1 -p "Key already exists at $SSH_KEY_PATH. Overwrite? [y/N]: " REPLY
  echo
  if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    echo "Aborted. No changes made."
    exit 0
  fi
  rm -f "$SSH_KEY_PATH" "${SSH_KEY_PATH}.pub"
fi

# Generate the key (accepts empty passphrase)
ssh-keygen -t ed25519 -C "${GIT_EMAIL:-}" -f "$SSH_KEY_PATH" -N "$PASSPHRASE"

chmod 600 "$SSH_KEY_PATH"
chmod 644 "${SSH_KEY_PATH}.pub"

# Start ssh-agent and add the key (if available)
if command -v ssh-agent >/dev/null 2>&1; then
  # avoid spawning duplicate agents in interactive shells
  eval "$(ssh-agent -s)" >/dev/null
  if command -v ssh-add >/dev/null 2>&1; then
    ssh-add "$SSH_KEY_PATH" || true
  fi
else
  echo "ssh-agent not found. Add the key manually with: ssh-add $SSH_KEY_PATH"
fi

# Configure git if provided
if [ -n "${GIT_USER:-}" ]; then
  git config --global user.name "$GIT_USER"
fi
if [ -n "${GIT_EMAIL:-}" ]; then
  git config --global user.email "$GIT_EMAIL"
fi
git config --global core.editor "nvim" || true

# Show public key and try to copy to Termux clipboard
echo
echo "=== Public key ==="
cat "${SSH_KEY_PATH}.pub"
echo "=================="
echo

if command -v termux-clipboard-set >/dev/null 2>&1; then
  cat "${SSH_KEY_PATH}.pub" | termux-clipboard-set
  echo "Public key copied to Termux clipboard."
fi

echo
echo "Done. Add the public key to your Git hosting (e.g. GitHub) and test with:"
echo "  ssh -T git@github.com"
