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

char1 := "n"
char2 := "n"
char3 := "n"
char4 := "n"
char5 := "n"
char6 := "n"

; Auto Resize
; Some people have issues with the auto resize to 800x600 and the AHK script just exit (vanish when mouse moved over)
; Set to "n" if you experience this problem as well
autoResize := "y"

vers := "2018-05-27-02"
