#!/bin/bash

# Function to make a file immutable
make_immutable() {
  sudo chmod 600 /etc/ssh/sshd_config
  sudo chown root:root /etc/ssh/sshd_config
  sudo chattr +i /etc/ssh/sshd_config
}

# Function to remove the immutable attribute from a file
remove_immutable() {
  sudo chattr -i /etc/ssh/sshd_config
  sudo chmod 600 /etc/ssh/sshd_config
  sudo chown root:root /etc/ssh/sshd_config
}

# Function to remove the immutable attribute from a file
edit_sshd_config() {
  sudo chattr -i /etc/ssh/sshd_config
  sudo chmod 600 /etc/ssh/sshd_config
  sudo chown root:root /etc/ssh/sshd_config
  sudo nano /etc/ssh/sshd_config
}

# Function to add SSH keys to users
add_ssh_keys() {
  # Path to the file containing usernames (one per line)
  USER_LIST=$2

  # Path to your public key
  SSH_KEY=$3

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
}

# Main script logic
if [[ $1 == "i" ]]; then
  make_immutable
elif [[ $1 == "w" ]]; then
  remove_immutable
elif [[ $1 == "key" ]]; then
  add_ssh_keys $2 $3
else
  echo "Usage: $0 {i|w|key} [user_list] [ssh_key]"
  exit 1
fi