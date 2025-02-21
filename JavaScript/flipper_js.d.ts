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


// Math Module
/**
 * The math module provides a variety of mathematical functions and constants.
 */
declare module "math" {
    /**
     * Returns the absolute value of a number.
     * @param x - The input number.
     * @returns The absolute value of `x`, or `undefined` if the operation fails.
     */
    function abs(x: number): number | undefined;

    /**
     * Returns the arccosine (inverse cosine) of a number.
     * @param x - The input number.
     * @returns The arccosine of `x`, or NaN if the input is out of range.
     */
    function acos(x: number): number;

    /**
     * Returns the hyperbolic arccosine of a number.
     * @param x - The input number.
     * @returns The hyperbolic arccosine of `x`, `undefined` if out of range, or an error if the operation fails.
     */
    function acosh(x: number): number | undefined | Error;

    /**
     * Returns the arcsine (inverse sine) of a number.
     * @param x - The input number.
     * @returns The arcsine of `x`, or an error if the input is out of range.
     */
    function asin(x: number): number | Error;

    /**
     * Returns the hyperbolic arcsine of a number.
     * @param x - The input number.
     * @returns The hyperbolic arcsine of `x`, or an error if the operation fails.
     */
    function asinh(x: number): number | Error;

    /**
     * Returns the arctangent (inverse tangent) of a number.
     * @param x - The input number.
     * @returns The arctangent of `x`, or an error if the operation fails.
     */
    function atan(x: number): number | Error;

    /**
     * Returns the arctangent of `y / x`, using the signs of both arguments to determine the correct quadrant.
     * @param y - The y-coordinate.
     * @param x - The x-coordinate.
     * @returns The arctangent of `y / x`, or an error if the operation fails.
     */
    function atan2(y: number, x: number): number | Error;

    /**
     * Returns the hyperbolic arctangent of a number.
     * @param x - The input number.
     * @returns The hyperbolic arctangent of `x`, or an error if the operation fails.
     */
    function atanh(x: number): number | Error;

    /**
     * Returns the cube root of a number.
     * @param x - The input number.
     * @returns The cube root of `x`, or an error if the operation fails.
     */
    function cbrt(x: number): number | Error;

    /**
     * Rounds a number up to the next largest integer.
     * @param x - The input number.
     * @returns The smallest integer greater than or equal to `x`, or an error if the operation fails.
     */
    function ceil(x: number): number | Error;

    /**
     * Returns the number of leading zero bits in the 32-bit binary representation of a number.
     * @param x - The input number.
     * @returns The number of leading zero bits, or an error if the operation fails.
     */
    function clz32(x: number): number | Error;

    /**
     * Returns the cosine of a number.
     * @param x - The input number.
     * @returns The cosine of `x`, or an error if the operation fails.
     */
    function cos(x: number): number | Error;

    /**
     * Returns `e` raised to the power of a number.
     * @param x - The exponent.
     * @returns `e^x`, or an error if the operation fails.
     */
    function exp(x: number): number | Error;

    /**
     * Rounds a number down to the nearest integer.
     * @param x - The input number.
     * @returns The largest integer less than or equal to `x`, or an error if the operation fails.
     */
    function floor(x: number): number | Error;

    /**
     * Determines if two values are equal within a specified delta.
     * @param x - The first number to compare.
     * @param y - The second number to compare.
     * @param delta - The allowable difference between `x` and `y`.
     * @returns `true` if the values are equal within delta, otherwise `false`.
     */
    function isEqual(x: number, y: number, delta: number): boolean | Error;

    /**
     * Returns the natural logarithm (base e) of a number.
     * @param x - The input number.
     * @returns The natural logarithm of `x`, or an error if the operation fails.
     */
    function log(x: number): number | Error;

    /**
     * Returns the maximum of two numbers.
     * @param x - The first number.
     * @param y - The second number.
     * @returns The larger of `x` and `y`, or an error if the operation fails.
     */
    function max(x: number, y: number): number | Error;

    /**
     * Returns the minimum of two numbers.
     * @param x - The first number.
     * @param y - The second number.
     * @returns The smaller of `x` and `y`, or an error if the operation fails.
     */
    function min(x: number, y: number): number | Error;

    /**
     * Returns `base` raised to the power of `exponent`.
     * @param base - The base number.
     * @param exponent - The exponent.
     * @returns The result of `base^exponent`, or an error if the operation fails.
     */
    function pow(base: number, exponent: number): number | Error;

    /**
     * Generates a random number between 0 (inclusive) and 2 (exclusive).
     * @returns A random number in the range [0, 2), or an error if the operation fails.
     */
    function random(): number | Error;

    /**
     * Returns the sign of a number.
     * @param x - The input number.
     * @returns `1` if `x` is positive, `-1` if `x` is negative, `0` if `x` is zero, or an error if the operation fails.
     */
    function sign(x: number): number | Error;

    /**
     * Returns the sine of a number.
     * @param x - The input number.
     * @returns The sine of `x`, or an error if the operation fails.
     */
    function sin(x: number): number | Error;

    /**
     * Returns the square root of a number.
     * @param x - The input number.
     * @returns The square root of `x`, or an error if the operation fails.
     */
    function sqrt(x: number): number | Error;

    /**
     * Truncates the fractional part of a number, leaving only the integer part.
     * @param x - The input number.
     * @returns The integer part of `x`, or an error if the operation fails.
     */
    function trunc(x: number): number | Error;

    /**
     * Represents the constant pi (π).
     */
    const PI: number;

    /**
     * Represents the base of natural logarithms, e.
     */
    const E: number;

    /**
     * Represents the smallest positive number greater than zero that can be represented as a double.
     */
    const EPSILON: number;
}


// Notification Module
/**
 * The notification module provides functions to interact with the Flipper Zero's status LED, sounds, and vibration for user feedback.
 */
declare module "notification" {
    /**
     * Indicates a successful action to the user.
     * The status LED blinks green, the Flipper vibrates, and a "do-de-da-lat" success sound is played.
     */
    function success(): void;

    /**
     * Indicates an error to the user.
     * The status LED blinks red, the Flipper vibrates, and a "do-do" error sound is played.
     */
    function error(): void;

    /**
     * Causes the status LED to blink in the specified color and duration.
     * @param color - The color of the LED blink. Supported colors are "blue", "red", "green", "yellow", "cyan", "magenta".
     * @param type - The type of blink duration. Supported types are "short" and "long".
     * @returns `undefined` on success, or an error if the operation fails.
     */
    function blink(color: "blue" | "red" | "green" | "yellow" | "cyan" | "magenta", type: "short" | "long"): void | Error;
}


// Serial Module
/**
 * The serial module provides functions for USART and LPUART communication on the Flipper Zero.
 */
declare module "serial" {
    /**
     * Initializes the serial port with the specified port and baud rate.
     * Once initialized, the port cannot be re-initialized until `end` is called.
     * @param port - The port to use; either "usart" (pins 13 & 14) or "lpuart" (pins 15 & 16).
     * @param baudrate - The baud rate for the serial communication.
     * @returns `undefined` on success, or an error if the operation fails.
     */
    function setup(port: "usart" | "lpuart", baudrate: number): void | Error;

    /**
     * Deinitializes the serial port.
     * Should only be called after `setup` has been called.
     * @returns `undefined` on success, or an error if the operation fails.
     */
    function end(): void | Error;

    /**
     * Sends data on the serial port.
     * The port must already be initialized. The data can be a string, number, or array of numbers.
     * Each number in the array must be in the range 0x00 to 0xFF.
     * @param data - The data to send. Can be a string, a single byte (number), or an array of bytes (Uint8Array or number[]).
     * @returns `undefined` on success, or an error if the operation fails.
     */
    function write(data: string | number | Uint8Array | number[]): void | Error;

    /**
     * Reads a specified number of bytes from the serial port as a string.
     * @param readlen - The number of bytes to read.
     * @param timeout - Optional timeout in milliseconds to wait for data.
     * @returns The read data as a string, `undefined` if no data is received, or an error if the operation fails.
     */
    function read(readlen: number, timeout?: number): string | undefined | Error;

    /**
     * Reads a line (ending in a newline) from the serial port as a string.
     * @param timeout - Optional timeout in milliseconds to wait for data.
     * @returns The read line as a string, `undefined` if no data is received, or an error if the operation fails.
     */
    function readln(timeout?: number): string | undefined | Error;

    /**
     * Reads a specified number of bytes from the serial port as an array of numbers.
     * @param readlen - The number of bytes to read.
     * @param timeout - Optional timeout in milliseconds to wait for data.
     * @returns The read data as an array of numbers, `undefined` if no data is received, or an error if the operation fails.
     */
    function readBytes(readlen: number, timeout?: number): number[] | undefined | Error;

    /**
     * Reads any available data from the serial port as a string.
     * @param timeout - Optional timeout in milliseconds to wait for data.
     * @returns The read data as a string, `undefined` if no data is received, or an error if the operation fails.
     */
    function readAny(timeout?: number): string | undefined | Error;

    /**
     * Reads data from the serial port until a specified string or byte pattern is matched.
     * @param expectData - The data to expect, specified as a string or array of bytes.
     * @param timeout - Optional timeout in milliseconds to wait for data.
     * @returns The index at which the expected data was matched, `undefined` if not matched, or an error if the operation fails.
     */
    function expect(expectData: string | number[], timeout?: number): number | undefined | Error;
}


// Storage Module
/**
 * The storage module provides functions for accessing and managing files on the Flipper Zero's SD card.
 */
declare module "storage" {
    /**
     * Reads the contents of a file as a string.
     * Version 1: Reads the file at the specified path up to 128KB.
     * Version 2: Reads the file from the specified offset up to the specified size as a binary array.
     * @param path - The file path.
     * @param size - Optional size in bytes to read (only for version 2).
     * @param offset - Optional offset in bytes to start reading from (only for version 2).
     * @returns The file contents as a string or a binary array, or an error if the operation fails.
     */
    function read(path: string, size?: number, offset?: number): string | Uint8Array | Error;

    /**
     * Writes data to a file, overwriting any existing file at the path.
     * Version 1: Writes a string to the specified path.
     * Version 2: Allows writing binary data.
     * @param path - The file path.
     * @param data - The data to write, either as a string or array.
     * @returns `true` on success, or an error if the operation fails.
     */
    function write(path: string, data: string | Uint8Array): boolean | Error;

    /**
     * Appends data to the end of a file.
     * @param path - The file path.
     * @param data - The data to append as a string.
     * @returns `true` on success, or an error if the operation fails.
     */
    function append(path: string, data: string): boolean | Error;

    /**
     * Copies a file from one path to another.
     * @param sourcePath - The path of the file to copy.
     * @param targetPath - The destination path.
     * @returns `true` on success, or an error if the operation fails.
     */
    function copy(sourcePath: string, targetPath: string): boolean | Error;

    /**
     * Moves (renames) a file from one path to another.
     * @param originalPath - The current file path.
     * @param newPath - The new file path.
     * @returns `true` on success, or an error if the operation fails.
     */
    function move(originalPath: string, newPath: string): boolean | Error;

    /**
     * Checks if a file exists at the specified path.
     * @param path - The file path.
     * @returns `true` if the file exists, `false` if it does not, or an error if the operation fails.
     */
    function exists(path: string): boolean | Error;

    /**
     * Creates a new directory at the specified path.
     * @param path - The directory path.
     * @returns `true` if the directory was created successfully, `false` otherwise.
     */
    function mkdir(path: string): boolean;

    /**
     * Removes a file at the specified path.
     * @param path - The file path.
     * @returns `true` if the file was removed successfully, or an error if the operation fails.
     */
    function remove(path: string): boolean | Error;

    /**
     * Initializes a virtual storage area by mapping it to a file.
     * @param path - The path to the file to map as virtual storage.
     * @returns `true` on success, or an error if the operation fails.
     */
    function virtualInit(path: string): boolean | Error;

    /**
     * Mounts virtual storage to the `/mnt/` folder.
     * @returns `undefined` on success, or an error if the operation fails.
     */
    function virtualMount(): void | Error;

    /**
     * Unmounts virtual storage from the `/mnt/` folder.
     * @returns `undefined` on success, or an error if the operation fails.
     */
    function virtualQuit(): void | Error;
}


// SubGHz Module
/**
 * The subghz module provides functions for accessing the subGHz radio on the Flipper Zero.
 */
declare module "subghz" {
    /**
     * Ends the current session, allowing setup to be called again.
     * Also used to check for an external module.
     */
    function end(): void;

    /**
     * Returns the current frequency in hertz of the received or last sent signal.
     * @returns The current frequency as a number.
     */
    function getFrequency(): number;

    /**
     * Returns the current RSSI (Receive Signal Strength Indicator) for the received signal.
     * The radio must be in receive mode.
     * @returns The current RSSI or an error if the operation fails.
     */
    function getRssi(): number | Error;

    /**
     * Returns the current state of the radio.
     * Valid states are "RX", "TX", "IDLE", or an empty string if uninitialized.
     * @returns The current radio state.
     */
    function getState(): "RX" | "TX" | "IDLE" | "";

    /**
     * Checks if an external CC1101 radio module is being used.
     * @returns `true` if an external radio is in use, otherwise `false`.
     */
    function isExternal(): boolean;

    /**
     * Sets the frequency of the radio.
     * The radio must be in the "IDLE" state before setting the frequency.
     * @param frequency - The frequency to set in hertz.
     * @returns The set frequency as a number, or an error if the operation fails.
     */
    function setFrequency(frequency: number): number | Error;

    /**
     * Sets the state of the radio to "IDLE".
     */
    function setIdle(): void;

    /**
     * Sets the state of the radio to "RX" (receive mode).
     */
    function setRx(): void;

    /**
     * Initializes the subGHz radio, configuring it to use an external radio if specified in firmware settings.
     * Sets the radio state to "IDLE" and defaults the frequency to 433.92 MHz.
     */
    function setup(): void;

    /**
     * Transmits a signal based on the specified .sub file.
     * The file can use a supported protocol or "RAW" format and will be transmitted on the frequency specified in the file.
     * The `getFrequency` value will be updated to this frequency.
     * Optionally, a repeat count can be provided to repeat the signal (not available on Xtreme FW).
     * @param file - The path to the .sub file.
     * @param repeat - Optional. The number of times to repeat the signal.
     * @returns `true` if transmission was successful, `undefined` if an error occurred, or an error if the operation fails.
     */
    function transmitFile(file: string, repeat?: number): boolean | undefined | Error;
}


// Submenu Module
/**
 * The submenu module provides functions to create and display a scrollable menu of items, returning the selected item.
 */
declare module "submenu" {
    /**
     * Adds a new entry to the menu.
     * @param label - The name of the entry to be displayed.
     * @param id - The identifier associated with this entry, which will be returned upon selection.
     * @returns `undefined` if successful, or an error if the operation fails.
     */
    function addItem(label: string, id: number): void | Error;

    /**
     * Sets the header label displayed at the top of the submenu.
     * @param label - The header text to display.
     * @returns `undefined` if successful, or an error if the operation fails.
     */
    function setHeader(label: string): void | Error;

    /**
     * Displays the submenu and waits for the user to select an item.
     * @returns The id of the selected item, or `undefined` if the user pressed the `Back` button.
     */
    function show(): number | undefined;
}


// Textbox Module
/**
 * The textbox module allows the creation of a dynamic display of text on the Flipper Zero.
 * Contents are displayed in a non-blocking way, enabling the script to continue running while updating the UI.
 * Users can scroll through the textbox, but focus resets when updated.
 */
declare module "textbox" {
    /**
     * Appends the specified text to the end of the textbox.
     * @param contents - The text to append to the textbox.
     * @returns `undefined` if successful, or an error if the operation fails.
     */
    function addText(contents: string): void | Error;

    /**
     * Closes the textbox.
     * @returns `undefined`.
     */
    function close(): void;

    /**
     * Clears the contents of the textbox.
     * @returns `undefined`.
     * @note On Xtreme firmware, this function is still called `emptyText`.
     */
    function clearText(): void;

    /**
     * Checks if the textbox is currently open and visible.
     * @returns `true` if the textbox is open, otherwise `false`.
     */
    function isOpen(): boolean;

    /**
     * Configures the textbox display settings.
     * @param focus - The focus position when the textbox is updated. Valid values are `"start"` and `"end"`.
     * @param font - The font to use in the textbox. Valid values are `"text"` and `"hex"`.
     * @returns `undefined` if successful, or an error if the operation fails.
     */
    function setConfig(focus: "start" | "end", font: "text" | "hex"): void | Error;

    /**
     * Displays the textbox. The textbox will remain visible until closed by either calling `close` or the user pressing the `Back` button.
     * @returns `undefined`.
     */
    function show(): void;
}


// Usbdisk Module
/**
 * The usbdisk module allows exposing a special file on the SD Card as a USB thumb drive via the Flipper Zero's USB port.
 * This feature enables easy file transfers between the host computer and the Flipper Zero.
 */
declare module "usbdisk" {
    /**
     * Creates a file that can be used as a virtual USB drive.
     * @param path - The path to the file on the SD card.
     * @param capacity - The size in bytes to reserve for the file.
     * @returns `undefined` if successful, or an error if the operation fails.
     */
    function createImage(path: string, capacity: number): void | Error;

    /**
     * Exposes the specified file as a USB drive.
     * @param path - The path to the file to expose as a USB drive.
     * @returns `undefined` if successful, or an error if the operation fails.
     */
    function start(path: string): void | Error;

    /**
     * Detaches the USB drive.
     * @returns `undefined`.
     */
    function stop(): void;

    /**
     * Checks if the USB drive has been ejected by the host computer.
     * @returns `true` if the USB drive has been ejected, otherwise `false`.
     */
    function wasEjected(): boolean | Error;
}


// VGM (Video Game Module) Module
/**
 * The vgm module allows access to the sensors of the Video Game Module (VGM) on the Flipper Zero.
 * It enables obtaining orientation data such as pitch, roll, and yaw, which is helpful for motion-based interactions.
 */
declare module "vgm" {
    /**
     * Returns the pitch (up/down angle) of the VGM in degrees, ranging from -90 to 90.
     * @returns The pitch angle in degrees.
     */
    function getPitch(): number;

    /**
     * Returns the roll (left/right tilt) of the VGM in degrees, ranging from -180 to 180.
     * @returns The roll angle in degrees.
     */
    function getRoll(): number;

    /**
     * Returns the yaw (rotation around the vertical axis) of the VGM in degrees, ranging from -180 to 180.
     * @returns The yaw angle in degrees.
     */
    function getYaw(): number;

    /**
     * Measures the change in yaw over time and returns the amount of change if it exceeds the specified threshold.
     * @param angle - The threshold of yaw change in degrees.
     * @param timeout - Optional timeout in milliseconds to wait for the yaw change. Defaults to an indefinite wait if not provided.
     * @returns The amount of yaw change if it exceeds the threshold, otherwise 0.
     */
    function deltaYaw(angle: number, timeout?: number): number;
}


// Widget Module
/**
 * The widget module enables non-blocking display of various UI elements on the Flipper Zero.
 * Elements can be added, displayed, and managed dynamically.
 */
declare module "widget" {
    /**
     * Adds a filled box at the specified (x, y) coordinates with width `w` and height `h`.
     * @param x - X coordinate (0 to 127).
     * @param y - Y coordinate (0 to 63).
     * @param w - Width of the box.
     * @param h - Height of the box.
     * @returns The ID of the created box for removal, or an error.
     */
    function addBox(x: number, y: number, w: number, h: number): number;

    /**
     * Adds a circle centered at (x, y) with radius `r`.
     * @param x - X coordinate.
     * @param y - Y coordinate.
     * @param r - Radius of the circle.
     * @returns The ID of the created circle for removal, or an error.
     */
    function addCircle(x: number, y: number, r: number): number;

    /**
     * Adds a filled disc centered at (x, y) with radius `r`.
     * @param x - X coordinate.
     * @param y - Y coordinate.
     * @param r - Radius of the disc.
     * @returns The ID of the created disc for removal, or an error.
     */
    function addDisc(x: number, y: number, r: number): number;

    /**
     * Sets a single pixel at (x, y).
     * @param x - X coordinate.
     * @param y - Y coordinate.
     * @returns The ID of the dot for removal, or an error.
     */
    function addDot(x: number, y: number): number;

    /**
     * Adds an outlined rectangle at (x, y) with width `w` and height `h`.
     * @param x - X coordinate.
     * @param y - Y coordinate.
     * @param w - Width of the rectangle.
     * @param h - Height of the rectangle.
     * @returns The ID of the created frame for removal, or an error.
     */
    function addFrame(x: number, y: number, w: number, h: number): number;

    /**
     * Adds a glyph at (x, y) specified by the character code `ch`.
     * @param x - X coordinate.
     * @param y - Y coordinate.
     * @param ch - Character code of the glyph.
     * @returns The ID of the created glyph for removal, or an error.
     */
    function addGlyph(x: number, y: number, ch: number): number;

    /**
     * Adds an icon at (x, y) using the specified icon name.
     * @param x - X coordinate.
     * @param y - Y coordinate.
     * @param icon - Name of the icon.
     * @returns The ID of the created icon for removal, or an error.
     */
    function addIcon(x: number, y: number, icon: string): number;

    /**
     * Draws a line from (x1, y1) to (x2, y2).
     * @param x1 - X coordinate of the start point.
     * @param y1 - Y coordinate of the start point.
     * @param x2 - X coordinate of the end point.
     * @param y2 - Y coordinate of the end point.
     * @returns The ID of the created line for removal, or an error.
     */
    function addLine(x1: number, y1: number, x2: number, y2: number): number;

    /**
     * Adds a filled box at (x, y) with width `w`, height `h`, and rounded corners with radius `r`.
     * @param x - X coordinate.
     * @param y - Y coordinate.
     * @param w - Width of the box.
     * @param h - Height of the box.
     * @param r - Radius of the rounded corners.
     * @returns The ID of the created rounded box for removal, or an error.
     */
    function addRbox(x: number, y: number, w: number, h: number, r: number): number;

    /**
     * Adds an outlined rectangle at (x, y) with width `w`, height `h`, and rounded corners with radius `r`.
     * @param x - X coordinate.
     * @param y - Y coordinate.
     * @param w - Width of the rectangle.
     * @param h - Height of the rectangle.
     * @param r - Radius of the rounded corners.
     * @returns The ID of the created rounded frame for removal, or an error.
     */
    function addRframe(x: number, y: number, w: number, h: number, r: number): number;

    /**
     * Adds text at (x, y) with the specified font.
     * @param x - X coordinate.
     * @param y - Y coordinate.
     * @param font - Font to use. Valid values are "Primary" and "Secondary".
     * @param text - Text to display.
     * @returns The ID of the created text element for removal, or an error.
     */
    function addText(x: number, y: number, font: string, text: string): number;

    /**
     * Adds an XBM image at (x, y) using the specified image identifier.
     * @param x - X coordinate.
     * @param y - Y coordinate.
     * @param index - Identifier of the XBM image.
     * @returns The ID of the created XBM image for removal, or an error.
     */
    function addXbm(x: number, y: number, index: number): number;

    /**
     * Closes the widget, removing it from the display.
     */
    function close(): void;

    /**
     * Loads an XBM image from a file, returning its identifier for use in `addXbm`.
     * @param path - Path to the XBM file.
     * @returns The identifier for the loaded image, or an error.
     */
    function loadImageXbm(path: string): number;

    /**
     * Removes a previously added widget element by its ID.
     * @param id - ID of the element to remove.
     * @returns `true` if the element was removed successfully, otherwise `false`.
     */
    function remove(id: number): boolean;

    /**
     * Checks if the widget is currently displayed.
     * @returns `true` if the widget is open, otherwise `false`.
     */
    function isOpen(): boolean;

    /**
     * Displays the widget, making it visible until closed.
     */
    function show(): void;
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