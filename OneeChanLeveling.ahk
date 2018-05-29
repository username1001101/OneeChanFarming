; -----------------------------------------------------------------------------------
; DO NOT EDIT BELOW
; -----------------------------------------------------------------------------------

; Load the common.inc.ahk file
#Include common.inc.ahk



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
            WinActivate, , Elite status
            sleepRandom(200, 400)
            ControlClick, Button3, , Elite status, LEFT,, NA
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
            WinActivate, , Elite status
            sleepRandom(200, 400)
            Send {F12}
            sleepRandom(1000, 2000)
            ControlClick, Button3, , Elite status, LEFT,, NA
            sleepRandom(3000, 5000)
            goToCharSelection(j)
            runCount++
        }
    }
}



chkAdmin()
chkConfig()
initializePoE()
mainRoutine()



F4::pause, toggle
