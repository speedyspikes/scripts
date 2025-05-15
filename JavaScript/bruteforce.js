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
        submenu.addItem("Start", 0);
        // submenu.addItem("Passwords", 1);
        // submenu.addItem("SSH", 2);
        // submenu.addItem("Paste", 3);
        // submenu.addItem("Git Clone", 4);
        let r = submenu.show();
        if (r === undefined) {break}
        
        else if (r === 0) {  //Start
            if (badusb.isConnected()) {
                for (let number = 49000; number <= 99999; number++) {
                    let num = to_string(number);
                    badusb.println('c2ctf{' + num + '}');
                    delay(50);
                    badusb.press("GUI", "a");
                }
            } else {usb_nc();}
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



main();