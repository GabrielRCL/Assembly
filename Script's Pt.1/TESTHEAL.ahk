;=======GLOBAL=======
ListLines Off
#SingleInstance Force
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SendMode Input
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1

;===========Variaveis==========
SetTimer, AutoHealingMana, 200	;0,2 segundos



;==========READ MEMORY==========
WinGet, pid, pid, ahk_class Qt5QWindowOwnDCIcon
hProcess := openProcess(pid) ; you only need to do this once (unless the program closes or you close the handle)
readMemory(hProcess, address, type := "Int")
{
	static aTypeSize := {    "UChar":    1,  "Char":     1
	                    ,   "UShort":   2,  "Short":    2
	                    ,   "UInt":     4,  "Int":      4
	                    ,   "UFloat":   4,  "Float":    4 	; Ufloat doesnt really exist, but its interpreted as a float
	                    ,   "Int64":    8,  "Double":   8}  
    ; If invalid type RPM() returns success (as bytes to read resolves to null in dllCall())
    ; so set errorlevel to invalid parameter for DLLCall() i.e. -2
    if !aTypeSize.hasKey(type)
        return "", ErrorLevel := -2 
    if DllCall("ReadProcessMemory", "Ptr",  hProcess, "Ptr", address, type "*", result, "Ptr", aTypeSize[type], "Ptr", 0)
        return result
    return        
}
openProcess(PID, dwDesiredAccess := 0x001F0FFF) ; Default is all access
{
    return DllCall("OpenProcess", "UInt", dwDesiredAccess, "Int", False, "UInt", PID, "Ptr") ; NULL/Blank if failed to open process for some reason
}   
closeHandle(hProcess)
{
    return DllCall("CloseHandle", "Ptr", hProcess)
}
;==========FINISH==========



Home::
	Pause
return


AutoHealingMana:
if ( readMemory(hProcess, 0x1997D1DC, "Int") <= 3000 )
{
	ControlSend,, {F4}, ahk_class Qt5QWindowOwnDCIcon
}
;closeHandle(hProcess) ; You only need to close the handle when finished reading data (e.g. when the script exits), not after every read.
return

AutoHur:
if ( readMemory(hProcess, 0x1997D1DC, "Int") <= 3000 )
{
	ControlSend,, {F4}, ahk_class Qt5QWindowOwnDCIcon
}
return