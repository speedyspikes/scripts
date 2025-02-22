#!/bin/bash

# Path to the file containing usernames (one per line)
USER_LIST=$1

# Path to your public key
SSH_KEY=$2

# Check if the user list file exists
if [[ ! -f $USER_LIST ]]; then
  echo "Error: User list file '$USER_LIST' not found!"
  exit 1
fi

# Read the user list from the file
while IFS= read -r user; do
  # Skip empty lines
  [[ -z "$user" ]] && continue
  
  USER_HOME="/home/$user"
  AUTH_KEYS="$USER_HOME/.ssh/authorized_keys"

  # Ensure the .ssh directory exists
  sudo mkdir -p "$USER_HOME/.ssh"
  sudo chmod 700 "$USER_HOME/.ssh"

  # Add the key to authorized_keys
  sudo cp $SSH_KEY $AUTH_KEYS

  # Set proper permissions
  sudo chmod 600 $AUTH_KEYS
  sudo chown -R "$user:$user" "$USER_HOME/.ssh"

  echo "Added SSH key for $user"
done < "$USER_LIST"