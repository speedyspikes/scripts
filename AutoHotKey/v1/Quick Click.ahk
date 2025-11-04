#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; SetBatchLines, -1
; SetKeyDelay, -1
; CoordMode, Mouse, Screen

F8::ExitApp

F2:: ; Begin Clicking
    MouseMove, 861, 184
    Sleep, 50
    Click
    Sleep, 100
    MouseMove, 866, 388
    Sleep, 50
    Click
    Sleep, 100
    MouseMove, 866, 965
    Sleep, 50
    Click
    Sleep, 100
    MouseMove, 1037, 819
    Sleep, 50
    Click
    Sleep, 500
    MouseMove, 830, 772
    Sleep, 50
    Click
    Send % clipboard
    Sleep, 1000
    Send, {Enter}
return