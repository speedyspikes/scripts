#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetKeyDelay, .01

author := "TJ Law"
last_updated := "3/7/2024"

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
    Help Menu for "Splashtop File Transfer" AutoHotKey Script

    F2 => File Transfer
    F8 => Quit Script

    Author: %author%
    Last Updated: %last_updated%
    )
return


F8::ExitApp


F2:: ; File Transfer
    ; source location of file to be transfered
    file_source := "C:\Users\" . %A_UserName% . "\Downloads\"
    ; location to transfer file to
    file_destination := "C:\Users\istesting\Desktop"

    
    MsgBox, 4097, Splashtop File Transfer, 
    ( LTrim
    Make sure the computer you want to transfer the file to
    is at the top of the list and that it is turne on. You 
    can do this by searching for the exact name and check 
    if the computer icon is blue.
    )
    IfMsgBox Cancel 
    {
        MsgBox, Automation has been aborted.
        return
    }
    WinActivate, ahk_exe strwinclt.exe
    Sleep, 200
    MouseMove, 393, 132
    Click
    Click
    Sleep, 200

    MsgBox, 4097, Splashtop File Transfer,
    ( LTrim
    Login to the computer, 
    then press OK to continue the automation.
    )
    Sleep, 200
    MouseMove, 264, 140
    Click
    Send % file_source

return