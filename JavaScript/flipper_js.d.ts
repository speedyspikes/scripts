// flipper_js.d.ts


// BadUSB Module
declare module "badusb" {
    /**
     * Configures the Flipper Zero as a BadUSB device.
     * @param config Configuration object including VID, PID, manufacturer name, product name, and layout path.
    */
    export function setup(config: { vid: number, pid: number, mfr_name: string, prod_name: string, layout_path: string }): void;

    /** 
     * Quits BadUSB mode and reverts the Flipper USB port to normal.
     */
    export function quit(): void;

    /**
     * Checks if the Flipper is connected to a computer.
     * @returns True if connected, false otherwise.
    */
   export function isConnected(): boolean;

    /**
    * Presses and releases a key combination.
    * @param keys The keys to press.
    */
    export function press(...keys: string[]): void;

    /**
    * Holds down a key combination.
    * @param keys The keys to hold.
    */
    export function hold(...keys: string[]): void;

    /**
    * Releases a key combination that was held down.
    * @param keys The keys to release.
    */
    export function release(...keys: string[]): void;

    /** 
     * Releases all held keys.
     */ 
    export function releaseAll(): void;

    /**
     * Types the string specified.
     * @param text The text to type.
     * @param delay Optional delay in milliseconds before returning.
     */
    export function print(text: string, delay?: number): void;

    /**
     * Types the string and presses Enter at the end.
     * @param text The text to type.
     * @param delay Optional delay in milliseconds before returning.
     */
    export function println(text: string, delay?: number): void;

    /**
     * Types the string specified using the numeric keypad.
     * @param text The text to type.
     * @param delay Optional delay in milliseconds before returning.
     */
    export function altPrint(text: string, delay?: number): void;

    /**
     * Types the string specified using the numeric keypad and presses Enter.
     * @param text The text to type.
     * @param delay Optional delay in milliseconds before returning.
     */
    export function altPrintln(text: string, delay?: number): void;
}


declare module "blebeacon" {
    export function setConfig(mac: string, power: number, interval: number, timeout: number): void;
    export function setData(data: Uint8Array): void;
    export function start(): void;
}

declare module "serial" {
    export function setup(type: string, baudrate: number): void;
    export function readBytes(length: number, timeout: number): Uint8Array | undefined;
    export function write(data: Uint8Array): void;
}

declare module "usbdisk" {
    export function start(imagePath: string): void;
    export function wasEjected(): boolean;
    export function stop(): void;
}

declare module "subghz" {
    export function setup(): void;
    export function setFrequency(frequency: number): void;
    export function transmitFile(filePath: string): void;
}

declare module "textbox" {
    export function setConfig(alignment: string, textMode: string): void;
    export function clearText(): void;
    export function addText(text: string): void;
    export function show(): void;
    export function isOpen(): boolean;
    export function close(): void;
}

declare module "submenu" {
    export function addItem(name: string, value: number): void;
    export function setHeader(header: string): void;
    export function show(): number;
}

declare module "notification" {
    export function error(): void;
    export function success(): void;
}

declare module "storage" {
    export function write(filePath: string, data: string): void;
    export function append(filePath: string, data: string): void;
    export function read(filePath: string): Uint8Array;
    export function remove(filePath: string): void;
    export function listFiles(directory: string): string[];
}

declare module "settings" {
    export function set(key: string, value: any): void;
    export function get(key: string): any;
}

declare module "infrared" {
    export function transmit(filePath: string): void;
    export function receive(): Uint8Array;
}

declare module "nfc" {
    export function read(): Uint8Array;
    export function write(data: string): void;
}

declare module "gpio" {
    export function init(pin: string, mode: string, pull: string): void;
    export function startAnalog(value: number): void;
    export function readAnalog(pin: string): number;
    export function write(pin: string, value: boolean): void;
    export function read(pin: string): boolean;
}