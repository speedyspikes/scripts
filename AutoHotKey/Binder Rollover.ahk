#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode('Input')
SetWorkingDir(A_ScriptDir)
SetKeyDelay(10)

author := "Speedy_Spikes"
last_updated := "11/3/2025"

year := 2026 ; Change this value to the current year as needed

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

F8::ExitApp()

!/:: { ; Help Menu
    MsgBox(
        'Script:  ' A_ScriptName '`n'
        'Author:  ' author '`n'
        'Last Updated:  ' last_updated '`n`n'
        'Commands:`n'
        'F2 => Save File(s)`n'
        'F3 => Change Name`n'
        'F4 => Change Year`n'
        '`nF8 => Quit Script`n'
        'F9 => Window Name`n'
    )
}


WindowCheck(name) {
    x := 1
    while x != 0 {
        if WinActive(name)
            x := -1
        if x >= 10 {
            result := MsgBox(
                "The window '" name "' isn't open.`n"
                "Try opening manually, then press 'Retry'.",
                "Program Error",
                0x1042 ; 0x1000 (Abort/Retry/Ignore) + 0x40 (Icon Error) + 0x2 (Default button 2)
            )
            if result = "Abort"
                return "Abort"
            if result = "Ignore"
                return "Continue"
            WinActivate(name)
            x := 0
        }
        Sleep(500)
        x++
    }
    return
}


F9:: {
    title := WinGetTitle('A')
    MsgBox('The active window is "' title '".')
}


F2:: { ; Save File(s)
    Send('{Alt down}f')
    Sleep(100)
    Send('s')
    Sleep(100)
    Send('f{Alt up}')
    Sleep(200)
    Send('{Down}{Down}{Space}{Enter}')
}


F3:: { ; Mark xxx
    Send('{Alt down}f')
    Sleep(100)
    Send('i{Alt up}')
    Sleep(200)
    Send('{Left}xxx')
}


F4:: { ; Change year
    Send('{Alt down}f')
    Sleep(100)
    Send('i{Alt up}')
    Sleep(200)
    _check := WindowCheck("Workpaper Properties")
    if _check = "Abort" {
        MsgBox("Automation has been aborted.")
        return
    }
    Send('{Tab}{Right}{Left}{Backspace}{Backspace}{Backspace}{Backspace}' year)
}


; XButton1::MsgBox('You pressed: XButton1')
XButton2::Send('{Enter}')
; XButton3::ToolTip('You pressed: XButton3')
; XButton4::ToolTip('You pressed: XButton4')
; XButton5::ToolTip('You pressed: XButton5')