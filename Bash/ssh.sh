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
key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCcM4aDj8Y4COv+f8bd2WsrIynlbRGgDj2+q9aBeW1Umj5euxnO1vWsjfkpKnyE/ORsI6gkkME9ojAzNAPquWMh2YG+n11FB1iZl2S6yuZB7dkVQZSKpVYwRvZv2RnYDQdcVnX9oWMiGrBWEAi4jxcYykz8nunaO2SxjEwzuKdW8lnnh2BvOO9RkzmSXIIdPYgSf8bFFC7XFMfRrlMXlsxbG3u/NaFjirfvcXKexz06L6qYUzob8IBPsKGaRjO+vEdg6B4lH1lMk1JQ4GtGOJH6zePfB6Gf7rp31261VRfkpbpaDAznTzh7bgpq78E7SenatNbezLDaGq3Zra3j53u7XaSVipkW0S3YcXczhte2J9kvo6u6s094vrcQfB9YigH4KhXpCErFk08NkYAEJDdqFqXIjvzsro+2/EW1KKB9aNPSSM9EZzhYc+cBAl4+ohmEPej1m15vcpw3k+kpo1NC2rwEXIFxmvTme1A2oIZZBpgzUqfmvSPwLXF0EyfN9Lk= SCORING KEY DO NOT REMOVE"

# Function to restart SSH service
restart_ssh() {
  sudo systemctl restart sshd
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
elif [[ $1 == "r"]]; then
  restart_ssh
elif [[ $1 == "a" ]]; then
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
  echo "  a     Run i, key, r"
  echo "  l     Show log"
  exit 1
fi