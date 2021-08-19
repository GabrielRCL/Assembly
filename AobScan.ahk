#include <classMemory>
SetTimer, AutoHur, 20

if (_ClassMemory.__Class != "_ClassMemory")
{
    msgbox class memory not correctly installed. 
    ExitApp
}

WinGet, pid, pid, ahk_class Qt5QWindowOwnDCIcon

mem := new _ClassMemory("ahk_pid " PID, "", hProcess) ; note tha quotes and space around AHK_Pid

if !IsObject(mem)
{
    if (hProcess = "")
        msgbox OpenProcess failed. If the target process has admin rights, then the script also needs to be ran as admin. Consult A_LastError for more information.
    else msgbox The program isn't running (not found) or you passed an incorrect program identifier parameter.
    ExitApp
}
aPattern := [0x15, 0x00, 0x00, 0x00, 0x1C, 0x00, 0x00, 0x00, 0x64, 0x5F]
address := mem.processPatternScan(,, aPattern*)

AutoHur:
if (address != 22)
{
    ControlSend,, {NumpadDiv}, ahk_class Qt5QWindowOwnDCIcon
}
return