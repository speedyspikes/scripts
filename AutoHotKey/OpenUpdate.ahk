#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

author := "TJ Law"
last_updated := "11/16/2022"

/*
This automation opens "Windows Update" and "Dell Command | Update"

^ = Ctrl
+ = Shift
! = Alt
*/

; Loop Files, %A_ProgramFiles%\*.exe, R  ; Recurse into subfolders.
; {
;     if (A_Index > 1210)
;         MsgBox, 4, , Filename = %A_LoopFileFullPath%`n`nContinue?
;         IfMsgBox, No
;             break
; }
; Run, C:\Program Files\WindowsApps\DellInc.DellCommandUpdate.*\DCU.Classic\DellCommandUpdate.exe

Run, ms-settings:windowsupdate
Sleep, 200
Send, ^{Esc}
Sleep, 500
Send, Dell Command
Sleep, 500
Send, {Enter}
ExitApp

F8::ExitApp