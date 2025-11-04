#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
;SetKeyDelay, 100000

F8::
ExitApp

`::
Send, Reading: {Tab}{Tab}
Send, Ethics{Tab}{Tab}
; Send, {Enter}
; Sleep, 300
; Send, {Down}{Down}{Down} ;{Down}
; Sleep, 300
; Send, {Enter}
; Sleep, 300
Send, {Tab}{Tab}{Enter}
Sleep, 300
Send, {Tab}
Sleep, 100
Send, Ethics
Sleep, 100
Send, {Tab}{Enter}
Sleep, 300
Send, {Esc}{Tab}{Tab}{Tab}{Tab}{Right}
