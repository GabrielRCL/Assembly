;==============================CONFIGURAÇÕES/CONFIGS==============================
;1) UTANI HUR CONFIG
Hotkey_de_UtaniHur = {NumpadDiv}










;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================




;==============================[GLOBAL]==============================
; The contents of this file can be copied directly into your script. Alternately, you can copy the classMemory.ahk file into your library folder,
; in which case you will need to use the #include directive in your script i.e. 
#Include classMemory.ahk
#Persistent
#SingleInstance Force
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
SendMode, Input
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1

SetTimer, Auto_Hur, 20


; You can use this code to check if you have installed the class correctly.
if (_ClassMemory.__Class != "_ClassMemory")
{
    msgbox class memory not correctly installed. Or the (global class) variable "_ClassMemory" has been overwritten
    ExitApp
}

; Open a process with sufficient access to read and write memory addresses (this is required before you can use the other functions)
; You only need to do this once. But if the process closes/restarts, then you will need to perform this step again.
; .isHandleValid() can be used to check if program has restarted.
; Note: The program identifier can be any AHK windowTitle i.e.ahk_exe, ahk_class, ahk_pid, or simply the window title. 
; Unlike AHK this defaults to an exact match, but this can be changed via the passed parameter.
; hProcessCopy is an optional variable in which the opened handled is stored. 


; *****  change FTLGAME.exe to your process name ******
memHur := new _ClassMemory("ahk_class Qt5QWindowOwnDCIcon", "", hProcessCopy) ; *****

; Check if the above method was successful.
if !isObject(memHur) 
{
    msgbox [Auto_Hur] Falha ao verificar memoryAdress
    if (hProcessCopy = 0)
        msgbox O Programa nao esta aberto (nao foi encontrado) ou esta com um endereço invalido
    else if (hProcessCopy = "")
        msgbox OpenProcess failed. If the target process has admin rights, then the script also needs to be ran as admin. Consult A_LastError for more information.
    ExitApp
}
return
;==============================[END]==============================





;==============================[Auto_Hur]==============================
Auto_Hur:
; read a pointer - mem.BaseAddress is automatically set to the base address.
Hur := memHur.read(0x0CA3F484, "Double")
Sleep 100
if ( Hur == 805306495)
{
	ControlSend,, %Hotkey_de_UtaniHur%, ahk_class Qt5QWindowOwnDCIcon
	Sleep 500
}
return
;==============================[END]==============================