;==============================CONFIGURAÇÕES/CONFIGS==============================
;1) AUTO HEALING MANA:
Porcentagem_Para_Healar_Mana := 80	;Se sua [MANA] estiver abaixo desse valor o BOT irá Apertar a [Hotkey_de_ManaPotion]
Hotkey_de_ManaPotion = {F4}				;Hotkey da ManaPotion no TIBIA!!! irá ser pressionada assim que a mana estiver abaixo do [Valor_Para_Healar_Mana] 










;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================
;==============================!!!!!NAO EDITE NADA DAQUI PRA BAIXO!!!!!!==============================




;==============================[GLOBAL]==============================
; The contents of this file can be copied directly into your script. Alternately, you can copy the classMemory.ahk file into your library folder,
; in which case you will need to use the #include directive in your script i.e. 
#Include <classMemory>
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

SetTimer, Auto_Heal_Mana, 20

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
memMana := new _ClassMemory("ahk_class Qt5QWindowOwnDCIcon", "", hProcessCopy) ; *****

; Check if the above method was successful.
if !isObject(memMana) 
{
    msgbox [Auto_Heal_Mana] Falha ao verificar memoryAdress
    if (hProcessCopy = 0)
        msgbox O Programa nao esta aberto (nao foi encontrado) ou esta com um endereço invalido
    else if (hProcessCopy = "")
        msgbox OpenProcess failed. If the target process has admin rights, then the script also needs to be ran as admin. Consult A_LastError for more information.
    ExitApp
}
return
;==============================[END]==============================




;==============================[Auto_Heal_Mana]==============================
Auto_Heal_Mana:
; read a pointer - mem.BaseAddress is automatically set to the base address.
Mana := memMana.read(memMana.BaseAddress + 0x00DD8C5C, "Int", 0xC0, 0x6D4, 0x18, 0x610, 0x3C, 0, 0x710)
ManaMAX := memMana.read(memMana.BaseAddress + 0x00DD8C5C, "Int", 0xC0, 0x6D4, 0x18, 0x610, 0x3C, 0, 0x718)
Sleep 100
if ( ((Mana/ManaMAX)*100) <= Porcentagem_Para_Healar_Mana )
{
	ControlSend,, %Hotkey_de_ManaPotion%, ahk_class Qt5QWindowOwnDCIcon
	Sleep 500
}
return
;==============================[END]==============================