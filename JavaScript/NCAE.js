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
                                
                                badusb.push('ESCAPE');
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
                // submenu.addItem("CentOS", 1);
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
                                
                                badusb.push('ESCAPE');
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
                /*
                else if (r1 === 1) {  //1
                    print("\nBadUSB: 1");
                    while (true) {
                        submenu.addItem("vi", 0);
                        submenu.addItem("data", 1);
                        submenu.addItem("save", 2);
                        submenu.addItem("apply", 3);
                        let r2 = submenu.show();
                        if (r2 === undefined) {break}
                    
                    }
                }*/
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