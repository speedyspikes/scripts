let badusb = require("badusb");
let keyboard = require("keyboard");
let notify = require("notification");
let dialog = require("dialog");
let submenu = require("submenu");
let storage = require("storage");


function main() {
    badusb.setup({
        vid: 0xAAAA,
        pid: 0xBBBB,
        mfr_name: "Flipper",
        prod_name: "Zero",
        layout_path: "/ext/badusb/assets/layouts/en-US.kl"
    });

    while (true) {
        submenu.addItem("Network", 0);
        submenu.addItem("Passwords", 1);
        submenu.addItem("SSH", 2);
        submenu.addItem("Paste", 3);
        let r = submenu.show();
        if (r === undefined) {break}
        
        else if (r === 0) {  //Network
            while (true) {
                submenu.addItem("Ubuntu", 0);
                submenu.addItem("CentOS", 1);
                // submenu.addItem("2", 2);
                // submenu.addItem("3", 3);
                let r1 = submenu.show();
                if (r1 === undefined) {break}

                else if (r1 === 0) {  //Ubuntu
                    print("\nBadUSB: Ubuntu Network");
                    while (true) {
                        submenu.addItem("nano", 0);
                        submenu.addItem("data", 1);
                        submenu.addItem("apply", 2);
                        let r2 = submenu.show();
                        if (r2 === undefined) {break}
                    
                        else if (r2 === 0) {  //nano
                            if (badusb.isConnected()) {
                                notify.blink("green", "short");
                                
                                badusb.print('sudo nano /etc/netplan/');
                                badusb.press('TAB');
                                
                                notify.success();
                            } else {usb_nc()}
                        }
                        
                        else if (r2 === 1) {  //data
                            if (badusb.isConnected()) {
                                notify.blink("green", "short");
                                
                                badusb.println('      addresses:');
                                badusb.print('        - 192.168.6.');
                                badusb.println(keyboard.text(4, "")+'/24');
                                badusb.println('      gateway4: 192.168.6.1');
                                badusb.println('      nameservers:');
                                badusb.println('        addresses:');
                                badusb.println('          - 192.168.6.12');
                                badusb.print('          - 8.8.8.8');
                                
                                notify.success();
                            } else {usb_nc()}
                        }

                        else if (r2 === 2) {  //apply
                            if (badusb.isConnected()) {
                                notify.blink("green", "short");
                                
                                badusb.println('sudo netplan apply');
                                
                                notify.success();
                            } else {usb_nc()}
                        }
                    }
                }

                else if (r1 === 1) {  //CentOS
                    print("\nBadUSB: Ubuntu Network");
                    while (true) {
                        submenu.addItem("vi", 0);
                        submenu.addItem("data internal", 1);
                        submenu.addItem("data external", 2);
                        submenu.addItem("save", 3);
                        submenu.addItem("apply", 4);
                        let r2 = submenu.show();
                        if (r2 === undefined) {break}
                    
                        else if (r2 === 0) {  //vi
                            if (badusb.isConnected()) {
                                notify.blink("green", "short");
                                
                                badusb.print('sudo vi /etc/sysconfig/network-scripts/ifcfg-e');
                                badusb.press('TAB')
                                
                                notify.success();
                            } else {usb_nc()}
                        }
                        
                        else if (r2 === 1) {  //data internal
                            if (badusb.isConnected()) {
                                notify.blink("green", "short");
                                
                                badusb.print('IPADDR=192.168.17.'); badusb.println(keyboard.text(4, ""));
                                badusb.println('NETMASK=24');
                                badusb.println('GATEWAY=192.168.17.1');
                                badusb.print('DNS1=192.168.17.12');
                                badusb.print('DNS2=8.8.8.8');
                                
                                notify.success();
                            } else {usb_nc()}
                        }
                        
                        else if (r2 === 2) {  //data external
                            if (badusb.isConnected()) {
                                notify.blink("green", "short");
                                
                                badusb.println('IPADDR=172.18.14.17');
                                badusb.println('NETMASK=16');
                                badusb.println('GATEWAY=172.18.0.1');
                                badusb.println('DNS1=172.18.0.12');
                                badusb.print('DNS2=8.8.8.8');
                                
                                notify.success();
                            } else {usb_nc()}
                        }

                        else if (r2 === 3) {  //save
                            if (badusb.isConnected()) {
                                notify.blink("green", "short");
                                
                                badusb.press('ESCAPE');
                                badusb.println(':wq');
                                
                                notify.success();
                            } else {usb_nc()}
                        }

                        else if (r2 === 4) {  //apply
                            if (badusb.isConnected()) {
                                notify.blink("green", "short");
                                
                                badusb.println('sudo systemctl restart NetworkManager');
                                
                                notify.success();
                            } else {usb_nc()}
                        }
                    }
                }
            }
        }
        
        else if (r === 1) {  //Passwords
            print("\nBadUSB: Passwords");
            while (true) {
                // submenu.addItem("github token", 0);
                submenu.addItem("ssh user", 1);
                // submenu.addItem("2", 2);
                let r2 = submenu.show();
                if (r2 === undefined) {break}
            
                else if (r2 === 0) {  //github token
                    if (badusb.isConnected()) {
                        notify.blink("green", "short");
                        
                        badusb.print('[GITHUB TOKEN]');
                        
                        notify.success();
                    } else {usb_nc()}
                }

                else if (r2 === 1) {  //ssh user
                    if (badusb.isConnected()) {
                        notify.blink("green", "short");
                        
                        // Log into the root user with password 'abc123'
                        badusb.println('root');
                        badusb.press('ENTER');
                        badusb.println('abc123');
                        badusb.press('ENTER');
                        
                        // Change the root password to 'chips foot'
                        badusb.println('passwd');
                        badusb.press('ENTER');
                        badusb.println('chips foot');
                        badusb.press('ENTER');
                        badusb.println('chips foot');
                        badusb.press('ENTER');
                        
                        // Change the blueteam user password to 'giggly wise'
                        badusb.println('passwd blueteam');
                        badusb.press('ENTER');
                        badusb.println('giggly wise');
                        badusb.press('ENTER');
                        badusb.println('giggly wise');
                        badusb.press('ENTER');
                        
                        // Add blueteam to the sudo group
                        badusb.println('usermod -aG sudo blueteam');
                        badusb.press('ENTER');
                        
                        // Log into the blueteam user
                        badusb.println('su - blueteam');
                        badusb.press('ENTER');
                        badusb.println('giggly wise');
                        badusb.press('ENTER');
                        
                        // Disable login for root
                        badusb.println('sudo passwd -l root');
                        badusb.press('ENTER');
                        
                        notify.success();
                    } else {usb_nc()}
                }
            }
        }

        else if (r === 2) {  //SSH
            while (true) {
                submenu.addItem("config", 0);
                submenu.addItem("script", 1);
                // submenu.addItem("2", 2);
                // submenu.addItem("3", 3);
                let r1 = submenu.show();
                if (r1 === undefined) {break}

                else if (r1 === 0) {  //config
                    print("\nBadUSB: ssh_config");
                        submenu.addItem("vi", 0);
                        submenu.addItem("nano", 1);
                        submenu.addItem("vi save", 2);
                        submenu.addItem("apply", 3);
                        let r2 = submenu.show();
                        if (r2 === undefined) {break}
                    
                        else if (r2 === 0) {  //vi
                            if (badusb.isConnected()) {
                                notify.blink("green", "short");
                                
                                badusb.print('sudo vi /etc/ssh/sshd_config');
                                
                                notify.success();
                            } else {usb_nc()}
                        }
                        
                        else if (r2 === 1) {  //nano
                            if (badusb.isConnected()) {
                                notify.blink("green", "short");
                                
                                badusb.print('sudo nano /etc/ssh/sshd_config');
                                
                                notify.success();
                            } else {usb_nc()}
                        }

                        else if (r2 === 2) {  //save
                            if (badusb.isConnected()) {
                                notify.blink("green", "short");
                                
                                badusb.press('ESCAPE');
                                badusb.println(':wq');
                                
                                notify.success();
                            } else {usb_nc()}
                        }

                        else if (r2 === 3) {  //apply
                            if (badusb.isConnected()) {
                                notify.blink("green", "short");
                                
                                badusb.println('sudo systemctl restart sshd');
                                
                                notify.success();
                            } else {usb_nc()}
                        }
                }
                
                else if (r1 === 1) {  //script
                    print("\nBadUSB: script");
                    let speed = 40;
                    let ms = 200;
                    badusb.println('#!/bin/bash', speed);
                    badusb.press('ENTER');
                    badusb.println('# Function to make the ssh file immutable', speed);
                    badusb.println('make_immutable() {', speed);
                    badusb.println('  sudo chmod 600 /etc/ssh/sshd_config', speed);
                    badusb.println('  sudo chown root:root /etc/ssh/sshd_config', speed);
                    badusb.println('  sudo chattr +i /etc/ssh/sshd_config', speed);
                    badusb.println('}', speed);
                    badusb.press('ENTER');
                    delay(ms);
                    badusb.println('# Function to remove the immutable attribute from ssh_config', speed);
                    badusb.println('remove_immutable() {', speed);
                    badusb.println('  sudo chattr -i /etc/ssh/sshd_config', speed);
                    badusb.println('  sudo chmod 600 /etc/ssh/sshd_config', speed);
                    badusb.println('  sudo chown root:root /etc/ssh/sshd_config', speed);
                    badusb.println('}', speed);
                    badusb.press('ENTER');
                    delay(ms);
                    badusb.println('# Function to remove the immutable attribute from a file', speed);
                    badusb.println('edit_sshd_config() {', speed);
                    badusb.println('  sudo chattr -i /etc/ssh/sshd_config', speed);
                    badusb.println('  sudo chmod 600 /etc/ssh/sshd_config', speed);
                    badusb.println('  sudo chown root:root /etc/ssh/sshd_config', speed);
                    badusb.println('  sudo nano /etc/ssh/sshd_config', speed);
                    badusb.println('}', speed);
                    badusb.press('ENTER');
                    delay(ms);
                    badusb.println('# Function to add SSH keys to users', speed);
                    badusb.println('add_ssh_keys() {', speed);
                    badusb.println('  echo "- Execution: $(date)" >> /tmp/ssh_script.log', speed);
                    badusb.println('  for user in "${users[@]}"; do', speed);
                    badusb.println('    if id "$user" &>/dev/null; then', speed);
                    badusb.println('      USER_HOME="/home/$user"', speed);
                    badusb.println('      AUTH_KEYS="$USER_HOME/.ssh/authorized_keys"', speed);
                    badusb.println('      sudo mkdir -p "$USER_HOME/.ssh"', speed);
                    badusb.println('      sudo chmod 700 "$USER_HOME/.ssh"', speed);
                    badusb.println('      echo "$key" | sudo tee $AUTH_KEYS > /dev/null', speed);
                    badusb.println('      sudo chmod 600 $AUTH_KEYS', speed);
                    badusb.println('      sudo chown -R "$user:$user" "$USER_HOME/.ssh"', speed);
                    badusb.println('      echo "Added SSH key for $user"', speed);
                    badusb.println('    else', speed);
                    badusb.println('      echo "User $user does not exist"', speed);
                    badusb.println('      echo "User $user does not exist" >> /tmp/ssh_script.log', speed);
                    badusb.println('    fi', speed);
                    badusb.println('  done', speed);
                    badusb.println('}', speed);
                    badusb.press('ENTER');
                    delay(ms);
                    badusb.println('# Function to change passwords for all users', speed);
                    badusb.println('change_passwords() {', speed);
                    badusb.println('  read -sp "Enter new password: " new_password', speed);
                    badusb.println('  echo', speed);
                    badusb.println('  for user in "${users[@]}"; do', speed);
                    badusb.println('    if id "$user" &>/dev/null; then', speed);
                    badusb.println('      echo "$user:$new_password" | sudo chpasswd', speed);
                    badusb.println('      echo "Password changed for $user"', speed);
                    badusb.println('    else', speed);
                    badusb.println('      echo "User $user does not exist"', speed);
                    badusb.println('      echo "User $user does not exist" >> /tmp/ssh_script.log', speed);
                    badusb.println('    fi', speed);
                    badusb.println('  done', speed);
                    badusb.println('}', speed);
                    badusb.press('ENTER');
                    delay(ms);
                    badusb.println('users=(', speed);
                    badusb.println('  camille_jenatzy', speed);
                    badusb.println('  gaston_chasseloup', speed);
                    badusb.println('  leon_serpollet', speed);
                    badusb.println('  william_vanderbilt', speed);
                    badusb.println('  henri_fournier', speed);
                    badusb.println('  maurice_augieres', speed);
                    badusb.println('  arthur_duray', speed);
                    badusb.println('  henry_ford', speed);
                    badusb.println('  louis_rigolly', speed);
                    badusb.println('  pierre_caters', speed);
                    badusb.println('  paul_baras', speed);
                    badusb.println('  victor_hemery', speed);
                    badusb.println('  fred_marriott', speed);
                    badusb.println('  lydston_hornsted', speed);
                    badusb.println('  kenelm_guinness', speed);
                    badusb.println('  rene_thomas', speed);
                    badusb.println('  ernest_eldridge', speed);
                    badusb.println('  malcolm_campbell', speed);
                    badusb.println('  ray_keech', speed);
                    badusb.println('  john_cobb', speed);
                    badusb.println('  dorothy_levitt', speed);
                    badusb.println('  paula_murphy', speed);
                    badusb.println('  betty_skelton', speed);
                    badusb.println('  rachel_kushner', speed);
                    badusb.println('  kitty_oneil', speed);
                    badusb.println('  jessi_combs', speed);
                    badusb.println('  andy_green', speed);
                    badusb.println(')', speed);
                    badusb.println('key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCcM4aDj8Y4COv+f8bd2WsrIynlbRGgDj2+q9aBeW1Umj5euxnO1vWsjfkpKnyE/ORsI6gkkME9ojAzNAPquWMh2YG+n11FB1iZl2S6yuZB7dkVQZSKpVYwRvZv2RnYDQdcVnX9oWMiGrBWEAi4jxcYykz8nunaO2SxjEwzuKdW8lnnh2BvOO9RkzmSXIIdPYgSf8bFFC7XFMfRrlMXlsxbG3u/NaFjirfvcXKexz06L6qYUzob8IBPsKGaRjO+vEdg6B4lH1lMk1JQ4GtGOJH6zePfB6Gf7rp31261VRfkpbpaDAznTzh7bgpq78E7SenatNbezLDaGq3Zra3j53u7XaSVipkW0S3YcXczhte2J9kvo6u6s094vrcQfB9YigH4KhXpCErFk08NkYAEJDdqFqXIjvzsro+2/EW1KKB9aNPSSM9EZzhYc+cBAl4+ohmEPej1m15vcpw3k+kpo1NC2rwEXIFxmvTme1A2oIZZBpgzUqfmvSPwLXF0EyfN9Lk= SCORING KEY DO NOT REMOVE"', speed);
                    badusb.press('ENTER');
                    delay(ms);
                    badusb.println('# Function to restart SSH service', speed);
                    badusb.println('restart_ssh() {', speed);
                    badusb.println('  sudo systemctl restart sshd', speed);
                    badusb.println('}', speed);
                    badusb.press('ENTER');
                    delay(ms);
                    badusb.println('# Main script logic', speed);
                    badusb.println('if [[ $1 == "i" ]]; then', speed);
                    badusb.println('  make_immutable', speed);
                    badusb.println('elif [[ $1 == "w" ]]; then', speed);
                    badusb.println('  remove_immutable', speed);
                    badusb.println('elif [[ $1 == "e" ]]; then', speed);
                    badusb.println('  edit_sshd_config', speed);
                    badusb.println('elif [[ $1 == "key" ]]; then', speed);
                    badusb.println('  add_ssh_keys $users $key', speed);
                    badusb.println('elif [[ $1 == "p" ]]; then', speed);
                    badusb.println('  change_passwords', speed);
                    badusb.println('elif [[ $1 == "r" ]]; then', speed);
                    badusb.println('  restart_ssh', speed);
                    badusb.println('elif [[ $1 == "a" ]]; then', speed);
                    badusb.println('  make_immutable', speed);
                    badusb.println('  add_ssh_keys $users $key', speed);
                    badusb.println('  restart_ssh', speed);
                    badusb.println('elif [[ $1 == "l" ]]; then', speed);
                    badusb.println('  cat /tmp/ssh_script.log', speed);
                    badusb.println('else', speed);
                    badusb.println('  echo "Usage: $0 {option}"', speed);
                    badusb.println('  echo "Options:"', speed);
                    badusb.println('  echo "  i     Make sshd_config immutable"', speed);
                    badusb.println('  echo "  w     Write/remove immutable attribute from sshd_config"', speed);
                    badusb.println('  echo "  e     Edit sshd_config"', speed);
                    badusb.println('  echo "  key   Add SSH keys to users"', speed);
                    badusb.println('  echo "  r     Restart SSH service"', speed);
                    badusb.println('  echo "  a     Run i, key, r"', speed);
                    badusb.println('  echo "  l     Show log"', speed);
                    badusb.println('  exit 1', speed);
                    badusb.println('fi', speed);
                }
            }
        }
        
        else if (r === 3) {  //Paste File
            print("\nBadUSB: Paste File");
            if (badusb.isConnected()) {
                notify.blink("green", "short");
                print("USB is connected");
                let delay = 20;

                let file = read_file('/ext/env/paste.txt');
                for (let i = 0; i < file.length; i++) {
                    if (file.length == 1) {
                        badusb.print(file[i], delay);
                    } else {
                        badusb.println(file[i], delay);
                    }
                }
                
                notify.success();
            } else {usb_nc()}
        }
    }

    // Optional, but allows to interchange with usbdisk
    badusb.quit();
}

function usb_nc() {
    print("USB not connected");
    notify.error();
    delay(1000);
    dialog.message("BadUSB", "Connect to USB");
}

function read_file(path) {
    if (!storage.exists(path)) {
        print("File does not exist: "+path);
        notify.error();
        let r = dialog.message("File does not exist:", path);
        return [];
    }
    let file = storage.read(path);
    if (!file) {
        print("Error reading file: "+path);
        print(file);
        notify.error();
        let r = dialog.message("Error reading file:", path);
        return [];
    }
    return file.split('\n');
}

main();