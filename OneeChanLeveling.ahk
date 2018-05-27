; -----------------------------------------------------------------------------------
; DO NOT EDIT BELOW
; -----------------------------------------------------------------------------------

; If the script is not elevated, relaunch as administrator and kill current instance:
full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try ; leads to having the script re-launching itself as administrator
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}

global version := "2018-05-17-01"
global slot1 := "n", slot2 := "n", slot3 := "n", slot4 = "n", slot5 := "n", slot6 := "n"
global enableTray := "n"

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
}


mainRoutine() {
    charArray := buildSlots()

    ; Get number of slot entries
    i := 0
    for j, ele in charArray {
        i++
    }

    if (i < 3) {
        MsgBox, You need at least 3 characters for rotating. You have selected only %i%.
        ExitApp
    }

    runCount := 1
    totalStartTime := A_TickCount
    currentStartTime := A_TickCount
    Loop {
        for j, ele in charArray {
            totalRunTime := (A_TickCount - totalStartTime) / 1000
            currentRunTime := (A_TickCount - currentStartTime) / 1000
            avgRunTime := totalRunTime / (runCount - 1)
            totalRunTime := round(totalRunTime)
            currentRunTime := round(currentRunTime)
            avgRunTime := round(avgRunTime, 1)
            avgResetTime := round(avgRuntime * (i - 1), 1)
;            ToolTip, Uber Hillock Run No.: %runCount%`nTotal Run Time: %totalRunTime%s`nLast Run Duration: %currentRunTime%s`nAverage Run Duration: %avgRunTime%s`nAverage Time for Resetting: %avgResetTime%s, 20, 10
            currentStartTime := A_TickCount
                
            x1 := 520
            x2 := 750
            y1 := charArray[j, 1]
            y2 := charArray[j, 2]

            ; Move mouse to proper Coords
            WinActivate, Path of Exile
            Random, x , %x1%, %x2%
            Random, y , %y1%, %y2%
            Click, %x%, %y%, 0
            sleepRandom(800, 1200)
            Click, 2

            ; Char is now in The Twilight Strand
            sleepRandom(4000, 8000)
            
            ; Start Bot
            WinActivate, , PoE Version
            ControlClick, Button3, , PoE Version, LEFT,, NA
            exitSearchStart := A_TickCount
            loop {
                ImageSearch, Px, Py, 655, 35, 805, 100, *9 exit.bmp
                if ErrorLevel {
                    ; Town Exit was not found; do nothing
                } else {
                    ; Town Exit was found; Hillock was killed, cycle to next char
                    ; Also make a little pause for picking up items
                    sleepRandom(4000, 6000)
                    break
                }
                ; Also stop bot after 2 minutes
                exitSearchCurrent := A_TickCount
                exitSearchRun := exitSearchCurrent - exitSearchStart
                if(exitSearchRun >= 120000) {
                    break
                }
            }
            ; Stop Bot
            WinActivate, , PoE Version
            Send {F12}
            sleepRandom(1000, 2000)
            ControlClick, Button3, , PoE Version, LEFT,, NA
            sleepRandom(3000, 5000)
            goToCharSelection(j)
            runCount++
        }
    }
}

chkConfig()
initializePoE()
mainRoutine()

F4::pause, toggle
