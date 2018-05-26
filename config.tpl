; For prerequisites consult the README.MD
;
; Quick Starter Guide:
; - Install the PoEHUD and run it with PoE
; - Enable Preload Alerts in the PoEHUD
; - Install AutoHotKey
; - Set the char slots below that shall be used (no scrolling of the chars possible)
; - Select at least 3 char slots
; - If you want permanent updates on how many runs were made, enable the enableTray option
; - Save the script with your slots/tray notification settings
; - Go to the character selection in PoE
; - Run the script

char1 := "n"
char2 := "n"
char3 := "n"
char4 := "n"
char5 := "n"
char6 := "n"

; This may not work in all windows versions. It worked for me until I updated Win10 to v1803
enableTray := "n"

vers := "2018-05-17-01"
