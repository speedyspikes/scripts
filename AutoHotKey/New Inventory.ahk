#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetKeyDelay, .01

author := "TJ Law"
last_updated := "4/20/2023"

/*
This is an AutoHotKey automation. This is not a direct API to anything. It uses
keyboard strokes for the majority of interactions with programs. This is why
you will see {Tab} and {Enter} so often in these scripts. That is how the
websites are navigated using this automation. Because of this, there may be
errors if not used properly. Please follow all instructions carefully.

^ = Ctrl
+ = Shift
! = Alt
*/

!/:: ; Help Window
    MsgBox,
    ( LTrim
    Help Menu for "New Inventory" AutoHotKey Script

    F2 => New Item
    F8 => Quit Script

    Author: %author%
    Last Updated: %last_updated%
    )
return


F8::ExitApp


F2:: ; New Inventory
    ; Use these variables to change values.
    ; Asset ID is defined when script is ran.
    category := "Computer - Desktop"
    manufacturer := "Dell"
    ; Serial Number is defined after Asset ID.
    description := ""
    model := "OPTIPLEX MICRO PLUS 7010"
    purchaseDate := ""
    replacementDate := ""               ; } These should all be auto populated for Dells
    warrantyExpirationDate := ""        ; } when the service tag is used properly
    poNumber := ""                      ; }
    assignAssetToWorkstation := true
    workstation := "4-00666" ; CMP - Storage
    
    quickSave := true   ; Change this to true if you want to press enter to save after scanning.

    InputBox, assetID, Asset ID, Asset ID
    if ErrorLevel {
        MsgBox, Automation aborted
        return
    }
    InputBox, serial, Serial Number, Serial Number
    if ErrorLevel {
        MsgBox, Automation aborted
        return
    }

    OpenSite("https://ceregadmin.byu.edu/o3/admin/inventory/assetInfo/mode/new", "BYU - Division of Continuing Education")
    Sleep, 1000
    Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}
    Send % assetID
    Send, {Tab}
    Send % category
    Send, {Tab}
    Send % manufacturer
    Send, {Tab}
    Send % serial
    Send, {Tab}
    Send % description
    Send, {Tab}
    Send % model
    Send, {Tab}
    if (purchaseDate != "") {
        Send % purchaseDate
        Send, {Enter}
    }
    Send, {Tab}
    if (replacementDate != "") {
        Send % replacementDate
        Send, {Enter}
    }
    Send, {Tab}
    if (warrantyExpirationDate != "") {
        Send % warrantyExpirationDate
        Send, {Enter}
    }
    Send, {Tab}
    Send % poNumber
    Sleep, 500
    if (quickSave) {
        MsgBox, 4097, New Inventory, 
        ( LTrim
        Asset ID:                   %assetID%
        Category:                   %category%
        Manufacturer:               %manufacturer%
        Serial Number:              %serial%
        Description:                %description%
        Model:                      %model%
        Purchase Date:              %purchaseDate%
        Replacement Date:           %replacementDate%
        Warranty Expiration Date:   %warrantyExpirationDate%
        PO Number:                  %poNumber%
        
        Check to make sure everything is correct. 
        Press "OK" to save.
        )
        IfMsgBox, Cancel
            return
        Sleep, 100
        Send, {Shift down}
        Loop, 10
        {
            Send, {Tab}
        }
        Send, {Shift up}
        Sleep, 100
        Send, {Enter}
        Sleep, 100
    } else {
        MsgBox, 4097, New Inventory, Click save before pressing "OK"
        IfMsgBox, Cancel
            return
    }
    if (assignAssetToWorkstation) {
        Sleep, 2000
        Loop, 19
        {
            Send, {Tab}
        }
        Send, {Enter}
        Sleep, 300
        Send % workstation
        Sleep, 100
        MsgBox, 4096, New Inventory, Click on the workstation and assign., 5
        IfMsgBox, Cancel
            return
    }
return


OpenSite(site, name) {
    /*
    Open website and check that the window has the correct name. 
    If the correct website doesn't show up in 10 seconds, prompt
    them to sign into BYU account (most common error). Reopen
    the website after the user presses "OK."
    */
    Run, %site%
    Sleep, 1000
    x := 1
    while(x != 0) {
        IfWinActive % name
            x := -1
        if (x >= 10) {
            MsgBox, 4097, Sign in Checker, 
            ( LTrim
            Please sign into your BYU account, then press "OK" to continue.
            )
            IfMsgBox Cancel
                return "Cancel"
            Run % site
            x := 0
        }
        Sleep, 1000
        x++
    }
}
