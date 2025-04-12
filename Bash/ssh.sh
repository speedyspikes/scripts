#!/bin/bash

# Function to make the ssh file immutable
make_immutable() {
  sudo chmod 600 /etc/ssh/sshd_config
  sudo chown root:root /etc/ssh/sshd_config
  sudo chattr +i /etc/ssh/sshd_config
}

# Function to remove the immutable attribute from ssh_config
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
  # Print the current date/time at the start of the script
  echo "- Execution: $(date)" >> /tmp/ssh_script.log

  # Path to the file containing usernames (one per line)
  # USER_LIST=$2
  
  # Path to your public key
  # SSH_KEY=$3
  
  # Check if the user list file exists
  # if [[ ! -f $USER_LIST ]]; then
  #   echo "Error: User list file '$USER_LIST' not found!"
  #   exit 1
  # fi
  
  # Read the user list from the file
  # while IFS= read -r user; do
    # Skip empty lines
    # [[ -z "$user" ]] && continue
  
  for user in "${users[@]}"; do
    # Check if the user exists
    if id "$user" &>/dev/null; then
      USER_HOME="/home/$user"
      AUTH_KEYS="$USER_HOME/.ssh/authorized_keys"
  
      # Ensure the .ssh directory exists
      sudo mkdir -p "$USER_HOME/.ssh"
      sudo chmod 700 "$USER_HOME/.ssh"
  
      # Add the key to authorized_keys
      echo "$key" | sudo tee $AUTH_KEYS > /dev/null
  
      # Set proper permissions
      sudo chmod 600 $AUTH_KEYS
      sudo chown -R "$user:$user" "$USER_HOME/.ssh"
  
      echo "Added SSH key for $user"
    else
      echo "User $user does not exist"
      echo "User $user does not exist" >> /tmp/ssh_script.log
    fi
  done
  # done < "$USER_LIST"
}

# Function to change passwords for all users
change_passwords() {
  read -sp "Enter new password: " new_password
  echo
  for user in "${users[@]}"; do
    if id "$user" &>/dev/null; then
      echo "$user:$new_password" | sudo chpasswd
      echo "Password changed for $user"
    else
      echo "User $user does not exist"
      echo "User $user does not exist" >> /tmp/ssh_script.log
    fi
  done
}

users=(
  camille_jenatzy
  gaston_chasseloup
  leon_serpollet
  william_vanderbilt
  henri_fournier
  maurice_augieres
  arthur_duray
  henry_ford
  louis_rigolly
  pierre_caters
  paul_baras
  victor_hemery
  fred_marriott
  lydston_hornsted
  kenelm_guinness
  rene_thomas
  ernest_eldridge
  malcolm_campbell
  ray_keech
  john_cobb
  dorothy_levitt
  paula_murphy
  betty_skelton
  rachel_kushner
  kitty_oneil
  jessi_combs
  andy_green
)
key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDeG5nScm9x0W1HOHEakXDMjFTqcoaTKmSjF83CACnJgjQxIypJXZ+Ao+MUsyZjBhGsLnsDCwVOBiKhUpExZUhB425QJ+PwVz3qrb8h0tOMPV1m4+CKc/BLgnwx3GtLuJ7Y1Ks7yNBBzL4syhFRAFEzKbn4cHMINV3Z64HXmMi/PFIq97smsIFdgfyza3qyO7w1Age0RjhqyB8w/JWFS7BriU2IbaerRdbRzjCvChqs5BRAxiSyesMRnDwUoqeQA/tVcikZHvR/+VePgs7Jlk4gKuIUAmUeUjw9VzrtVJf9NOkHc6ar5Qif1ewyKp8nmeO3bkHgPme9Q7x9AhWbnMHRnjow8cUL+E+/3gJDHrAZE0bhFwgb8m3N5PBU5h1gNwaxE2x7w2+wqlrTii6/gefEyhsqNw5udHb4ineG0LjCCedKYQzwoF1GahLCz1S8xPY8aZPxy+Wf6RWczjlqZOfFVpSKm5wU2BmfZBmI8jfzGBYOrgaqExVMqLz2v6JEZK0= SCORING KEY DO NOT REMOVE"

# Function to restart SSH service
restart_ssh() {
  sudo systemctl restart sshd
  echo "SSH service restarting..."
}

# Function to harden SSH configuration
harden_ssh_config() {
  sudo sed -i.bak \
    -e 's/^#*Port.*/Port 22/' \
    -e 's/^#*PermitRootLogin.*/PermitRootLogin no/' \
    -e 's/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/' \
    -e 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' \
    -e 's/^#*PermitEmptyPasswords.*/PermitEmptyPasswords no/' \
    -e 's/^#*ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/' \
    -e 's/^#*UsePAM.*/UsePAM yes/' \
    -e 's/^#*X11Forwarding.*/X11Forwarding no/' \
    /etc/ssh/sshd_config

  echo "SSH config hardened. Backup saved as /etc/ssh/sshd_config.bak"
}

# Main script logic
if [[ $1 == "i" ]]; then
  make_immutable
elif [[ $1 == "w" ]]; then
  remove_immutable
elif [[ $1 == "e" ]]; then
  edit_sshd_config
elif [[ $1 == "key" ]]; then
  # add_ssh_keys $2 $3
  add_ssh_keys $users $key
elif [[ $1 == "p" ]]; then
  change_passwords
elif [[ $1 == "r" ]]; then
  restart_ssh
elif [[ $1 == "h" ]]; then
  remove_immutable
  harden_ssh_config
  restart_ssh
  make_immutable
elif [[ $1 == "a" ]]; then
  remove_immutable
  harden_ssh_config
  make_immutable
  add_ssh_keys $users $key
  restart_ssh
elif [[ $1 == "l" ]]; then
  cat /tmp/ssh_script.log
else
  # echo "Usage: $0 {i|w|key|restart} [user_list] [ssh_key]"
  echo "Usage: $0 {option}"
  echo "Options:"
  echo "  i     Make sshd_config immutable"
  echo "  w     Write/remove immutable attribute from sshd_config"
  echo "  e     Edit sshd_config"
  echo "  key   Add SSH keys to users"
  echo "  p     Change passwords for all users"
  echo "  r     Restart SSH service"
  echo "  h     Harden SSH config"
  echo "  a     Run i, key, r"
  echo "  l     Show log"
  exit 1
fi