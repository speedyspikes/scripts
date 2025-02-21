let badusb = require("badusb");
let notify = require("notification");
let dialog = require("dialog");
let submenu = require("submenu");
let usbdisk = require("usbdisk");
let storage = require("storage");
let keyboard = require("keyboard");

usbdisk.start("/ext/apps_data/mass_storage/Text.img");
print("USBDisk mounted");
while (!usbdisk.wasEjected()) {delay(5000);}
usbdisk.stop();
print("USBDisk unmounted");

storage.virtualInit("/ext/apps_data/mass_storage/Text.img");
storage.virtualMount();
print("Storage mounted");
let txt_file = storage.read("/mnt/Text/text.txt");
print("Read text file");
storage.virtualQuit();
print("Storage unmounted");
let lines = txt_file.split("/\r?\n/");
print(lines);
delay(1000);
/*
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
    // submenu.addItem("2", 2);
    // submenu.addItem("3", 3);
    let r = submenu.show();
    if (r === undefined) {break}
    
    else if (r === 0) {  //Network
    }
}*/