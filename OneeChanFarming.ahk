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
        MsgBox, You need at least 3 characters for rotating. You have selected only %i%. You have selected only %i%. Edit your config.ahk.
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
            totalRunTimeM := round(totalRunTime / 60)
            currentRunTime := round(currentRunTime)
            avgRunTime := round(avgRunTime, 1)
            avgResetTime := round(avgRuntime * (i - 1), 1)

            ToolTip, Uber Hillock Run No.: %runCount%`nTotal Run Time: %totalRunTime%s / %totalRunTimeM%m`nLast Run Duration: %currentRunTime%s`nAverage Run Duration: %avgRunTime%s`nAverage Time for Resetting: %avgResetTime%s, 20, 10

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
            ; Random Movement till next run slot is ready
            if (j < i) {
                k := j + 1
            } else {
                k := 1
            }
            loop {
                if (slotRun%k% > 100000) {
                    slotRun%k% := 0
                    break
                } else {
                    Random, x, 200, 700
                    Random, y, 100, 300
                    Click, left, %x%, %y%
                    sleep sleepRandom(500, 3000)
                    slotCurrentRun := A_TickCount
                    slotRun%k% := % slotCurrentRun - slotExit%k%
                }
            }                        

            WinActivate, Path of Exile
            checkHillock(runCount, totalRunTimeM)
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
