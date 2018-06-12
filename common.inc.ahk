; -----------------------------------------------------------------------------------
; DO NOT EDIT BELOW
; -----------------------------------------------------------------------------------


; Register the exit function
OnExit("exitFunc")


global version := "2018-06-02-01"
global slot1 := "n", slot2 := "n", slot3 := "n", slot4 = "n", slot5 := "n", slot6 := "n"
global slotRun1 := "0", slotRun2 := "999000", slotRun3 := "999000", slotRun4 := "999000", slotRun5 := "999000", slotRun6 := "999000"
global slotExit1 := "0", slotExit2 := "0", slotExit3 := "0", slotExit4 := "0", slotExit5 := "0", slotExit6 := "0"
global totalStartTime := "0"
global currentStartTime := "0"
global poeAutoResize := "y"

global playSound            := "n"
global sendEmail            := "n"
global sendEmailTo          := ""
global sendEmailProvider    := ""
global sendEmailLogin       := ""
global sendEmailPassword    := ""
global sendEmailServer      := ""
global sendEmailPort        := ""
global sendEmailSSL         := ""

global levelingExit         := 120

global origX                := 0
global origY                := 0
global origWidth            := 0
global origHeight           := 0

chkAdmin() {
    ; If the script is not elevated, relaunch as administrator and kill current instance:
    full_command_line := DllCall("GetCommandLine", "str")
    if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)")) {
        try ; leads to having the script re-launching itself as administrator
        {
            if A_IsCompiled
                Run *RunAs "%A_ScriptFullPath%" /restart
            else
                Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
        ExitApp
    }
}



chkConfig() {
    IfNotExist, config.ahk
    {
        FileCopy, config.tpl, config.ahk
        MsgBox, No prior config file found. Default config was created from template. You'll need to enable desired character slots.
        ExitApp
    }
    
    ; Load the config file
    #Include config.ahk

    ; assign vars from config to script vars
    slot1 := char1
    slot2 := char2
    slot3 := char3
    slot4 := char4
    slot5 := char5
    slot6 := char6
    poeAutoResize := autoResize

    playSound           := sound
    sendEmail           := email
    sendEmailTo         := emailTo
    sendEmailProvider   := emailProvider
    sendEmailLogin      := emailLogin
    sendEmailPassword   := emailPassword
    sendEmailServer     := emailServer
    sendEmailPort       := emailPort
    sendEmailSSL        := emailSSL

    levelingExit        := lvlExit * 1000

}



buildSlots() {

    charArray := Object()

    if (slot1 = "y") {
        charArray.Push([100, 125])
    }
    if (slot2 = "y") {
        charArray.Push([145, 170])
    }
    if (slot3 = "y") {
        charArray.Push([190, 215])
    }
    if (slot4 = "y") {
        charArray.Push([235, 260])
    }
    if (slot5 = "y") {
        charArray.Push([280, 305])
    }
    if (slot6 = "y") {
        charArray.Push([325, 350])
    }
    return charArray
}



sleepRandom(min, max) {
    Random, s, %min%, %max%
    Sleep %s%
}



initializePoE() {
    ; Set PoE to active Window
    WinActivate, Path of Exile
    sleepRandom(800, 1200)
    ; Resize PoE to 800x600
    if (poeAutoResize = "y") {
        WinGetPos, origX, origY, origWidth, origHeight, Path of Exile
        WinMove, Path of Exile, , , , 800, 600
    }
    sleepRandom(800, 1200)
}



goToCharSelection(j) {
    ; Set PoE to active Window
    WinActivate, Path of Exile
    ; Open Chat Input
    Send {enter}
    sleepRandom(800, 1200)
    ; Enter exit string
    Send /exit
    sleepRandom(800, 1200)
    ; Submit exit string
    Send {enter}
    sleepRandom(4000, 6000)
    slotExit%j% := A_TickCount
}



checkHillock(runCount, totalRunTimeM) {
    PixelSearch, Px, Py, 565, 120, 650, 140, 0x00FF00, 3, Fast
    if ErrorLevel {
        ; Uber Hillock was not found; do nothing
    } else {
        if ( playSound = "y" ) {
            SoundPlay, %A_WinDir%\Media\ding.wav
        }
        if ( sendEmail = "y" ) {
            emailText := "Uber Hillock was found. Get your Oni-Goroshi by killing him. It only took " . runCount . " attempts and " . totalRunTimeM "m."
            sendEmail(emailText)
        }
        MsgBox, Uber Hillock was found. Get your Oni-Goroshi by killing him. It only took %runCount% runs.

        ; Restore original window
        if (poeAutoResize = "y") {
            WinMove, Path of Exile, , %origX%, %origY%, %origWidth%, %origHeight%
        }
        ExitApp
    }
}



sendEmail(emailText) {
    pmsg                            := ComObjCreate("CDO.Message")
    pmsg.From                       := sendEmailLogin
    pmsg.To                         := sendEmailTo
    pmsg.Subject                    := "OneeChanFarming - Uber Hillock found"
    pmsg.TextBody                   := emailText
    fields                          := Object()
    fields.smtpserver               := sendEmailServer
    fields.smtpserverport           := sendEmailPort
    fields.smtpusessl               := sendEmailSSL
    fields.sendusing                := 2                            ; cdoSendUsingPort
    fields.smtpauthenticate         := 1                            ; cdoBasic
    fields.sendusername             := sendEmailLogin
    fields.sendpassword             := sendEmailPassword
    fields.smtpconnectiontimeout    := 60
    schema                          := "http://schemas.microsoft.com/cdo/configuration/"
    pfld                            :=  pmsg.Configuration.Fields

    if ( sendEmailProvider = "Google" ) {
        fields.smtpserver       := "smtp.gmail.com"
        fields.smtpserverport   := 465
        fields.smtpusessl       := True
    }

    if ( sendEmailProvider = "Hotmail" ) {
        fields.smtpserver       := "smtp.live.com"
        fields.smtpserverport   := 587
        fields.smtpusessl       := True
    }

    if ( sendEmailProvider = "Outlook.com" ) {
        fields.smtpserver       := "smtp-mail.outlook.com"
        fields.smtpserverport   := 587
        fields.smtpusessl       := True
    }

    For field,value in fields
        pfld.Item(schema . field)   := value
    pfld.Update()
    Loop, Parse, sAttach, |, %A_Space%%A_Tab%
        pmsg.AddAttachment(A_LoopField)
    pmsg.Send()
    return
}



exitFunc() {
    ; For some reasons I need to have something else in here, otherwise it would just do weird stuff.
    MsgBox, Thank you for using my script. Feel free to submit improvements.
    ; Restore original window
    if (poeAutoResize = "y") {
        WinMove, Path of Exile, , %origX%, %origY%, %origWidth%, %origHeight%
    }
}