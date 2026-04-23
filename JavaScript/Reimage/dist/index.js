"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// import modules
// caution: `eventLoop` HAS to be imported before `gui`, and `gui` HAS to be
// imported before any `gui` submodules.
const eventLoop = require("@next-flip/fz-sdk-mntm/event_loop");
const gui = require("@next-flip/fz-sdk-mntm/gui");
const dialog = require("@next-flip/fz-sdk-mntm/gui/dialog");
// a common pattern is to declare all the views that your app uses on one object
const views = {
    dialog: dialog.makeWith({
        header: "Hello from Reimage",
        text: "Check out index.ts and\nchange something :)",
        center: "Gonna do that!",
    }),
};
// stop app on center button press
eventLoop.subscribe(views.dialog.input, (_sub, button, eventLoop) => {
    if (button === "center")
        eventLoop.stop();
}, eventLoop);
// stop app on back button press
eventLoop.subscribe(gui.viewDispatcher.navigation, (_sub, _item, eventLoop) => {
    eventLoop.stop();
}, eventLoop);
// run app
gui.viewDispatcher.switchTo(views.dialog);
eventLoop.run();
