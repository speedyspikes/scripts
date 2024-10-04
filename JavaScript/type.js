let badusb = require("badusb");
let notify = require("notification");
let flipper = require("flipper");
let dialog = require("dialog");


badusb.setup({
    vid: 0xAAAA,
    pid: 0xBBBB,
    mfr_name: "Flipper",
    prod_name: "Zero",
    layout_path: "/ext/badusb/assets/layouts/en-US.kl"
});
let r = dialog.message(__filepath.slice(13), "Press OK to start");
if (!r) {die('Canceled')}

if (badusb.isConnected()) {
    notify.blink("green", "short");
    print("USB is connected");

    badusb.print(
        "I was fast asleep. You stood there by the bedside, waiting to haunt by day. " +
        "Someday we might meet; I won't shed a tear, for the things that you stole. Your " +
        "roots go far and deep, they strangle. Frantic breathing needed to stay afloat.",
    35)

    notify.success();
} else {
    print("USB not connected");
    notify.error();
}

// Optional, but allows to interchange with usbdisk
badusb.quit();

