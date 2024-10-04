let badusb = require("badusb");
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
    submenu.addItem("Easy Uninstall", 0);
    submenu.addItem("Splashtop", 1);
    submenu.addItem("Adobe", 2);
    submenu.addItem("LocalAdmin", 3);
    let r = submenu.show();
    if (r === undefined) {break}
    
    else if (r === 0) {  //Easy Uninstall
        print("\nBadUSB: Easy Uninstall");
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
            badusb.println('"C:\\Program Files\\Mozilla Firefox\\uninstall\\helper.exe" /s');
            badusb.println('"C:\\Program Files\\Notepad++\\uninstall.exe" /S');
            
            notify.success();
        } else {
            print("USB not connected");
            notify.error();
            delay(1000);
            dialog.message("BadUSB", "Connect to USB");
        }
    }
    
    else if (r === 1) {  //Splashtop
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
            badusb.println("cd \\Users");
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
    }
}


// Optional, but allows to interchange with usbdisk
badusb.quit();