#Requires AutoHotKey v2.0
#SingleInstance Force
; SendMode('Input')
SetWorkingDir(A_ScriptDir)
SetKeyDelay(10)

author := "Speedy_Spikes"
last_updated := "11/6/2025"

year := 2026 ; Change this value to the current year as needed
turbo_mode := true ; Set to true to skip confirmation prompts

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
XButton2::Send('{Enter}')

!/:: { ; Help Menu
    MsgBox(
        'Script:  ' A_ScriptName '`n'
        'Author:  ' author '`n'
        'Last Updated:  ' last_updated '`n`n'
        'Commands:`n'
        'F2 => Save File(s)`n'
        'F3 => Change Name`n'
        'F4 => Change Year`n'
        'F5 => Create Placeholder`n'
        '`nF8 => Quit Script`n'
        'F9 => Window Name`n'
    )
}



WindowCheck(name) {
    while !WinWait(name, , 5) {
        result := MsgBox(
            "The window '" name "' isn't open.`n"
            "Try opening manually, then press 'Retry'.",
            "Program Error",
            0x1042
        )
        if result = "Abort"
            return "Abort"
        if result = "Ignore"
            return "Continue"
        WinActivate(name)
        WinWait(name)
    }
}


MvMouse(x, y) { ; Moves mouse in relation to client more reliably with multiple monitors
    WinGetPos(&winX, &winY, &winW, &winH, 'A')
    screenX := winX + x
    screenY := winY + y
    DllCall("SetCursorPos", "int", screenX, "int", screenY)
}


F9:: { ; Window Name
    title := WinGetTitle('A')
    MsgBox('The active window is "' title '".')
}


F10:: { ; Test
    MouseGetPos(, &y)
    WinGetPos(&winX, &winY, &winW, &winH, 'A')
    screenX := winX + 170
    screenY := winY + 200
    DllCall("SetCursorPos", "int", screenX, "int", screenY)
}


F2:: { ; Save File(s)
    Send('{Alt down}f')
    Sleep(100)
    Send('s')
    Sleep(100)
    Send('f{Alt up}')
    Sleep(100)
    if WindowCheck("File Format") = "Abort" {
        return MsgBox("Automation has been aborted.")
    }
    Send('{Tab}{Tab}{Space}')
    Sleep(100)
    Send('{Enter}')
}


F3:: { ; Mark xxx
    Send('{Alt down}f')
    Sleep(100)
    Send('i{Alt up}')
    Sleep(200)
    if WindowCheck("Workpaper Properties") = "Abort" {
        return MsgBox("Automation has been aborted.")
    }
    Send('{Left}xxx')
}


F4:: { ; Change year
    if WindowCheck("ahk_exe PFXEngagement.exe") = "Abort" {
        return MsgBox("Automation has been aborted.")
    }
    Send('{Alt down}f')
    Sleep(100)
    Send('i{Alt up}')
    Sleep(100)
    if WindowCheck("Workpaper Properties") = "Abort" {
        return MsgBox("Automation has been aborted.")
    }
    Send('{Tab}')
    Sleep(100)
    Send('^c')
    name := RegExReplace(A_Clipboard, "20\d\d", year) ; Change Year
    Send(name)
    ;Send('{Tab}{Right}{Left}{Backspace}{Backspace}{Backspace}{Backspace}' year)
}


F5:: { ; Create Placeholder
    if WindowCheck("ahk_exe PFXEngagement.exe") = "Abort" {
        return MsgBox("Automation has been aborted.")
    }
    ; Open properties to copy name
    Send('{Alt down}f')
    Sleep(100)
    Send('i{Alt up}')
    Sleep(100)
    if WindowCheck("Workpaper Properties") = "Abort" {
        return MsgBox("Automation has been aborted.")
    }
    Send('^c')
    Sleep(200)
    index := RegExReplace(A_Clipboard, "^x+") ; Remove leading x's
    Send('{Tab}')
    Send('^c')
    Sleep(100)
    Send('{Escape}')
    name := RegExReplace(A_Clipboard, "v\d+(?:_\d+)+", "vX_XX") ; Replace version
    name := RegExReplace(name, "20\d\d", year) ; Change Year
    ; if !turbo_mode {
    ;     Sleep(100)
    ;     result := MsgBox('Hover over folder of where to create placeholder: ' index ' ' name
    ;         '`nThen press ENTER', 'Create Placeholder', 0x1)
    ;     if result = "Cancel" {
    ;             return MsgBox("Automation has been aborted.")
    ;     }
    ; }
    ; CoordMode("Mouse", "Client")
    Sleep(100)
    ; WinGetPos(&winX, &winY, &winW, &winH, 'A')
    ; MouseGetPos(, &y)
    ; if !(180 > y > winH) {
    ;     y := 200
    ; }
    MvMouse(170, 200) ; Move mouse to folder location
    MouseClick("left")
    Sleep(100)
    Send('{Left}{Alt down}f')
    Sleep(100)
    Send('n')
    Sleep(100)
    Send('l{Alt up}')
    Sleep(100)
    if WindowCheck("New Placeholder") = "Abort" {
        return MsgBox("Automation has been aborted.")
    }
    Send(index '{Tab}' name)
    MvMouse(340, 520) ; Move mouse to OK button
}


; XButton1::MsgBox('You pressed: XButton1')
; XButton3::ToolTip('You pressed: XButton3')
; XButton4::ToolTip('You pressed: XButton4')
; XButton5::ToolTip('You pressed: XButton5')