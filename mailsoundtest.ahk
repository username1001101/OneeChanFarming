; -----------------------------------------------------------------------------------
; DO NOT EDIT BELOW
; -----------------------------------------------------------------------------------

; Load the common.inc.ahk file
#Include common.inc.ahk

chkConfig()

if ( playSound = "y" ) {
    MsgBox, "Sound Test: You did enable the sound. After closing this box, you should hear the a ding."
    SoundPlay, %A_WinDir%\Media\ding.wav
} else {
    MsgBox, "Sound Test: You didn't enable the sound. So nothing will be played."
}

if ( sendEmail = "y" ) {
    MsgBox, "Email Test: You did enable the email. After closing this box, an email will be sent."
    emailText = Sending email from OneeChanFarming works.
    sendEmail(emailText)
} else {
    MsgBox, "Email Test: You did not enable the email. No email will be sent."
}
