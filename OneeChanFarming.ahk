; -----------------------------------------------------------------------------------
; DO NOT EDIT BELOW
; -----------------------------------------------------------------------------------

global version := "2018-05-17-01"
global slot1 := "n", slot2 := "n", slot3 := "n", slot4 = "n", slot5 := "n", slot6 := "n"
global slotRun1 := "0", slotRun2 := "999000", slotRun3 := "999000", slotRun4 := "999000", slotRun5 := "999000", slotRun6 := "999000"
global slotExit1 := "0", slotExit2 := "0", slotExit3 := "0", slotExit4 := "0", slotExit5 := "0", slotExit6 := "0"
global enableTray := "n"
global totalStartTime := "0"
global currentStartTime := "0"

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
    enableTray := enableTrayNotification
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
    WinMove, Path of Exile, , , , 800, 600
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


checkHillock(runCount) {
    PixelSearch, Px, Py, 565, 120, 650, 140, 0x00FF00, 3, Fast
    if ErrorLevel {
        ; Uber Hillock was not found; do nothing
    } else {
        MsgBox, Uber Hillock was found. Get your Oni-Goroshi by killing him. It only took %runCount% runs.
        ExitApp
    }
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
            if (enableTray = "y") {
                ToolTip, Uber Hillock Run No.: %runCount%`nTotal Run Time: %totalRunTime%s`nLast Run Duration: %currentRunTime%s`nAverage Run Duration: %avgRunTime%s`nAverage Time for Resetting: %avgResetTime%s, 20, 10
            }
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
            checkHillock(runCount)
            goToCharSelection(j)
            runCount++
        }
    }
}

chkConfig()
initializePoE()
mainRoutine()

F4::pause, toggle