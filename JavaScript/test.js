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

    badusb.println(
        "I am printing this.\n" +
        "I am also printing this.",
    10)
    badusb.println("I'm going to compare the print speed of nothing and 0. It will probably be the same.")
    badusb.println("I'm going to compare the print speed of nothing and 0. It will probably be the same.", 0)
    badusb.println("I'm going to print this slow.", 500)
    badusb.println("Super speeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed!", 0)
    badusb.println("And back to this.", 20)

    notify.success();
} else {
    print("USB not connected");
    notify.error();
}

// Optional, but allows to interchange with usbdisk
badusb.quit();

