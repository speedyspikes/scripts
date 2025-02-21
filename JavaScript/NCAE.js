let badusb = require("badusb");
let keyboard = require("keyboard");
let notify = require("notification");
let dialog = require("dialog");
let submenu = require("submenu");


badusb.setup({
    vid: 0xAAAA,
    pid: 0xBBBB,
    mfr_name: "Flipper",
    prod_name: "Zero",
    layout_path: "/ext/badusb/assets/layouts/en-US.kl"
});


// let r = dialog.message(__filepath.slice(13), "Press OK to start");

while (true) {
    submenu.addItem("Network", 0);
    // submenu.addItem("1", 1);
    // submenu.addItem("2", 2);
    // submenu.addItem("3", 3);
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
                            badusb.press('TAB')
                            
                            notify.success();
                        } else {
                            print("USB not connected");
                            notify.error();
                            delay(1000);
                            dialog.message("BadUSB", "Connect to USB");
                        }
                    }
                    
                    else if (r2 === 1) {  //data
                        if (badusb.isConnected()) {
                            notify.blink("green", "short");
                            
                            badusb.println('      addresses:');
                            badusb.println('        - 172.18.26.'+keyboard.text(4, "")+'/16');
                            badusb.println('      gateway4: 172.18.0.1');
                            badusb.println('      nameservers:');
                            badusb.println('        addresses:');
                            badusb.print('          - 172.18.0.1');
                            
                            notify.success();
                        } else {
                            print("USB not connected");
                            notify.error();
                            delay(1000);
                            dialog.message("BadUSB", "Connect to USB");
                        }
                    }

                    else if (r2 === 2) {  //apply
                        if (badusb.isConnected()) {
                            notify.blink("green", "short");
                            
                            badusb.println('sudo netplan apply');
                            
                            notify.success();
                        } else {
                            print("USB not connected");
                            notify.error();
                            delay(1000);
                            dialog.message("BadUSB", "Connect to USB");
                        }
                    }
                }
            }

            else if (r1 === 1) {  //CentOS
                print("\nBadUSB: Ubuntu Network");
                while (true) {
                    submenu.addItem("vi", 0);
                    submenu.addItem("data", 1);
                    submenu.addItem("save", 2);
                    submenu.addItem("apply", 2);
                    let r2 = submenu.show();
                    if (r2 === undefined) {break}
                
                    else if (r2 === 0) {  //vi
                        if (badusb.isConnected()) {
                            notify.blink("green", "short");
                            
                            badusb.print('sudo vi /etc/sysconfig/network-scripts/ifcfg-e');
                            badusb.press('TAB')
                            
                            notify.success();
                        } else {
                            print("USB not connected");
                            notify.error();
                            delay(1000);
                            dialog.message("BadUSB", "Connect to USB");
                        }
                    }
                    
                    else if (r2 === 1) {  //data
                        if (badusb.isConnected()) {
                            notify.blink("green", "short");
                            
                            badusb.print('IPADDR=172.18.26.'); badusb.println(keyboard.text(4, ""));
                            badusb.println('NETMASK=16');
                            badusb.println('GATEWAY=172.18.0.1');
                            badusb.print('DNS1=172.18.0.1');
                            
                            notify.success();
                        } else {
                            print("USB not connected");
                            notify.error();
                            delay(1000);
                            dialog.message("BadUSB", "Connect to USB");
                        }
                    }

                    else if (r2 === 2) {  //save
                        if (badusb.isConnected()) {
                            notify.blink("green", "short");
                            
                            badusb.push('ESCAPE');
                            badusb.println(':wq');
                            
                            notify.success();
                        } else {
                            print("USB not connected");
                            notify.error();
                            delay(1000);
                            dialog.message("BadUSB", "Connect to USB");
                        }
                    }

                    else if (r2 === 3) {  //apply
                        if (badusb.isConnected()) {
                            notify.blink("green", "short");
                            
                            badusb.println('sudo systemctl restart NetworkManager');
                            
                            notify.success();
                        } else {
                            print("USB not connected");
                            notify.error();
                            delay(1000);
                            dialog.message("BadUSB", "Connect to USB");
                        }
                    }
                }
            }
        }
    }
    
 /*    else if (r === 1) {  //Splashtop
        print("\nBadUSB: Splashtop");
        if (badusb.isConnected()) {
            notify.blink("green", "short");
            print("USB is connected");
            
            badusb.press("GUI", "r");
            delay(500);
            badusb.println('"H:\\Public\\Splashtop\\Splashtop_Streamer_Windows_DEPLOY_INSTALLER_v3.7.2.0_SL5ASSP4S44H.exe"');
            delay(3000);
            badusb.press("LEFT");
            delay(100);
            badusb.press("ENTER");
            delay(3000);
            badusb.press("LEFT");
            delay(100);
            badusb.press("ENTER");
            
            notify.success();
        } else {
            print("USB not connected");
            notify.error();
            delay(1000);
            dialog.message("BadUSB", "Connect to USB");
        }
    }
    
    else if (r === 2) {  //Adobe
        print("\nBadUSB: Adobe");
        if (badusb.isConnected()) {
            notify.blink("green", "short");
            print("USB is connected");
            
            badusb.press("GUI", "r");
            delay(500);
            badusb.println('"H:\\Public\\Adobe\\Adobe Cleaner Tool\\AdobeCreativeCloudCleanerTool.exe"');
            delay(2000);
            badusb.press("LEFT");
            delay(100);
            badusb.press("ENTER");
            delay(2000);
            badusb.press("LEFT");
            delay(100);
            badusb.press("ENTER");
            delay(3000);
            badusb.println("e", 100);
            badusb.println("y", 500);
            badusb.println("1");
            
            notify.success();
        } else {
            print("USB not connected");
            notify.error();
            delay(1000);
            dialog.message("BadUSB", "Connect to USB");
        }
    }
    
    else if (r === 3) {  //LocalAdmin
        print("\nBadUSB: LocalAdmin");
        if (badusb.isConnected()) {
            notify.blink("green", "short");
            print("USB is connected");
            
            badusb.press("GUI", "r");
            delay(500);
            badusb.print("cmd");
            badusb.hold("SHIFT");
            badusb.press("CTRL", "ENTER");
            badusb.release("SHIFT");
            delay(1500);
            badusb.press("LEFT");
            delay(100);
            badusb.press("ENTER");
            delay(1000);
            // badusb.print('Xcopy /E \\\\dcestorage02.byu.edu\\repository\\dceadmin C:\\Users\\');
            badusb.println("cd \\");
            badusb.println("mkdir dceadmin");
            badusb.println("copy NUL dceadmin\\dceadmin.txt");
            badusb.print("shutdown -r");
            
            notify.success();
        } else {
            print("USB not connected");
            notify.error();
            delay(1000);
            dialog.message("BadUSB", "Connect to USB");
        }
    } */
}


// Optional, but allows to interchange with usbdisk
badusb.quit();