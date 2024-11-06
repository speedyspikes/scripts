/* flipper_js.d.ts
These functions have been referenced from these sources:
https://github.com/jamisonderek/flipper-zero-tutorials/wiki/JavaScript
https://gist.github.com/cagataycali/08358b88ca4eda09c181df7e5368d783
*/

// Globals

// globals-console
declare namespace console {
    /**
     * Logs an error message with optional additional data.
     * @param message The main error message.
     * @param optionalParams Additional parameters to include in the error output.
     */
    function error(message: any, ...optionalParams: any[]): void;

    /**
     * Logs a warning message.
     * @param message The main warning message.
     * @param optionalParams Additional parameters to include in the warning output.
     */
    function warn(message: any, ...optionalParams: any[]): void;

    /**
     * Logs an informational message.
     * @param message The main info message.
     * @param optionalParams Additional parameters to include in the log output.
     */
    function log(message: any, ...optionalParams: any[]): void;

    /**
     * Logs a debug message.
     * @param message The main debug message.
     * @param optionalParams Additional parameters to include in the debug output.
     */
    function debug(message: any, ...optionalParams: any[]): void
}

// globals-delay
/**
 * Pauses execution for a specified number of milliseconds.
 * @param milliseconds The number of milliseconds to delay.
 */
declare function delay(milliseconds: number): void;

// globals-print
/**
 * Prints a message to the Flipper Zero console.
 * Accepts multiple types of arguments including strings, numbers, and booleans.
 * @param args The message or data to print.
 */
declare function print(...args: any[]): void;

// globals-require
/**
 * Imports a module.
 * @param moduleName The name of the module to import.
 * @returns The module object.
 */
declare function require(moduleName: string): any;

// globals-parse-int
/**
 * Parses a string and returns an integer.
 * @param numString The string to parse.
 * @returns The parsed integer.
 */
declare function parse_int(numString: string): number;

// globals-to-string
/**
 * Converts a number to a string.
 * @param num The number to convert.
 * @returns The string representation of the number.
 */
declare function to_string(num: number): string;

// globals-to-hex-string
/**
 * Converts a number to a hexadecimal string.
 * @param num The number to convert.
 * @returns The hexadecimal string representation of the number.
 */
declare function to_hex_string(num: number): string;

// globals-to-lower-case
/**
 * Converts a string to lowercase.
 * @param str The string to convert.
 * @returns The lowercase version of the string.
 */
declare function to_lower_case(str: string): string;

// globals-to-upper-case
/**
 * Converts a string to uppercase.
 * @param str The string to convert.
 * @returns The uppercase version of the string.
 */
declare function to_upper_case(str: string): string;

// globals-filepath
/**
 * The full path to the JavaScript file being run.
 */
declare const __filepath: string;

// globals-filepath
/**
 * The directory path where the JavaScript file is being run from.
 */
declare const __dirpath: string;


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


// BLEBeacon Module
/**
 * The blebeacon module provides functions for Bluetooth Low Energy (BLE) beacon messaging.
 */
declare module "blebeacon" {
    /**
     * Checks if the BLE beacon is active.
     * @returns True if the beacon is active, or an error if unable to determine.
     */
    function isActive(): boolean | Error;

    /**
     * Configures the BLE beacon settings, such as MAC address, transmission power, and interval.
     * @param mac The MAC address as a Uint8Array.
     * @param power The power level (optional).
     * @param intvMin The minimum advertisement interval in milliseconds (optional).
     * @param intvMax The maximum advertisement interval in milliseconds (optional).
     * @returns Undefined if successful, or an error if unable to set configuration.
     */
    function setConfig(mac: Uint8Array, power?: number, intvMin?: number, intvMax?: number): void | Error;

    /**
     * Sets the data to be broadcast by the BLE beacon.
     * @param data The data to broadcast as a Uint8Array.
     * @returns Undefined if successful, or an error if unable to set data.
     */
    function setData(data: Uint8Array): void | Error;

    /**
     * Starts the BLE beacon.
     * @returns Undefined if successful, or an error if unable to start.
     */
    function start(): void | Error;

    /**
     * Stops the BLE beacon.
     * @returns Undefined if successful, or an error if unable to stop.
     */
    function stop(): void | Error;

    /**
     * Sets the beacon to keep alive, which prevents it from automatically stopping.
     * @param keep True to keep the beacon alive, false to allow automatic stopping.
     * @returns Undefined if successful, or an error if unable to set keep-alive state.
     */
    function keepAlive(keep: boolean): void | Error;
}


// Dialog Module
/**
 * The dialog module provides functions to display messages and allow user interactions.
 */
declare module "dialog" {
    /**
     * Displays a custom dialog with specified header, text, and optional buttons.
     * If the "back" button is pressed, it returns an empty string.
     * @param params An object containing header, text, and optional button labels for left, center, and right.
     * @returns The label of the button pressed (left, center, or right) as a string, or an error if the dialog failed to display.
     */
    function custom(params: {
        header: string;
        text: string;
        button_left?: string;
        button_center?: string;
        button_right?: string;
    }): string | Error;

    /**
     * Displays a message dialog with specified header and text, and an "OK" button.
     * @param header The header text for the message.
     * @param text The body text for the message.
     * @returns True if "OK" was pressed, false if the "back" button was pressed.
     */
    function message(header: string, text: string): boolean | Error;

    /**
     * Prompts the user to select a file from a specified directory with a specified extension.
     * @param path The starting directory path for file selection.
     * @param ext The file extension to filter by (use "*" to allow all files).
     * @returns The file path of the selected file as a string, or an error if the dialog failed to display.
     */
    function pickFile(path: string, ext: string): string | Error;
}


// Flipper Module
/**
 * The flipper module provides functions to access device-specific information for the Flipper Zero.
 */
declare module "flipper" {
    /**
     * Retrieves the model of the Flipper Zero device (e.g., "Flipper Zero").
     * @returns The model name as a string.
     */
    function getModel(): string;

    /**
     * Retrieves the unique name of the Flipper Zero device.
     * @returns The device's name as a string.
     */
    function getName(): string;

    /**
     * Retrieves the current battery level of the Flipper Zero as a percentage.
     * @returns The battery level as a number.
     */
    function getBatteryCharge(): number;
}


// GPIO Module
/**
 * The gpio module provides functions to access and control GPIO pins on the Flipper Zero.
 */
declare module "gpio" {
    /**
     * Configures a GPIO pin with the specified mode and pull resistor.
     * @param pin - The name of the pin to configure (e.g., "PA7", "PA6", etc.).
     * @param mode - The mode for the pin (e.g., "input", "outputPushPull", "outputOpenDrain", "analog").
     * @param pull - The pull configuration ("no", "up", or "down").
     * @returns `undefined` if successful, or an error if configuration fails.
     */
    function init(pin: string, mode: string, pull: string): void | Error;

    /**
     * Reads the digital state of a configured input pin.
     * @param pin - The name of the pin to read (e.g., "PA4").
     * @returns `true` if high, `false` if low, or an error if reading fails.
     */
    function read(pin: string): boolean | Error;

    /**
     * Writes a digital state to a configured output pin.
     * @param pin - The name of the pin to write (e.g., "PA7").
     * @param data - `true` to set the pin high, `false` to set it low.
     * @returns `undefined` if successful, or an error if writing fails.
     */
    function write(pin: string, data: boolean): void | Error;

    /**
     * Initializes the Flipper Zero for reading analog signals with a specified reference voltage.
     * Must be called before using `readAnalog`.
     * @param scale - Optional reference voltage range (either 2048 or 2500).
     * @returns `undefined` if successful.
     */
    function startAnalog(scale?: number): void;

    /**
     * Disables analog reading mode.
     * Must be called before reinitializing with `startAnalog`.
     * @returns `undefined` if successful.
     */
    function stopAnalog(): void;

    /**
     * Reads the analog voltage on a specified pin.
     * @param pin - The name of the analog-capable pin to read (e.g., "PA7", "PA6", etc.).
     * @returns The measured voltage in millivolts or an error if reading fails.
     */
    function readAnalog(pin: string): number | Error;
}


// Keyboard Module
/**
 * The keyboard module provides functions for text or hex data input on the Flipper Zero.
 */
declare module "keyboard" {
    /**
     * Sets the header text displayed by the `text` and `byte` input prompts.
     * @param header - The header text to display.
     * @returns `undefined` if successful, or an error if setting the header fails.
     */
    function setHeader(header: string): void | Error;

    /**
     * Prompts the user to enter text and returns the inputted text.
     * If the user presses the back button, `undefined` is returned.
     * @param allocSize - The amount of memory to allocate, including a byte for the null-terminator (e.g., pass 9 for an 8-character limit).
     * @param defaultText - The default text to display.
     * @param selected - If `true`, the text is pre-selected, allowing for quick replacement.
     * @returns The entered text, `undefined` if the user presses back, or an error if input fails.
     */
    function text(allocSize: number, defaultText: string, selected: boolean): string | undefined | Error;

    /**
     * Prompts the user to enter a hex value and returns it as a Uint8Array.
     * If the user presses the back button, `undefined` is returned.
     * @param numBytes - The number of bytes for the hex value.
     * @param data - The initial hex value to display.
     * @returns The entered hex value as a Uint8Array, `undefined` if the user presses back, or an error if input fails.
     */
    function byte(numBytes: number, data: Uint8Array): Uint8Array | undefined | Error;
}



declare module "notification" {
    export function error(): void;
    export function success(): void;
}

declare module "serial" {
    export function setup(type: string, baudrate: number): void;
    export function readBytes(length: number, timeout: number): Uint8Array | undefined;
    export function write(data: Uint8Array): void;
}

declare module "storage" {
    export function write(filePath: string, data: string): void;
    export function append(filePath: string, data: string): void;
    export function read(filePath: string): Uint8Array;
    export function remove(filePath: string): void;
    export function listFiles(directory: string): string[];
}

declare module "subghz" {
    export function setup(): void;
    export function setFrequency(frequency: number): void;
    export function transmitFile(filePath: string): void;
}

declare module "submenu" {
    export function addItem(name: string, value: number): void;
    export function setHeader(header: string): void;
    export function show(): number;
}

declare module "textbox" {
    export function setConfig(alignment: string, textMode: string): void;
    export function clearText(): void;
    export function addText(text: string): void;
    export function show(): void;
    export function isOpen(): boolean;
    export function close(): void;
}

declare module "usbdisk" {
    export function start(imagePath: string): void;
    export function wasEjected(): boolean;
    export function stop(): void;
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