#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1
SetKeyDelay, -1
CoordMode, Mouse, Screen

F8::ExitApp

F2:: ; Begin Clicking
    while (true) 
    {
        MouseMove, 260, 600
        Click
        ; Press 2 to pause clicking
        GetKeyState, state, 2
        if (state = "D") {
            return
        }
    }
return

Numpad0::
    MouseMove, 1430, 230
    Click
return

Numpad1:: ; Cursor
    MouseMove, 1430, 340
    Click
return

Numpad2:: ; Grandma
    MouseMove, 1430, 400
    Click
return

Numpad3:: ; Farm
    MouseMove, 1430, 460
    Click
return

Numpad4:: ; Mine
    MouseMove, 1430, 530
    Click
return

Numpad5:: ; Factory
    MouseMove, 1430, 600
    Click
return

Numpad6:: ; Bank
    MouseMove, 1430, 660
    Click
return

Numpad7:: ; Temple
    MouseMove, 1430, 720
    Click
return

Numpad8:: ; Wizard Tower
    MouseMove, 1430, 780
    Click
return

Numpad9:: ; ?
    MouseMove, 1430, 850
    Click
return