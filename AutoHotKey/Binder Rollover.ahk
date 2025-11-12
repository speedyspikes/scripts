#Requires AutoHotKey v2.0
#SingleInstance Force
; SendMode('Input')
SetWorkingDir(A_ScriptDir)
; SetKeyDelay(10)
; DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")

author := "Speedy_Spikes"
last_updated := "11/11/2025"

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

year := 2026 ; Change this value to the current year as needed
turbo_mode := false ; Set to true to skip confirmation prompts

F8::ExitApp()
XButton2::Send('{Enter}')

!/:: { ; Help Menu
    MsgBox(
        'Script:  ' A_ScriptName '`n'
        'Author:  ' author '`n'
        'Last Updated:  ' last_updated '`n`n'
        'Commands:`n'
        'F2 => Save File(s)`n'
        'F3 => Add xxx to Name`n'
        'F4 => Create Placeholder`n'
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


MvMouse(x, y) { ; Moves mouse in relation to window more reliably with multiple monitors
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
    input := InputBox("How many files are in the folder?", "File Count")
    MsgBox(input.Result "`n" input.Value)
}


F2:: { ; Save File(s)
    Send('{Alt down}f')
    Sleep(100)
    Send('s')
    Sleep(100)
    Send('f{Alt up}')
    Sleep(100)
    if WindowCheck("File Format") = "Abort" {
        return MsgBox("Automation has been aborted.", "Notice", "T5")
    }
    Send('{Tab}{Tab}{Space}')
    Sleep(100)
    Send('{Enter}')
}


F3:: { ; Mark xxx
    input := InputBox("How many files are in the folder?", "File Count")
    if (input.Result = "Cancel") {
        return
    }
    fileCount := input.Value
    if (fileCount = "") {
        fileCount := 1
    }
    Loop fileCount {
        if WindowCheck("ahk_exe PFXEngagement.exe") = "Abort" {
            return MsgBox("Automation has been aborted.", "Notice", "T5")
        }
        Send('{Alt down}f')
        Sleep(100)
        Send('i{Alt up}')
        Sleep(200)
        if WindowCheck("Workpaper Properties") = "Abort" {
            return MsgBox("Automation has been aborted.", "Notice", "T5")
        }
        Send('{Left}xxx{Enter}')
        if (A_Index < fileCount) {
            Sleep(200)
            MvMouse(170, 200) ; Move mouse to folder location
            MouseClick("left")
            Sleep(100)
            Send('{Left}{Down}')
            Sleep(200)
        }
    }
}


F4:: { ; Create Placeholder
    G := Object()
    aGui := Gui()
    aGui.Add("Text", "x10 y10", "How many files are in the folder?`n(not including placeholders)")
    aGui.AddEdit("vfiles x168 y13 w20", 1)
    aGui.Add("Text", "x10 y45", "How many placeholders are `nalready created?")
    aGui.AddEdit("vdone x168 y48 w20", 0)
    aGui.Add("Button", "x142 y80 default", "Submit").OnEvent("Click", (*)=>(G := aGui.Submit()))
    aGui.OnEvent("Close", (*)=>(G := false, aGui.Destroy()))
    aGui.Show()
    WinWaitClose(aGui)
    if (!G) {
        return
    }

    Loop (G.files - G.done) {
        if WindowCheck("ahk_exe PFXEngagement.exe") = "Abort" {
            return MsgBox("Automation has been aborted.", "Notice", "T5")
        }
        ; Open properties to copy name
        Send('{Alt down}f')
        Sleep(100)
        Send('i{Alt up}')
        if WindowCheck("Workpaper Properties") = "Abort" {
            return MsgBox("Automation has been aborted.", "Notice", "T5")
        }
        Sleep(100)
        Send('^c')
        Sleep(200)
        index := RegExReplace(A_Clipboard, "^x+") ; Remove leading x's
        Send('{Tab}')
        Send('^c')
        Sleep(100)
        Send('{Escape}')
        name := RegExReplace(A_Clipboard, "v\d+(?:_\d+)+", "vX_XX") ; Replace version
        name := RegExReplace(name, "20\d\d", year) ; Change Year
        Sleep(100)
        MvMouse(170, 200) ; Move mouse to folder location
        MouseClick("left")
        Sleep(200)
        Send('{Left}{Alt down}f')
        Sleep(200)
        Send('n')
        Sleep(200)
        Send('l{Alt up}')
        Sleep(100)
        if WindowCheck("New Placeholder") = "Abort" {
            return MsgBox("Automation has been aborted.", "Notice", "T5")
        }
        Send(index '{Tab}' name)
        if (turbo_mode) {
            Sleep(200)
            Send('{Enter}')
        } else {
            MvMouse(340, 520) ; Move mouse to OK button
        }
        WinWaitClose("New Placeholder")
        if (A_Index < G.files - G.done) {
            Sleep(200)
            MvMouse(170, 200) ; Move mouse to folder location
            MouseClick("left")
            Sleep(100)
            Loop (G.done * 2 + A_Index * 2 + 1) {
                Send('{Down}')
                Sleep(100)
            }
            Sleep(500)
        }
    }
}