// These passwords are for competition only

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
    submenu.addItem("vagrant", 0);
    submenu.addItem("artoo_detoo", 1);
    submenu.addItem("boba_fett", 2);
    submenu.addItem("greedi", 3);
    submenu.addItem("han_solo", 4);
    submenu.addItem("metasploitable", 5);
    let r = submenu.show();
    if (r === undefined) {break}
    
    else if (r === 0) {  //vagrant
        print("\nBadUSB: vagrant");
        if (badusb.isConnected()) {
            notify.blink("green", "short");
            print("USB is connected");
            
            badusb.print("Po03kJ0LGqV1qC");
            
            notify.success();
        } else {
            print("USB not connected");
            notify.error();
            delay(1000);
            dialog.message("BadUSB", "Connect to USB");
        }
    }
    
    
    else if (r === 1) {  //artoo_detoo
        print("\nBadUSB: artoo_detoo");
        if (badusb.isConnected()) {
            notify.blink("green", "short");
            print("USB is connected");
            
            badusb.print("UwitI42FqfdEHj");
            
            notify.success();
        } else {
            print("USB not connected");
            notify.error();
            delay(1000);
            dialog.message("BadUSB", "Connect to USB");
        }
    }
    
    
    else if (r === 2) {  //boba_fett
        print("\nBadUSB: boba_fett");
        if (badusb.isConnected()) {
            notify.blink("green", "short");
            print("USB is connected");
            
            badusb.print("2FfhSTHLgbIIP7");
            
            notify.success();
        } else {
            print("USB not connected");
            notify.error();
            delay(1000);
            dialog.message("BadUSB", "Connect to USB");
        }
    }
    
    
    else if (r === 3) {  //greedi
        print("\nBadUSB: greedi");
        if (badusb.isConnected()) {
            notify.blink("green", "short");
            print("USB is connected");
            
            badusb.print("0Thetd0bmKR1oS");
            
            notify.success();
        } else {
            print("USB not connected");
            notify.error();
            delay(1000);
            dialog.message("BadUSB", "Connect to USB");
        }
    }
    
    
    else if (r === 4) {  //han_solo
        print("\nBadUSB: han_solo");
        if (badusb.isConnected()) {
            notify.blink("green", "short");
            print("USB is connected");
            
            badusb.print("gWv8bgyn6OxOCO");
            
            notify.success();
        } else {
            print("USB not connected");
            notify.error();
            delay(1000);
            dialog.message("BadUSB", "Connect to USB");
        }
    }
    
    
    else if (r === 5) {  //metasploitable
        print("\nBadUSB: metasploitable");
        if (badusb.isConnected()) {
            notify.blink("green", "short");
            print("USB is connected");
            
            badusb.print("wCA1ouJFOtZzV9");
            
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