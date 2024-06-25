#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
; #Warn  ; Enable warnings to assist with detecting common errors.
;#Include edge.ahk
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetKeyDelay, .01

author := "SpeedySpikes"
last_updated := "6/25/2024"

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


; !ADD! 560


F8::ExitApp


!/:: ; Help Menu
    MsgBox,
    ( LTrim
    Script:  Service Desk Macros
    Author:  %author%
    Last Updated:  %last_updated%

    Commands:
    Ctrl+Shift+1 => New Help Desk Ticket
    Ctrl+Shift+2 => New Jabra Loan Ticket
    Ctrl+Shift+3 => New Hire Processing
    Ctrl+Shift+4 => Termination
    Ctrl+Shift+5 => Hardware/Software Request
    Ctrl+Shift+6 => Add AD Rights for multiple people
    Ctrl+Shift+7 => Check Rights
    Ctrl+Shift+9 => TEST New Hire Processing
    Ctrl+Shift+0 => TEST General

    F8 => Quit Script
    F9 => Window Name
    )
return


BrowserCheck() {
    ; Check if a supported browser is being used.
    SetTitleMatchMode, 2
    b := ""
    while (b == "") {
        ;Run, https://google.com
        x := 0
        while(x != 50) {
        IfWinActive, Edge
            b := "Edge"
        IfWinActive, Google Chrome
            b := "Chrome"
        IfWinActive, Vivaldi
            b := "Vivaldi"
            if (b != "") {
                x := 49
            }
            Sleep, 100
            x++
        }
        ;Send, ^w
        if (b == "") {
            MsgBox, 4354, Browser Checker,
            ( LTrim
            You are not using a supported browser as your default.

            Supported browsers:

            Microsoft Edge
            Google Chrome
            Vivaldi

            Please set one of these as your default in system preferences, then 
            click "Retry."

            If you would like to attempt to use your foreign browser, you may click
            "Ignore" and hope nothing breaks. Contact TJ if you would like to make
            a permanent solution.
            )
            IfMsgBox Abort
                return "Abort"
            IfMsgBox Ignore
                b := "Chrome"
        }
    }
    SetTitleMatchMode, 1
    return b
}


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
            If this site doesn't require a BYU account, please navigate to the 
            correct site, then continue.
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


OrionCheck(name) {
    /*
    Check if person is signed into Orion by checking the window name. 
    Display message if error.
    */
    ;MsgBox, Doing the thing.
    x := 1
    while(x != 0) {
        IfWinActive % name
            x := -1
        if (x >= 10) {
            MsgBox, 4354, Orion Checker, 
            ( LTrim
            If this person isn't showing in search results, they may need to 
            sign into Orion/Orion Test before we can give access.
            )
            IfMsgBox Abort                     
                return "Abort"
            IfMsgBox Ignore
                return "Continue"
            WinActivate, name
            x := 0
        }
        Sleep, 1000
        x++
    }
    return
}


ProgramCheck(name) {
    /*
    Check that the needed program is open using the window name. 
    Display message if error.
    */
    Sleep, 1000
    x := 1
    while(x != 0) {
        IfWinActive % name
            x := -1
        if (x >= 10) {
            MsgBox, 4354, Program Error, 
            ( LTrim
            The program '%name%' could not be opened.
            If the program is installed, try opening manually, 
            then press "Retry."
            )
            IfMsgBox Abort                     
                return "Abort"
            IfMsgBox Ignore
                return "Continue"
            WinActivate % name
            x := 0
        }
        Sleep, 1000
        x++
    }
    return
}


^+1:: ; Open new IT Help Ticket
    if (OpenSite("https://dcehelpdesk.byu.edu/jira/projects/DH/queues/custom/20", "Service project") == "Cancel") {
        MsgBox, Automation has been aborted.
        return
    }

    Send, c
    Sleep, 1000
    loop, 30
    {
        Send, {Tab}
    }
    Send, Default
    Send, {Enter}
    loop, 25
    {
        Send, {ShiftDown}{Tab}{ShiftUp}
    }
return


^+2:: ; Open Jabra Ticket
    if (OpenSite("https://dcehelpdesk.byu.edu/jira/projects/DH/queues/custom/20", "Service project") == "Cancel") {
        MsgBox, Automation has been aborted.
        return
    }
    
    Sleep, 200
    Send, c
    InputBox, jabra, Jabra, Jabra Number:
    Send, {Tab}{Tab}{Tab}
    Sleep, 400
    Send, Other
    Sleep, 200
    Send, {Enter}
    Sleep, 500
    Send, {Tab}{Tab}
    Send, Jabra %jabra%
    Sleep, 1000
    loop, 16
    {
        Send, {Tab}
    }
    Send, Please return Jabra to room 405 when meeting is over.
    Sleep, 500
    loop, 5
    {
        Send, {Tab}
    }
    Sleep, 500
    Send, Jabra
    Send, {Tab}
    Sleep, 500
    Send, Trivial
    Send, {Tab}{Tab}{Tab}
    Send, Default
    Send, {Tab}
return


^+0:: ; Test Script
    Run, ms-teams.exe
return


F9:: ; Window Name
    WinGetActiveTitle, title
    MsgBox, The active window is "%title%".
return


^+9:: ; New Hire Test Script
    gui, GuiName:New,,New Hire
    gui, Add, Text,, Use the hire form to input data below.
    gui, Add, Text,, First Name:
    gui, Add, Edit, vfirstName w140 x+5 yp-3, Emily
    gui, Add, Text, x-0
    gui, Add, Text, x+2.5, Last Name:
    gui, Add, Edit, vlastName w138 x+5 yp-5, Madsen
    gui, Add, Text, x-0
    gui, Add, Text, x+2.5, NetID:
    gui, Add, Edit, x+5 yp-5 vnetID w161 lowercase, emadsen7
    gui, Add, Text, x-0
    ; gui, Add, Text, x+2.5, Department:
    ; gui, Add, Edit, x+5 yp-5 vdept w134, Multimedia Services
    ; gui, Add, Text, x-0
    ; gui, Add, Text, x+2.5, Department ID:
    ; gui, Add, Edit, x+5 yp-5 vdeptID w120, 
    ; gui, Add, Text, x-0
    gui, Add, Text, x+2.5, Job Title:
    gui, Add, Edit, x+5 yp-5 vjob w149, Student Assistant
    gui, Add, Text, x-0
    gui, Add, Text, x+2.5, Supervisor:
    gui, Add, Edit, -WantReturn x+5 yp-5 vsupervisor w139, Tamara Moss
    gui, Add, Text, x-0
    gui, Add, Text, x+2.5, Classification:
    gui, Add, DropDownList, x+5 yp-5 w90 vclass, Student||Staff|Administrator
    gui, Add, Text, x-0
    gui, Add, Checkbox, checked0 vforms x+2.5, Active Forms
    gui, Add, Checkbox, checked0 vemail, Email
    gui, Add, Text, x-0
    gui, Add, Text, x+2.5, RingCentral: 
    gui, Add, DropDownList, x+5 yp-3 w100 vring, N/A||New Number|Add to Number
    gui, Add, Text, x-0
    gui, Add, Checkbox, checked0 vADRights x+2.5 yp-3, AD Rights
    gui, Add, Checkbox, checked0 vorion, Orion
    gui, Add, Checkbox, checked0 vorionTest, Orion Test
    gui, Add, Checkbox, checked0 vfsy, FSY Orion
    gui, Add, Checkbox, checked0 vgro, CRM/Gro
    gui, Add, Checkbox, checked0 vadobe, Adobe
    gui, Add, Checkbox, checked1 vmasterCourses, Master Courses
    gui, Add, Checkbox, checked0 vteamwork, Teamwork
    gui, Add, Edit, x+5 yp-5 vtwCompany w120, Company
    gui, Add, Text, x-0
    gui, Add, Checkbox, checked0 vnhe x+2.5 yp-3, New Hire Email
    gui, Add, Checkbox, checked0 vdoors, Doors
    gui, Add, Button, Default w80 gGoHire, Go
    gui, +AlwaysOnTop
    gui, Show, x2500 y200
    test := true
return


^+3:: ; New Hire Form Processing
    /*
    Open the spreadsheet with new hire info.
    Prompt a GUI with information required to process the hire form.
    */
    gui, GuiName:New,,New Hire
    gui, Add, Text,, Use the hire form to input data below.
    gui, Add, Text,, First Name:
    gui, Add, Edit, vfirstName w140 x+5 yp-3
    gui, Add, Text, x-0     ; This line is used for spacing fix
    gui, Add, Text, x+2.5, Last Name:
    gui, Add, Edit, vlastName w138 x+5 yp-3
    gui, Add, Text, x-0
    gui, Add, Text, x+2.5, NetID:
    gui, Add, Edit, x+5 yp-5 vnetID w161 lowercase
    gui, Add, Text, x-0
    ; gui, Add, Text, x+2.5, Department:
    ; gui, Add, Edit, x+5 yp-5 vdept w134
    ; gui, Add, Text, x-0
    ; gui, Add, Text, x+2.5, Department ID:
    ; gui, Add, Edit, x+5 yp-5 vdeptID w120
    ; gui, Add, Text, x-0
    gui, Add, Text, x+2.5, Job Title:
    gui, Add, Edit, x+5 yp-5 vjob w149
    gui, Add, Text, x-0
    gui, Add, Text, x+2.5, Supervisor:
    gui, Add, Edit, -WantReturn x+5 yp-5 vsupervisor w139
    gui, Add, Text, x-0
    gui, Add, Text, x+2.5, Classification:
    gui, Add, DropDownList, x+5 yp-5 w100 vclass, Student||Staff|Administrator
    gui, Add, Text, x-0
    gui, Add, Checkbox, checked1 vexcel x+2.5, Open rights file in Excel
    ; gui, Add, Text, x-0
    ; gui, Add, Checkbox, checked1 vforms x+2.5, Active Forms
    ; gui, Add, Checkbox, checked1 vemail, Email
    ; gui, Add, Checkbox, checked1 vADRights, AD Rights
    ; gui, Add, Checkbox, checked1 vnhe, New Hire Email
    ; gui, Add, Checkbox, checked0 vteamwork, Teamwork
    ; gui, Add, Edit, x+5 yp-5 vtwCompany w120, Company
    ; gui, Add, Text, x-0
    ; gui, Add, Checkbox, checked0 vorion x+2.5 yp-3, Orion
    ; gui, Add, Checkbox, checked0 vorionTest, Orion Test
    ; gui, Add, Checkbox, checked0 vgro, CRM/Gro
    ; gui, Add, Checkbox, checked0 vmasterCourses, Master Courses
    ; gui, Add, Checkbox, checked1 vdoors, Doors
    gui, Add, Button, Default w80 gGoRights, Go
    gui, +AlwaysOnTop
    gui, Show ;, x2500 y200
    test := false
return

GoRights:
    gui, submit

    name := firstName . " " . lastName

    ; Open the corresponding spreadsheet.
    workbook := 0
    if (class == "Student" && excel) {
        Run, C:\Users\%A_UserName%\Box\CE Help Desk\Documents\Access List - Student Employees.xlsx
        ProgramCheck("Access List - Student Employees.xlsx")
        ; Search for the supervisor. The "Find" window must have the options expanded.
        Sleep, 1000
        Send, ^f
        Sleep, 500
        Send, ^a
        Sleep, 200
        Send % supervisor
        Sleep, 300
        Send, {Enter}
        Sleep, 1000
        WinGetActiveTitle, title
        if (title == "Microsoft Excel") {
            workbook := 1
            Sleep, 500
            Send, {Enter}
            Sleep, 200
            Send, {Tab}{Tab}
            Sleep, 100
            Send, w
            Send, {Enter}{Enter}
            Sleep, 1000
            WinGetActiveTitle, title
            if (title == "Microsoft Excel") {
                Sleep, 500
                Send, {Enter}
            }
        }
    } else if (excel) {
        Run, C:\Users\%A_UserName%\Box\CE Help Desk\Documents\Access List - Full Time Employees.xlsx
        ProgramCheck("Access List - Full Time Employees.xlsx")
    }

    gui, GuiName:New,, New Hire Rights
    gui, Add, Text,, New Hire: %name%
    gui, Add, Text, yp+15, Job Title: %job%
    gui, Add, Text, yp+15, Supervisor: %supervisor%
    gui, Add, Text,, Select rights to be added:
    gui, Add, Checkbox, checked0 vforms, Active Forms
    gui, Add, Checkbox, checked1 vADRights, AD Rights
    gui, Add, Checkbox, checked1 vemail, Email
    gui, Add, Text, x-0
    gui, Add, Text, x+2.5, RingCentral: 
    gui, Add, DropDownList, x+5 yp-3 w100 vring, N/A||New Number|Add to Number
    gui, Add, Text, x-0
    gui, Add, Checkbox, checked0 vorion x+2.5 yp-3, Orion
    gui, Add, Checkbox, checked0 vorionTest, Orion Test
    gui, Add, Checkbox, checked0 vfsy, FSY Orion
    gui, Add, Checkbox, checked0 vgro, CRM/Gro
    gui, Add, Checkbox, checked0 vadobe, Adobe
    gui, Add, Checkbox, checked0 vmasterCourses, Master Courses
    gui, Add, Checkbox, checked0 vteamwork, Teamwork
    gui, Add, Edit, x+5 yp-5 vtwCompany w120, Company
    gui, Add, Text, x-0
    gui, Add, Checkbox, checked1 vnhe x+2.5 yp-3, New Hire Email
    gui, Add, Checkbox, checked1 vdoors, Doors
    gui, Add, Button, Default w80 gGoHire, Go
    gui, +AlwaysOnTop
    gui, Show, x2500 y200

    if (excel) {
        ; Search for the job title.
        Send, !{Tab}
        Sleep, 100
        Send, ^f
        Sleep, 500
        Send, ^a
        Sleep, 200
        Send % job
        Sleep, 300
        Send, {Enter}
        Sleep, 1000
        WinGetActiveTitle, title
        if (title == "Microsoft Excel" && !workbook) {
            Send, {Enter}
            Sleep, 100
            Send, {Tab}{Tab}
            Sleep, 100
            Send, w
            Send, {Enter}{Enter}
            Sleep, 500
        }
    }
return

GoHire: ; This Go button will continue the new hire automation.
    /*
    This is the "Go" button activated in the GUI prompt for the new hire 
    processing. 
    */
    gui, submit

    name := firstName . " " . lastName
    emailAddress := firstName . "." . lastName . "@byu.edu"
    StringLower, emailAddress, emailAddress
    errors := ""
    emailCheck := 1
    browser := ""
    
    
    rights := "*Working on:*`n`n"
    ; Build the list of actions needed and copy to clipboard.
        if (forms) {
            rights .= "* Active Forms`n"
        }
        if (ADRights) {
            rights .= "* AD Rights`n"
        }
        if (email) {
            rights .= "* Email`n"
        }
        if (ring != "N/A") {
            rights .= "* RingCentral`n"
        }
        if (orion) {
            rights .= "* Orion`n"
        }
        if (orionTest) {
            rights .= "* Orion Test`n"
        }
        if (fsy) {
            rights .= "* FSY Orion`n"
        }
        if (gro) {
            rights .= "* CRM/Gro`n"
        }
        if (adobe) {
            rights .= "* Adobe`n"
        }
        if (masterCourses) {
            rights .= "* Master Courses`n"
        }
        if (teamwork) {
            rights .= "* Teamwork`n"
        }
        if (nhe) {
            rights .= "* New Hire Email`n"
        }
        if (doors) {
            rights .= "* Doors`n"
        }
        rights .= "`n*Rights added:*`n"
    clipboard := rights

    if (!test) {
        MsgBox, 4096, New Hire Ticket, 
        ( LTrim
        All rights have been copied to the clipboard. 

        Please go into the new hire ticket and paste the list.
        )
        MsgBox, 
        ( LTrim
        Please follow instructions VERY CAREFULLY!

        Do not try to do other tasks while running this program.

        If anything is done that is not specified in the instructions, the
        program may not work properly.
        )
    }


    if (forms) {
        ; Export the new hire form into the "Active Forms" folder.
        MsgBox, 4097, Active Forms, 
        ( LTrim
        Please open the hire form in your browser in a printable state,
        or open in Adobe PDF Viewer, then press "OK" to continue.
        )
        IfMsgBox Cancel 
        {
            MsgBox, Automation has been aborted.
            return
        }
        Sleep, 1000
        Send, ^p
        MsgBox, 4097, Active Forms, 
        ( LTrim
        Be sure "Printer" is selected as "Microsoft Print to PDF" 
        or the equivalent.

        DO NOT PRESS PRINT.

        Press the "OK" button on this box to continue.
        )
        IfMsgBox Cancel 
        {
            MsgBox, Automation has been aborted.
            return
        }
        Send, {Enter}
        Sleep, 2000

        ; Name the form using "NetID - First Last" and export to 
        ; "Active Forms" folder
        Send, %netID% - %name%
        Sleep, 100
        Loop, 6
        {
            Send, {Tab}
        }
        Send, {Enter}
        Send, N:\CMP\HelpDesk\Access Forms\Active Forms
        Send, {Enter}
        
        MsgBox, 4097, Active Forms, 
        ( LTrim
        Name: %name%
        NetID: %netID%

        Make sure the file is exporting to the "Active Forms" folder and that
        everything is correct.

        Save the file when verified.

        Please strike through "Active Forms" on the ticket BEFORE pressing
        "OK" to continue.
        )
        IfMsgBox Cancel 
        {
            MsgBox, Automation has been aborted.
            return
        }
    }


    if (ADRights) {
        ; Open DCE Active Directory Tool.
        Run, C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\CE Computer Opertations\CE Active Directory Tool.appref-ms
        _ad := ProgramCheck("DCE Active Directory Tool")
        if (_ad == "Abort") {
            MsgBox, Automation has been aborted.
            return
        } else if (_ad == "Ignore") {
            errors .= "AD Rights - Unable to open application`n"
        } else {
            ; Select their account to add rights.
            Send, {Tab}{Tab}{Tab}
            Send % netID
            Send, {Enter}{Tab}{Tab}
            Sleep, 100
            Send, DomainUsers
            Sleep, 100

            MsgBox, 4097, AD Rights, 
            ( LTrim
            Please add the AD rights.

            Everyone needs "DomainUsers."

            Keep this message box open until this task is complete.

            Please strike through "AD Rights" on the ticket BEFORE pressing 
            "OK" to continue.
            )
            IfMsgBox Cancel 
            {
                MsgBox, Automation has been aborted.
                return
            }
        }
    }


    if (email) {
        ; !ADD! Check if variables are blank. Ask for input if so.
        ; Open email order website.
        if (OpenSite("https://support.byu.edu/it?id=sc_cat_item&sys_id=114375990a0a3c0e117557a6694dd190", "Service Catalog") == "Cancel") {
            MsgBox, Automation has been aborted.
            return
        }

        if (browser == "") {
            browser := BrowserCheck()
            if (browser == "Abort") {
                MsgBox, Automation has been aborted.
                return
            }
        }

        ;Send, {Enter}
        Sleep, 3000

        if (browser == "Chrome" || browser == "Edge") {
            loop, 27
            {
            Send, {Tab}
            }
        }

        ; If new hire is a student, change email type to student.
        if (class == "Student") {
            Send, {Down}{Down}
        }
        Send, {Tab}{Tab}

        ; Search for person.
        Send % netID
        Sleep, 5000
        Send, {Enter}{Tab}{Tab}
        Sleep, 500
        Send, {CtrlDown}a{CtrlUp}{Delete}
        Send % emailAddress
        Sleep, 200
        Send, {Tab}{Tab}
        Sleep, 200
        ; Check if email was created successfully. Create variable based on 
        ; this. Use variable for other email uses.
        MsgBox, 4099, Email, 
        ( LTrim
        Name: %name%
        NetID: %netID%
        Email: %emailAddress%

        Make sure everything is correct.

        Is the email available to be created?

        (If the email has already been created and you have verified it is 
        correct, press "Yes.")

        If YES, email is available to be created:
        - Press "Submit" on the web page.
        - Strike through "Email" on the ticket.
        - Press "Yes" to continue.

        If NO, email is not able to be created:
        - Mark the error on the ticket next to "Email."
        - Press "No" to continue.
        )
        IfMsgBox Cancel 
        {
            MsgBox, Automation has been aborted.
            return
        }
        IfMsgBox No
        {
            emailCheck := 0
            errors .= "Email`n"
            MsgBox, 4097, Email Error,
            ( LTrim
            Processes that require the email will be skipped.
            )
        }
    }


    if (ring != "N/A") {
        ; Request RingCentral from OIT.
        if (ring == "New Number") {
            if (OpenSite("https://support.byu.edu/it?id=sc_cat_item&table=sc_cat_item&sys_id=7f5b2f6187358d005c134b031a434dfb", "Service Catalog - ") == "Cancel") {
                MsgBox, Automation has been aborted.
                return
            }

            if (browser == "") {
                browser := BrowserCheck()
                if (browser == "Abort") {
                    MsgBox, Automation has been aborted.
                    return
                }
            }

            Sleep, 2000
            loop, 32
            {
                Send, {Tab}
            }
            Sleep, 100
            Send % netID
            Sleep, 5000
            Send, {Enter}{Tab}{Tab}
            Send, %netID%@byu.edu
            Sleep, 200
            Send, {Tab}{Tab}{Tab}
            Sleep, 500
            MsgBox, 4097, RingCentral, 
            ( LTrim
            Name: %name%
            NetID: %netID%

            Please verify the job department.

            Click "Order Now" if all info is correct.

            Please strike through "RingCentral" on the ticket BEFORE 
            dismissing this window.
            )
            IfMsgBox Cancel 
            {
                MsgBox, Automation has been aborted.
                return
            }
        }
        else {
            if (OpenSite("https://support.byu.edu/it?id=sc_cat_item&table=sc_cat_item&sys_id=6d1ceaaa1bd70110319b7592cd4bcb35&recordUrl=com.glideapp.servicecatalog_cat_item_view.do%3Fv%3D1&sysparm_id=6d1ceaaa1bd70110319b7592cd4bcb35", "Service Catalog - ") == "Cancel") {
                MsgBox, Automation has been aborted.
                return
            }
    
            if (browser == "") {
                browser := BrowserCheck()
                if (browser == "Abort") {
                    MsgBox, Automation has been aborted.
                    return
                }
            }
    
            Sleep, 1500
            loop, 25
            {
                Send, {Tab}
            }
            Sleep, 100
            Send % netID
            Sleep, 5000
            Send, {Enter}{Tab}{Tab}{Tab}{Tab}
            Send, %netID%@byu.edu
            Sleep, 200
            Send, {ShiftDown}{Tab}{Tab}{ShiftUp}
            Sleep, 200
            Send, 801-422-
            Sleep, 500
            MsgBox, 4097, RingCentral, 
            ( LTrim
            Name: %name%
            NetID: %netID%
    
            Please add the phone number and verify the job department.
    
            Click "Order Now" if all info is correct.
    
            Please strike through "RingCentral" on the ticket BEFORE 
            dismissing this window.
            )
            IfMsgBox Cancel 
            {
                MsgBox, Automation has been aborted.
                return
            }

        }
    }


    if (orion) {
        ;Open the Orion website and search for the person.
        if (OpenSite("https://ceregadmin.byu.edu/o3/admin/person/manage/", "Manage Person") == "Cancel") {
            MsgBox, Automation has been aborted.
            return
        }

        if (browser == "") {
            browser := BrowserCheck()
            if (browser == "Abort") {
                MsgBox, Automation has been aborted.
                return
            }
        }

        Sleep, 500
        Send, {Tab}
        if (browser == "Chrome" || browser == "Edge") {
            Send, {Tab}{Tab}{Tab}
        }
        Send % netID
        Send, {Tab}Login{Tab}
        Sleep, 200
        Send, {Enter}
        ; Make sure they're signed into Orion.
        _o := OrionCheck("Manage Person - " firstName)
        if (_o == "Abort") {
            MsgBox, Automation has been aborted.
            return
        } else if (_o == "Continue") {
            errors .= "Orion - Person not found`n"
        } else {
            ; Open the "Rights" tab of their account page.
            Sleep, 400
            if (browser == "Chrome" || browser == "Edge") {
                Send, {Tab}{Tab}{Tab}
            }
            Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Right}
            Sleep, 1000

            MsgBox, 4097, Orion, 
            ( LTrim
            Please finish assigning roles.

            Please strike through "Orion" on the ticket BEFORE pressing 
            "OK" to continue.
            )
            IfMsgBox Cancel 
            {
                MsgBox, Automation has been aborted.
                return
            }
        }
    }


    if (orionTest) {
        ;Open the Orion website and search for the person.
        if (OpenSite("https://ceregtest.byu.edu/o3/admin/person/manage/", "Manage Person") == "Cancel") {
            MsgBox, Automation has been aborted.
            return
        }

        if (browser == "") {
            browser := BrowserCheck()
            if (browser == "Abort") {
                MsgBox, Automation has been aborted.
                return
            }
        }

        Sleep, 500
        Send, {Tab}
        if (browser == "Chrome" || browser == "Edge") {
            Send, {Tab}{Tab}{Tab}
        }
        Send % netID
        Send, {Tab}Login{Tab}
        Sleep, 200
        Send, {Enter}
        ; Make sure they're signed into Orion Test.
        _oT := OrionCheck("Manage Person - " firstName)
        if (_oT == "Abort") {
            MsgBox, Automation has been aborted.
            return
        } else if (_oT == "Continue") {
            errors .= "Orion Test - Person not found`n"
        } else {
            ; Open the "Rights" tab of their accout page.
            Sleep, 400
            if (browser == "Chrome" || browser == "Edge") {
                Send, {Tab}{Tab}{Tab}
            }
            Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Right}
            Sleep, 1000

            MsgBox, 4097, Orion Test, 
            ( LTrim
            Please finish assigning roles.

            Please strike through "Orion Test" on the ticket BEFORE pressing 
            "OK" to continue.
            )
            IfMsgBox Cancel 
            {
                MsgBox, Automation has been aborted.
                return
            }
        }
    }


    if (fsy) {
        ;Open the Orion website and search for the person.
        if (OpenSite("https://fsyadmin.byu.edu/o3/admin/person/manage/", "Manage Person") == "Cancel") {
            MsgBox, Automation has been aborted.
            return
        }

        if (browser == "") {
            browser := BrowserCheck()
            if (browser == "Abort") {
                MsgBox, Automation has been aborted.
                return
            }
        }

        Sleep, 500
        Send, {Tab}
        if (browser == "Chrome" || browser == "Edge") {
            Send, {Tab}{Tab}
        }
        Send, %lastName%, %firstName%
        Send, {Tab}Last{Tab}
        Sleep, 200
        Send, {Enter}
        ; Make sure their account is set up in FSY Orion.
        _oT := OrionCheck("Manage Person - " firstName)
        if (_oT == "Abort") {
            MsgBox, Automation has been aborted.
            return
        } else if (_oT == "Continue") {
            errors .= "FSY Orion - Person not found`n"
        } else {
            ; Open the "Rights" tab of their accout page.
            Sleep, 400
            if (browser == "Chrome" || browser == "Edge") {
                Send, {Tab}{Tab}{Tab}
            }
            Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Right}
            Sleep, 1000

            MsgBox, 4097, FSY Orion, 
            ( LTrim
            Please finish assigning roles.

            Please strike through "FSY Orion" on the ticket BEFORE pressing 
            "OK" to continue.
            )
            IfMsgBox Cancel 
            {
                MsgBox, Automation has been aborted.
                return
            }
        }
    }


    if (gro) {
        ; Open CRM/Gro website and search for the person.
        if (OpenSite("https://gro.byu.edu/person-memberships", "BYU | Group Information") == "Cancel") {
            MsgBox, Automation has been aborted.
            return
        }

        Sleep, 800
        Send % netID
        Send, {Enter}

        ; Message Irvin Mendoza
        IfWinNotExist ahk_exe Teams.exe
        {
            Run, C:\Users\%A_UserName%\AppData\Local\Microsoft\Teams\current\Teams.exe
            if (ProgramCheck("ahk_exe Teams.exe") == "Abort") {
                MsgBox, Automation has been aborted.
                return
            }
            Sleep, 4000
        }
        Run, C:\Users\%A_UserName%\AppData\Local\Microsoft\Teams\current\Teams.exe
        Sleep, 1000
        Send, ^n
        Sleep, 1500
        Send, Irvin Mendoza Rojas
        Sleep, 2000
        Send, {Enter}
        Sleep, 500
        Send, {Tab}
        Sleep, 1000
        Send, %netID% has the "" right added for CRM
        Sleep, 500

        MsgBox, 4097, CRM/Gro, 
        ( LTrim
        Please finish adding rights.

        Be sure to send the Teams message to Irvin Rojas.

        Strike through "CRM/Gro" on the ticket BEFORE pressing "OK" to 
        continue.
        )
        IfMsgBox Cancel 
        {
            MsgBox, Automation has been aborted.
            return
        }
    }


    if (adobe) {
        ; Request Adobe license from OIT.
        if (OpenSite("https://support.byu.edu/it?id=sc_cat_item&sys_id=ef3908c013d70b00be81bb722244b034&sysparm_category=aaec8bf20a0a3c0e55139c86721d7da2", "Service Catalog - ") == "Cancel") {
            MsgBox, Automation has been aborted.
            return
        }

        if (browser == "") {
            browser := BrowserCheck()
            if (browser == "Abort") {
                MsgBox, Automation has been aborted.
                return
            }
        }

        Sleep, 1500
        loop, 27
        {
            Send, {Tab}
        }
        Sleep, 100
        Send % netID
        Sleep, 5000
        Send, {Enter}{Tab}{Tab}
        Sleep, 100
        Send % supervisor
        Sleep, 5000
        Send, {Enter}

        MsgBox, 4097, Adobe, 
        ( LTrim
        Name: %name%
        NetID: %netID%
        Supervisor: %supervisor%

        Please verify all information.

        Click "Order Now" if all info is correct.

        Please strike through "Adobe" on the ticket BEFORE 
        dismissing this window.
        )
        IfMsgBox Cancel 
        {
            MsgBox, Automation has been aborted.
            return
        }
    }


    if (masterCourses) {
        ; Open Teams to message Will Dastrup.
        Run, ms-teams.exe
        if (ProgramCheck("ahk_exe ms-teams.exe") == "Abort") {
            MsgBox, Automation has been aborted.
            return
        }
        ;Sleep, 4000
        
        clipboard := name " (" netID ") needs Master Courses"
        Sleep, 500
        MsgBox, 4097, Master Courses, 
        ( LTrim
        Open the Master Courses Access chat to send a message to Will 
        Dastrup.
        The message has been copied to the clipboard.

        Please strike through "Master Courses" on the ticket BEFORE pressing 
        "OK" to continue.
        )
        IfMsgBox Cancel 
        {
            MsgBox, Automation has been aborted.
            return
        }
    }


    if (teamwork) {
        if (emailCheck) {
            ; If email was created successfully, open Teamwork website.
            if (OpenSite("https://byuis.teamwork.com/#/people/people", "People - ") == "Cancel") {
                MsgBox, Automation has been aborted.
                return
            }

            if (browser == "") {
                browser := BrowserCheck()
                if (browser == "Abort") {
                    MsgBox, Automation has been aborted.
                    return
                }
            }

            ; Wait for website to build properly, then input info for new user. (When fixed)
            ;Sleep, 1500

            ; Send, qa
            ; Send, {Tab}{Enter}
            ; Sleep, 100
            ; Send, {Right}
            ; Sleep, 200
            ; Send, {Tab}{Tab}{Tab}{Tab}
            if (browser == "Chrome" || browser == "Edge") {
                Loop, 13
                {
                    ;Send, {Tab}
                }
            }
            ; Sleep, 100                This portion has been depricated for the time being.
            ; Send, {Enter}             Teamwork has made changes too frequently to the point
            ; Sleep, 1000               where I don't want to keep having to update.
            ; Send % firstName
            ; Send, {Tab}
            ; Send % lastName
            ; Send, {Tab}
            ; Send % emailAddress
            ; Send, {Tab}{Tab}{Tab}{Tab}{Enter}
            ; Sleep, 100
            ; Send % twCompany
            ; Sleep, 1000
            ; Send, {down}{Enter}
            ; Sleep, 500

            ; Open Teamwork reference file from Box.
            if (class == "Student") {
                Run, C:\Users\%A_UserName%\Box\CE Help Desk\Documents\Access List - Student Employees.xlsx
                _tw := ProgramCheck("Access List - Student Employees")
                if (_tw == "Abort") {
                    MsgBox, Automation has been aborted.
                    return
                }
            }
            else {
                Run, C:\Users\%A_UserName%\Box\CE Help Desk\Documents\Access List - Full Time Employees.xlsx
                _tw := ProgramCheck("Access List - Full Time Employees")
                if (_tw == "Abort") {
                    MsgBox, Automation has been aborted.
                    return
                }
            }

            ; Search for job title in file.
            ; Sleep, 200
            ; Send, ^f
            ; Sleep, 500
            ; Send % job
            ; Sleep, 1000
            ; Send, {Enter}

            clipboard := %email%

            MsgBox, 4097, Teamwork, 
            ( LTrim
            Name: %name%
            Email: %emailAddress%  (copied to clipboard)
            Company: %twCompany%

            Please finish giving Teamwork access.

            Please strike through "Teamwork" on the ticket BEFORE pressing 
            "OK" to continue.
            )
            IfMsgBox Cancel 
            {
                MsgBox, Automation has been aborted.
                return
            }
        } else {
            errors .= "Teamwork - due to Email`n"
        }
    }


    if (nhe) {
        if (emailCheck) {
            ; If email was created successfully, open DCE Active Directory Tool.
            Run, C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\CE Computer Opertations\CE Active Directory Tool.appref-ms
            _nhe := ProgramCheck("DCE Active Directory Tool")
            if (_nhe == "Abort") {
                MsgBox, Automation has been aborted.
                return
            } else if (_nhe == "Continue") {
                errors .= "New Hire Email - Unable to open application`n"
            } else {
                ; Select their account.
                Send, {Tab}{Tab}{Tab}
                Send % netID
                Send, {Enter}

                ; Open "New Hire Email" page.
                Loop, 9
                {
                Send, {Tab}
                }
                Send, {Enter}
                ;Sleep, 200
                Send, {Tab}{Tab}
                Sleep, 1000
                Send % supervisor
                Sleep, 3000
                MsgBox, 4097, New Hire Email, 
                ( LTrim
                Name: %name%
                Supervisor: %supervisor%

                Orion: %orion%
                Orion Test: %orionTest%
                Teamwork: %teamwork%
                
                Finish filling out the email info, then press "Send".

                Please strike through "New Hire Email" on the ticket BEFORE pressing
                "OK" to continue.
                )
                IfMsgBox Cancel 
                {
                    MsgBox, Automation has been aborted.
                    return
                }
            }
        } else {
            errors .= "New Hire Email - due to email`n"
        }
    }


    if (doors) {
        MsgBox, 
        ( LTrim
        Please mark (Doors) on the ticket.
        
        Unless you can do doors, in which case, do the thing.
        )
    }


    if (errors == "") {
        MsgBox, Yay! All done.
    } else {
        MsgBox, Errors or Incomplete Tasks:`n`n%errors%
    }
    
return


^+4:: ; Termination
    ;Run, C:\Users\%A_UserName%\Box\CE Help Desk\Documents\Access List - Student Employees.xlsx
    gui, GuiName:New,,Termination
    gui, Add, Text,, Paste netIDs for termination, separated by lines:
    gui, Add, Edit, vnetIDs w150 r10,
    gui, Add, Text,, First Last name, if only one termination:
    gui, Add, Edit, vname w150,
    ; gui, Add, Checkbox, checked0 vform, Termination Form
    gui, Add, Checkbox, checked1 vADRights, AD Rights
    gui, Add, Checkbox, checked1 vorion, Orion
    gui, Add, Checkbox, checked1 vorionTest, Orion Test
    gui, Add, Checkbox, checked1 vfsy, FSY Orion
    gui, Add, Checkbox, checked1 vgro, CRM/Gro
    gui, Add, Checkbox, checked1 vteamwork, Teamwork
    gui, Add, Checkbox, checked1 vcvent, CVENT
    gui, Add, Checkbox, checked0 vworkstation, Workstation (Full Time)
    gui, Add, Checkbox, checked0 vemail, Email (Students)
    gui, Add, Checkbox, checked1 vmasterCourses, Master Courses
    gui, Add, Checkbox, checked1 vdoors, Doors
    gui, Add, Text,,
    gui, Add, Checkbox, checked0 vturbo, Turbo Mode (Experimental!)
    gui, Add, Button, Default w80 gGoTermination, Go
    gui, +AlwaysOnTop
    gui, Show
return

GoTermination: ; Continue Termination
    gui, submit

    ;name := ""
    errors := ""
    browser := ""

    rights := "" ;"*Working on:*`n`n"


    ; Build the list of actions needed and copy to clipboard.
        if (ADRights) {
            rights .= "AD Rights`n"
        }
        if (orion) {
            rights .= "Orion`n"
        }
        if (orionTest) {
            rights .= "Orion Test`n"
        }
        if (fsy) {
            rights .= "FSY Orion`n"
        }
        if (gro) {
            rights .= "CRM/Gro`n"
        }
        if (teamwork) {
            rights .= "Teamwork`n"
        }
        if (teamwork) {
            rights .= "CVENT`n"
        }
        if (workstation) {
            rights .= "Email`n"
        }
        if (email) {
            rights .= "Email`n"
        }
        if (masterCourses) {
            rights .= "Master Courses`n"
        }
        if (doors) {
            rights .= "Doors"
        }
        ; rights .= "`n*Rights added:*`n"
    clipboard := rights

    if (!test) {
        MsgBox, 4096, Termination Ticket, 
        ( LTrim
        The termination steps have been copied to the clipboard. 

        Please go into the termination ticket and paste the list.
        )
    }

    Loop, parse, netIDs, `n
    {
        netID := A_LoopField

        ; if (form) {
        ;     ; Open the hire form in the "Active Forms" folder.
        ;     Run, N:\CMP\HelpDesk\Access Forms\Active Forms
        ;     Sleep, 1000
        ;     Send % netID
        ;     Sleep, 200
        ;     InputBox, name, Name, First and Last Name for: %netID%

        ;     MsgBox, 4097, Form, Open the correct form for: %netID%
        ;     IfMsgBox Cancel 
        ;     {
        ;         MsgBox, Automation has been aborted.
        ;         return
        ;     }

        ;     Run, C:\Users\%A_UserName%\Box\CE Help Desk\Documents\Termination Form.pdf
        ;     Sleep, 1000
        ;     Send, !f
        ;     Sleep, 500
        ;     Send, rm
        ;     Sleep, 500
        ;     Send, {Tab}{Enter}

        ;     MsgBox, 4097, Form, 
        ;     ( LTrim
        ;     NetID: %netID%    
            
        ;     Select the employee form and termination form.
        ;     Add the files.
        ;     Make sure the termination form is in front of the employee form.
        ;     Combine the files.
        ;     "OK" to continue.
        ;     )
        ;     IfMsgBox Cancel 
        ;     {
        ;         MsgBox, Automation has been aborted.
        ;         return
        ;     }
            
        ;     Send, {Tab}
        ;     Send % name
        ;     Sleep, 300
        ;     Send, {Tab}
        ;     Send % netID
        ;     Sleep, 300
            
        ; }
    

        if (ADRights) {
            ; Open DCE Active Directory Tool using Windows search.
            Run, C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\CE Computer Opertations\CE Active Directory Tool.appref-ms
            _ad := ProgramCheck("DCE Active Directory Tool")
            if (_ad == "Abort") {
                MsgBox, Automation has been aborted.
                return
            } else if (_ad == "Continue") {
                errors .= "AD Rights - Unable to open application`n"
            } else {
                ; Select their account to add rights.
                Send, {Tab}{Tab}{Tab}
                Send % netID
                Send, {Enter}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}

                MsgBox, 4097, AD Rights, 
                ( LTrim
                Name: %name%
                Press "Terminate".
                Mark off "AD Rights" on the ticket.
                Press "OK" when finished.
                )
                IfMsgBox Cancel 
                {
                    MsgBox, Automation has been aborted.
                    return
                }
            }
        }


        if (orion) {
            ;Open the Orion website and search for the person.
            if (OpenSite("https://ceregadmin.byu.edu/o3/admin/person/manage/", "Manage Person") == "Cancel") {
                MsgBox, Automation has been aborted.
                return
            }

            if (browser == "") {
                browser := BrowserCheck()
                if (browser == "Abort") {
                    MsgBox, Automation has been aborted.
                    return
                }
            }

            Sleep, 200
            if (browser == "Chrome" || browser == "Edge") {
                Send, {Tab}{Tab}{Tab}{Tab}
            }
            Send % netID
            Send, {Tab}Login{Tab}
            Sleep, 200
            Send, {Enter}
            ; Make sure they're signed into Orion.
            _o := OrionCheck("Manage Person - ")
            if (_o == "Abort") {
                MsgBox, Automation has been aborted.
                return
            } else if (_o == "Continue") {
                errors .= "Orion - Person not found`n"
            } else {
                ; Open the "Rights" tab of their account page.
                Sleep, 400
                if (browser == "Chrome" || browser == "Edge") {
                    Send, {Tab}{Tab}{Tab}
                }
                Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Right}
                Sleep, 1000

                MsgBox, 4097, Orion, 
                ( LTrim
                Please revoke rights if any are present.
                Mark off "Orion" on the ticket BEFORE pressing 
                "OK" to continue.
                )
                IfMsgBox Cancel 
                {
                    MsgBox, Automation has been aborted.
                    return
                }
            }
        }


        if (orionTest) {
            ;Open the Orion website and search for the person.
            if (OpenSite("https://ceregtest.byu.edu/o3/admin/person/manage/", "Manage Person") == "Cancel") {
                MsgBox, Automation has been aborted.
                return
            }

            if (browser == "") {
                browser := BrowserCheck()
                if (browser == "Abort") {
                    MsgBox, Automation has been aborted.
                    return
                }
            }

            Sleep, 200
            Send, {Tab}
            if (browser == "Chrome" || browser == "Edge") {
                Send, {Tab}{Tab}{Tab}
            }
            Send % netID
            Send, {Tab}Login{Tab}
            Sleep, 200
            Send, {Enter}
            ; Make sure they're signed into Orion Test.
            _oT := OrionCheck("Manage Person - ")
            if (_oT == "Abort") {
                MsgBox, Automation has been aborted.
                return
            } else if (_oT == "Continue") {
                errors .= "Orion Test - Person not found`n"
            } else {
                ; Open the "Rights" tab of their accout page.
                Sleep, 400
                if (browser == "Chrome" || browser == "Edge") {
                    Send, {Tab}{Tab}{Tab}
                }
                Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Right}
                Sleep, 500
                if (turbo) {
                    MsgBox, 4097, Orion Test - TURBO MODE, 
                    ( LTrim
                    !!! TURBO MODE !!!
                    Please revoke rights if any are present.
                    "OK" to continue.
                    )
                    IfMsgBox Cancel 
                    {
                        MsgBox, Automation has been aborted.
                        return
                    }

                    Sleep, 200
                    Send, !{Tab}
                    Sleep, 200
                    Send, 1
                    Sleep, 200
                    Send, {Enter}{Enter}
                    Sleep, 500
                    Send, !{Tab}
                    Sleep, 500
                    Send, ^w
                    Sleep, 200
                } else {
                    MsgBox, 4097, Orion Test, 
                    ( LTrim
                    Please revoke rights if any are present.
                    Mark off "Orion Test" on the ticket BEFORE pressing 
                    "OK" to continue.
                    )
                    IfMsgBox Cancel 
                    {
                        MsgBox, Automation has been aborted.
                        return
                    }
                }
            }
        }


        if (fsy) {
            ;Open the Orion website and search for the person.
            if (OpenSite("https://fsyadmin.byu.edu/o3/admin/person/manage/", "Manage Person") == "Cancel") {
                MsgBox, Automation has been aborted.
                return
            }

            if (browser == "") {
                browser := BrowserCheck()
                if (browser == "Abort") {
                    MsgBox, Automation has been aborted.
                    return
                }
            }

            Sleep, 200
            if (browser == "Chrome" || browser == "Edge") {
                Send, {Tab}{Tab}{Tab}
            }
            Send % netID
            Send, {Tab}Login{Tab}
            Sleep, 200
            Send, {Enter}
            ; Make sure they're signed into Orion.
            _o := OrionCheck("Manage Person - ")
            if (_o == "Abort") {
                MsgBox, Automation has been aborted.
                return
            } else if (_o == "Continue") {
            } else {
                ; Open the "Rights" tab of their account page.
                Sleep, 400
                if (browser == "Chrome" || browser == "Edge") {
                    Send, {Tab}{Tab}{Tab}
                }
                Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Right}
                Sleep, 1000

                MsgBox, 4097, FSY Orion, 
                ( LTrim
                Please revoke rights if any are present.
                Mark off "FSY Orion" on the ticket BEFORE pressing 
                "OK" to continue.
                )
                IfMsgBox Cancel 
                {
                    MsgBox, Automation has been aborted.
                    return
                }
            }
        }


        if (gro) { ;test
            ; Open CRM/Gro website and search for the person.
            if (OpenSite("https://gro.byu.edu/person-memberships", "BYU | Group Information") == "Cancel") {
                MsgBox, Automation has been aborted.
                return
            }

            Sleep, 500
            Send % netID
            Send, {Enter}
            Sleep, 200

            MsgBox, 4097, CRM/Gro, 
            ( LTrim
            Please remove rights.
            Mark off "Gro" on the ticket BEFORE pressing "OK" to 
            continue.
            )
            IfMsgBox Cancel 
            {
                MsgBox, Automation has been aborted.
                return
            }
        }


        if (teamwork) { ;broken
            ; Open Teamwork website.
            if (name == "") {
                InputBox, name, Name, First and Last Name for: %netID%
            }
            if (OpenSite("https://byuis.teamwork.com/#/people/people", "People - People - BYU CE Teamwork") == "Cancel") {
                MsgBox, Automation has been aborted.
                return
            }

            if (browser == "") {
                browser := BrowserCheck()
                if (browser == "Abort") {
                    MsgBox, Automation has been aborted.
                    return
                }
            }

            ; Wait for website to build properly, then find user.
            ; Sleep, 3000
            ; if (browser == "Chrome" || browser == "Edge") {
            ;     Loop, 16
            ;     {                                 This has been depricated because Teamwork
            ;         Send, {Tab}                   changes their website too often and
            ;     }                                 messes with my automation.
            ; }                                     
            ; Sleep, 200
            ; Send %name%
            ; Sleep, 500

            MsgBox, 4097, Teamwork, 
            ( LTrim
            Name: %name%

            Search for the employee.
            If they are not found in the list, they most likely don't 
            have an account. 

            If the account has been found:
            Select the profile
            Click on the three dots in top right corner
            Select "Downgrade to Contact"

            Click "OK" to continue.
            )
            IfMsgBox Cancel 
            {
                MsgBox, Automation has been aborted.
                return
            }
        }


        if (cvent) { ;broken
            ; Open CVENT website.
            if (name == "") {
                InputBox, name, Name, First and Last Name for: %netID%
            }
            if (OpenSite("https://app.cvent.com/Subscribers/Admin/Users/UsersGrid/Index/View", "Users") == "Cancel") {
                MsgBox, Automation has been aborted.
                return
            }

            if (browser == "") {
                browser := BrowserCheck()
                if (browser == "Abort") {
                    MsgBox, Automation has been aborted.
                    return
                }
            }

            ; Wait for website to build properly, then find user.
            Sleep, 3000
            if (browser == "Chrome" || browser == "Edge") {
                Loop, 21
                {
                    Send, {Tab}
                }
            }                                     
            Sleep, 200
            Send %name%
            Sleep, 500

            MsgBox, 4097, CVENT, 
            ( LTrim
            Name: %name%

            Search for the employee.
            If they are not found in the list, they most likely don't 
            have an account. 

            If the account has been found:
            Select the profile
            Revoke access in "Visibility Settings" and "Access Settings"

            Click "OK" to continue.
            )
            IfMsgBox Cancel 
            {
                MsgBox, Automation has been aborted.
                return
            }
        }
        
        
        if (workstation) {
            ; Open the inventory website and navigate to the employee's workstation
            if (OpenSite("https://ceregadmin.byu.edu/o3/admin/inventory/manageInventory/", "Inventory Management") == "Cancel") {
                MsgBox, Automation has been aborted.
                return
            }
            
            if (!name) {
                InputBox, name, Name, First and Last Name for: %netID%
            }

            Sleep, 500
            Send % name
            Send, {Enter}

            MsgBox, 4097, Workstation, 
            ( LTrim
            Name: %name%
            
            - Go to the "Workstations" tab
            - Search for the employee's workstation
            - Change the name to "was %name%"
            - Mark off "Workstation" on the ticket BEFORE pressing
              "OK" to continue.
            )
            IfMsgBox Cancel 
            {
                MsgBox, Automation has been aborted.
                return
            }
        }


        if (email) {
            ; Open email cancel website.
            if (OpenSite("https://support.byu.edu/it?id=sc_cat_item&sys_id=ac7ac2c50a0a3c0e3bc4efea86003a9e", "Service Catalog") == "Cancel") {
                MsgBox, Automation has been aborted.
                return
            }

            if (browser == "") {
                browser := BrowserCheck()
                if (browser == "Abort") {
                    MsgBox, Automation has been aborted.
                    return
                }
            }

            Sleep, 1000

            if (browser == "Chrome" || browser == "Edge") {
                loop, 27
                {
                Send, {Tab}
                }
            }

            ; Search for person.
            Send % netID
            Sleep, 5000
            Send, {Enter}{Tab}{Tab}{Tab}{Tab}{Tab}
            Sleep, 500
            if (turbo) {
                Send, Employee termination  %netID%
            } else {
                Send, Employee termination
            }
            Sleep, 200
            Send, {Tab}{Tab}{Tab}
            Sleep, 200

            if (!turbo) {
                MsgBox, 4097, Email, 
                ( LTrim
                Name: %name%
                NetID: %netID%

                Please verify the account is correct.
                Once verified, click on "Order Now".
                Mark off "Email Termination" on the ticket.
                "OK" when finished.
                )
                IfMsgBox Cancel 
                {
                    MsgBox, Automation has been aborted.
                    return
                }
            }
        }


        if (masterCourses) {
            if (OpenSite("https://dcehelpdesk.byu.edu/jira/browse/DH-19412", "[DH-19412]") == "Cancel") {
                MsgBox, Automation has been aborted.
                return
            }

            clipboard := netID
            MsgBox, 0, MasterCourses, NetID has been copied to clipboard. Add to removal list.
        }


        if (doors) {
            MsgBox, 
            ( LTrim
            Please mark (Doors) on the ticket.
            Unless you can do doors, in which case, do the thing.
            )
        }


        ; if (form) {
        ;     Run, Acrobat.exe
        ;     MsgBox, 4097, Form, 
        ;     ( LTrim
        ;     Name: %name%
        ;     NetID: %netID%    
            
        ;     Make sure the correct termination form is open.
        ;     Fill in the remaining information.
        ;     "OK" to continue.

        ;     Next Task: Export to termination folder
        ;     )
        ;     IfMsgBox Cancel 
        ;     {
        ;         MsgBox, Automation has been aborted.
        ;         return
        ;     }

        ;     Send, ^p
        ;     Sleep, 1000

        ;     MsgBox, 4097, Export Termination Form, 
        ;     ( LTrim
        ;     Be sure "Printer" is selected as "Microsoft Print to PDF" 
        ;     or the equivalent.

        ;     DO NOT PRESS PRINT.

        ;     Press the "OK" button on this box to continue.
        ;     )
        ;     IfMsgBox Cancel 
        ;     {
        ;         MsgBox, Automation has been aborted.
        ;         return
        ;     }

        ;     Send, {Enter}
        ;     Sleep, 2000
        ;     Send, %netID% - %name%
        ;     Sleep, 500
        ;     Loop, 6
        ;     {
        ;         Send, {Tab}
        ;     }
        ;     Sleep, 500
        ;     Send, {Enter}
        ;     Send, N:\CMP\HelpDesk\Access Forms\Terminated Employees
        ;     Send, {Enter}
            
        ;     MsgBox, 4097, Form, 
        ;     ( LTrim
        ;     Name: %name%
        ;     NetID: %netID%    
            
        ;     Make sure the file is exporting to the "Terminated Employees" folder
        ;     and that everything is correct.
        ;     Save the file when verified.
        ;     "OK" to continue.
        ;     )
        ;     IfMsgBox Cancel 
        ;     {
        ;         MsgBox, Automation has been aborted.
        ;         return
        ;     }

        ;     Run, N:\CMP\HelpDesk\Access Forms\Active Forms
        ;     Sleep, 1000
        ;     Send % netID
        ;     Sleep, 200
        ;     MsgBox, 4097, Form, 
        ;     ( LTrim
        ;     Delete the active form for: %netID%
        ;     Be sure the form is closed in Adobe PDF Viewer.
        ;     )
        ;     IfMsgBox Cancel 
        ;     {
        ;         MsgBox, Automation has been aborted.
        ;         return
        ;     }
        ; }
    }


    if (errors == "") {
        MsgBox, Yay! All done.
    } else {
        MsgBox, Errors or Incomplete Tasks:`n`n%errors%
    }
return


^+5:: ; Hardware/Software Request
    gui, GuiName:New,,Hardware/Software Request
    gui, Add, Text,, Flag the email to show progress`nhas begun on the request.
    gui, Add, Text,, Copy everything under the`n"Request Details" section of`nthe email to your clipboard.
    gui, Add, Text,,
    gui, Add, Text,, Request Type:
    gui, Add, DropDownList, x+5 yp-5 w120 vtype, Hardware/Software||Programming
    gui, Add, Text, x-0
    gui, Add, Text, x+2.5, Requestor:
    gui, Add, Edit, x+5 yp-5 vrequestor w138,
    gui, Add, Text, x-0
    gui, Add, Text, x+2.5, Operating Unit #:
    gui, Add, Edit, x+5 yp-5 vOU w109,
    gui, Add, Text,,
    gui, Add, Text, x-0,
    gui, Add, Text, x+2.5, If Hardware/Software`, what category:
    gui, Add, DropDownList, w160 vhtype, New Software/Hardware||Laptop Replacement|New Computer Workstation
    ; gui, Add, Text, x+2.5, Request Details:
    ; gui, Add, Edit, vdetails w400 r30,
    gui, Add, Button, Default w80 gGoRequest, Go
    gui, +AlwaysOnTop
    gui, Show
return

GoRequest: ; This Go button will continue the request automation.
    gui, submit

    if (type == "Hardware/Software") {
        Run, https://dcehelpdesk.byu.edu/jira/servicedesk/customer/portal/2/create/119
        Send, {Shift}{Tab}
        Send % requestor
        Send, {Enter}{Tab}{Tab}
        Send % htype
        Send, {Enter}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}
        Send % clipboard
        Send, {Tab}{Tab}
        Send % OU
        Sleep, 50
        Send, {ShiftDown}
        Loop, 12
            {
                Send, {Tab}
            }
        Send, {ShiftUp}
        ; MsgBox, Put in an appropriate title for the request
        ; Request type: 
        ; Requestor: 
        ; Category: 
        ; Operating Unit: 
    } else {
        Run, https://dcehelpdesk.byu.edu/jira/servicedesk/customer/portal/2/create/121
    }
return


^+6:: ; Add AD Rights for multiple people
    gui, GuiName:New,,AD Rights
    gui, Add, Text,, Paste netIDs, separated by lines:
    gui, Add, Edit, vnetIDs w200 r10,
    gui, Add, Text,, AD Right:
    gui, Add, Edit, vrights w200 r10,
    gui, Add, Button, Default w80 gGoAD, Go
    gui, +AlwaysOnTop
    gui, Show
return

global stop = 0
F1:: ; If the Add AD Rights script runs into problems, press F1 to stop and show you the last NetID used
    stop = 1
return

GoAD: ; This Go button will continue adding AD rights.
    gui, submit
    stop = 0

    failed := ""

    Run, C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\CE Computer Opertations\CE Active Directory Tool.appref-ms
    _ad := ProgramCheck("DCE Active Directory Tool")
    if (_ad == "Abort") {
        MsgBox, Automation has been aborted.
        return
    } else {
        Send, {Tab}{Tab}{Tab}

        Loop, parse, netIDs, `n
        {
            IfWinNotActive, ahk_exe ADTool - CSWPF.exe
            {
                MsgBox, 4097, AD Rights,
                ( LTrim
                The AD Tool application has gone out of focus.
                
                Open the AD Tool window.
                Click on the NetID box, then press "OK" to continue.
                )
                IfMsgBox Cancel 
                {
                    MsgBox, Automation has been aborted.
                    return
                }
            }
            
            netID := Trim(A_LoopField)

            ; select their account to add rights
            Send % netID
            Sleep, 100
            Send, {Enter}
            Sleep, 200

            ; check if the NetID was found
            IfWinActive, ahk_class #32770 ; This checks to see if the error window pops up
            {
                ; try the netID again
                Send, {Enter}
                Sleep, 100
                Send % Trim(netID)
                Sleep, 200
                Send, {Enter}
                Sleep, 200

                ; check for the error window again
                IfWinActive, ahk_class #32770
                {
                    Send, {Enter}
                    failed .= %netID%
                    MsgBox, 4097, NetID Error, 
                    ( LTrim
                    NetID: "%netID%"
                    failed: %failed%

                    A problem occured looking up the NetID. Record the NetID so you may
                    look into it further after the automation is complete.

                    The problem is usually from having an extra space character at the 
                    end of the NetID. Remove the space from the input when using the
                    automation to help prevent this issue.
                    )
                    IfMsgBox Cancel 
                    {
                        MsgBox, Automation has been aborted.
                        return
                    }
                    continue
                }
            }
            
            Send, {Tab}{Tab}
            
            ; add rights
            Loop, parse, rights, `n
            {
                right := A_LoopField
                Send % right
                Sleep, 100
                MouseMove, 100, 240
                Sleep, 50
                Click
                Sleep, 50
                MouseMove, 250, 550
                Sleep, 50 ;300
                Click
                Sleep, 50
                Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}
                Sleep, 50
                Send, ^a
                Send, {Delete}
                Sleep, 50 ;300
            }
            
            Sleep, 50 ;0
            Send, {ShiftDown}{Tab}{Tab}{ShiftUp}

            if (stop) { ; Stop and view name
                MsgBox, Stopped on: %netID%
                return
            }
        }
        
        if (failed) {
            MsgBox, Failed NetIDs:`n`n%failed%
        } else {
            MsgBox, Completed AD Rights Automation
        }
    }
return


^+7:: ; Check Rights
    gui, GuiName:New,,Check Rights
    gui, Add, Text,, If netID is not provided, AD Tool will`nopen and use the name to get the netID.
    gui, Add, Text,, First Last Name:
    gui, Add, Edit, vname w117 x+5 yp-3,
    gui, Add, Text, x-0
    gui, Add, Text, x+2.5, NetID:
    gui, Add, Edit, x+5 yp-5 vnetID w161 lowercase,
    gui, Add, Text, x-0
    gui, Add, Checkbox, checked0 vADRights x+2.5, AD Rights
    gui, Add, Checkbox, checked1 vorion, Orion
    gui, Add, Checkbox, checked0 vorionTest, Orion Test
    gui, Add, Checkbox, checked1 vgro, CRM/Gro
    gui, Add, Checkbox, checked1 vteamwork, Teamwork
    gui, Add, Button, Default w80 gGoCheck, Go
    gui, +AlwaysOnTop
    gui, Show, x2500 y200
return

GoCheck: ; This Go button will continue checking rights.
    gui, submit

    browser := ""
    if (netID == "") {
        ADRights = true
    }


    if (ADRights) {
        ; Open DCE Active Directory Tool using Windows search.
        Run, C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\CE Computer Opertations\CE Active Directory Tool.appref-ms
        if (ProgramCheck("ahk_exe ADTool - CSWPF.exe") == "Abort") {
            MsgBox, Automation has been aborted.
            return
        }
        ; Select their account.
        Send, {Tab}{Tab}{Tab}
        if (netID == "") {
            Send % name
            Send, {Enter}
            Sleep, 200
            InputBox, netID, NetID, NetID for %name%
            if ErrorLevel
            {
                MsgBox, Automation Aborted
                return
            }
        } else {
            Send % netID
            Send, {Enter}
            Sleep, 100
        }
    }


    if (orion) {
        ;Open the Orion website and search for the person.
        if (OpenSite("https://ceregadmin.byu.edu/o3/admin/person/manage/", "Manage Person") == "Cancel") {
            MsgBox, Automation has been aborted.
            return
        }

        if (browser == "") {
            browser := BrowserCheck()
            if (browser == "Abort") {
                MsgBox, Automation has been aborted.
                return
            }
        }

        Sleep, 200
        Send, {Tab}
        if (browser == "Chrome" || browser == "Edge") {
            Send, {Tab}{Tab}{Tab}
        }
        Send % netID
        Send, {Tab}Login{Tab}
        Sleep, 200
        Send, {Enter}
        ; Make sure they're signed into Orion.
        _o := OrionCheck("Manage Person - " firstName)
        if (_o == "Abort") {
            MsgBox, Automation has been aborted.
            return
        }
        ; Open the "Rights" tab of their account page.
        Sleep, 400
        if (browser == "Chrome" || browser == "Edge") {
            Send, {Tab}{Tab}{Tab}
        }
        Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Right}
         Sleep, 100
    }


    if (orionTest) {
        ;Open the Orion website and search for the person.
        if (OpenSite("https://ceregtest.byu.edu/o3/admin/person/manage/", "Manage Person") == "Cancel") {
            MsgBox, Automation has been aborted.
            return
        }

        if (browser == "") {
            browser := BrowserCheck()
            if (browser == "Abort") {
                MsgBox, Automation has been aborted.
                return
            }
        }

        Sleep, 200
        Send, {Tab}
        if (browser == "Chrome" || browser == "Edge") {
            Send, {Tab}{Tab}{Tab}
        }
        Send % netID
        Send, {Tab}Login{Tab}
        Sleep, 200
        Send, {Enter}
        ; Make sure they're signed into Orion Test.
        _oT := OrionCheck("Manage Person - " firstName)
        if (_oT == "Abort") {
            MsgBox, Automation has been aborted.
            return
        }
        ; Open the "Rights" tab of their accout page.
        Sleep, 400
        if (browser == "Chrome" || browser == "Edge") {
            Send, {Tab}{Tab}{Tab}
        }
        Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Right}
        Sleep, 100
    }


    if (gro) {
        ; Open CRM/Gro website and search for the person.
        if (OpenSite("https://gro.byu.edu/person-memberships", "BYU | Group Information") == "Cancel") {
            MsgBox, Automation has been aborted.
            return
        }

        Sleep, 500
        Send % netID
        Send, {Enter}
        Sleep, 100
    }


    if (teamwork) {
        ; If email was created successfully, open Teamwork website.
        if (OpenSite("https://byuis.teamwork.com/#/people/people", "People - BYU CE Teamwork") == "Cancel") {
            MsgBox, Automation has been aborted.
            return
        }

        if (browser == "") {
            browser := BrowserCheck()
            if (browser == "Abort") {
                MsgBox, Automation has been aborted.
                return
            }
        }

        ; Wait for website to build properly
        Sleep, 1000

        if (browser == "Chrome" || browser == "Edge") {
            Loop, 17
            {
                Send, {Tab}
            }
        }
        Sleep, 400
        Send % name
    }
return

