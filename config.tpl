; For prerequisites consult the README.MD
;
; Quick Starter Guide:
; - Install the PoEHUD and run it with PoE
; - Enable Preload Alerts in the PoEHUD
; - Install AutoHotKey
; - Set the char slots to "y" below that shall be used (no scrolling of the chars possible)
; - Select at least 3 char slots
; - If you want permanent updates on how many runs were made, enable the enableTray option
; - Save the script with your slots/tray notification settings
; - Go to the character selection in PoE
; - Run the script

; Setup the character slots that should be used, y = use; n = don't use
char1 := "n"
char2 := "n"
char3 := "n"
char4 := "n"
char5 := "n"
char6 := "n"


; Make sound when Uber Hillock was found?
sound := "n"


; Send email when Uber Hillock was found?
email           := "n"
emailTo         := "user@domain.tld"        ; set the email address where the email should be sent to
emailProvider   := ""                       ; set to "Google" if you have a gmail account or "Hotmail" if you have a hotmail account or "Outlook.com" if you have an outlook.com account
                                            ; if you want to use Google/Gmail, then you have to set the account to allow less secure apps, see here:
                                            ; https://support.google.com/accounts/answer/6010255?hl=en
emailLogin      := ""                       ; provide your login for the sending email
emailPassword   := ""                       ; provide your password for the sending email
; -- the fields below are only required if you don't use a pre-setup provider like "Google"
emailServer     := ""                       ; the smtp server, often smtp.provider.tld
emailPort       := "587"                    ; provide port to which email is sent, usually 587, 465 or 25
emailSSL        := True                     ; set True/False depending whether your email provider supports SSL/TLS


; Adjust hard-leveling timeout
; Currently the tools switches to next toon when Hillock was killed or when it run for a given length.
; Set the timeout below

lvlExit         := 120                      ; 120 seconds, default


; Auto Resize
; Some people have issues with the auto resize to 800x600 and the AHK script just exit (vanish when mouse moved over)
; Set to "n" if you experience this problem as well
autoResize := "y"

vers := "2018-06-02-01"
