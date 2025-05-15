#!/bin/bash

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
      echo "User $user does not exist" >> /tmp/users_script.log
    fi
  done
}

# Function to add a user to a group
add_user_to_group() {
  local group=$1
  for user in "${users[@]}"; do
    if id "$user" &>/dev/null; then
      sudo usermod -aG "$group" "$user"
      echo "User $user added to group $group"
    else
      echo "User $user does not exist"
      echo "User $user does not exist" >> /tmp/users_script.log
    fi
  done
}

# Function to remove a user from a group
remove_user_from_group() {
  local group=$1
  for user in "${users[@]}"; do
    if id "$user" &>/dev/null; then
      sudo gpasswd -d "$user" "$group"
      echo "User $user removed from group $group"
    else
      echo "User $user does not exist"
      echo "User $user does not exist" >> /tmp/users_script.log
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
if [[ $1 == "p" ]]; then
  change_passwords
elif [[ $1 == "a" ]]; then
  add_user_to_group $2
elif [[ $1 == "r" ]]; then
  remove_user_from_group $2
elif [[ $1 == "l" ]]; then
  cat /tmp/ssh_script.log
else
  # echo "Usage: $0 {i|w|key|restart} [user_list] [ssh_key]"
  echo "Usage: $0 {option}"
  echo "Options:"
  echo "  p     Change passwords for users"
  echo "  a     Add user to group"
  echo "  r     Remove user from group"
  echo "  l     Show log"
  exit 1
fi