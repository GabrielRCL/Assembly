;==============================CONFIGURAÇÕES/CONFIGS==============================
;1) AUTO HEALING MANA:
Valor_Para_Healar_Mana := 4500	;Se sua [MANA] estiver abaixo desse valor o BOT irá Apertar a [Hotkey_de_ManaPotion]
Hotkey_de_ManaPotion = {F4}		;Hotkey da ManaPotion no TIBIA!!! irá ser pressionada assim que a mana estiver abaixo do [Valor_Para_Healar_Mana] 

;2) AUTO HEALING LIFE: 
;[ESTAGIO 1]
Valor_Para_Healar_Vida1 :=		;Se sua [VIDA] estiver abaixo desse valor o BOT irá Apertar a [Hotkey_de_Cura1] e [Hotkey_de_HealthPotion1]
Hotkey_de_Cura1 =				;Hotkey da SPELL de CURA no TIBIA!!! irá ser pressionada assim que a vida estiver abaixo do [Valor_Para_Healar_Vida1] 
Hotkey_de_HealthPotion1 =		;Hotkey da HealthPotion no TIBIA!!! irá ser pressionada assim que a vida estiver abaixo do [Valor_Para_Healar_Vida1] 
;[ESTAGIO 2]
Valor_Para_Healar_Vida2 :=
Hotkey_de_Cura2 =
Hotkey_de_HealthPotion2 =
;[ESTAGIO 3]
Valor_Para_Healar_Vida3 := 1100	;Se sua [VIDA] estiver abaixo desse valor o BOT irá Apertar a [Hotkey_de_Cura1] e [Hotkey_de_HealthPotion1]
Hotkey_de_Cura3 = {F2}			;Hotkey da SPELL de CURA no TIBIA!!! irá ser pressionada assim que a vida estiver abaixo do [Valor_Para_Healar_Vida1] 
Hotkey_de_HealthPotion3 =		;Hotkey da HealthPotion no TIBIA!!! irá ser pressionada assim que a vida estiver abaixo do [Valor_Para_Healar_Vida1] 

;3)
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
#Include <classMemory>
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

SetTimer, Auto_Heal_Life, 20
SetTimer, Auto_Heal_Mana, 20
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
mem := new _ClassMemory("ahk_class Qt5QWindowOwnDCIcon", "", hProcessCopy) ; *****

; Check if the above method was successful.
if !isObject(mem) 
{
    msgbox [Auto_Heal_Mana] Falha ao verificar memoryAdress
    if (hProcessCopy = 0)
        msgbox O Programa nao esta aberto (nao foi encontrado) ou esta com um endereço invalido
    else if (hProcessCopy = "")
        msgbox OpenProcess failed. If the target process has admin rights, then the script also needs to be ran as admin. Consult A_LastError for more information.
    ExitApp
}
;==============================[END]==============================





;==============================[Auto_Heal_Mana]==============================
Auto_Heal_Mana:
Loop
{
; read a pointer - mem.BaseAddress is automatically set to the base address.
Mana := mem.read(mem.BaseAddress + 0x00D288D0, "Int", 0x74, 0x130, 0x3C, 0x1BC, 0x4C, 0x44)
if ( Mana <= Valor_Para_Healar_Mana )
{
	ControlSend,, %Hotkey_de_ManaPotion%, ahk_class Qt5QWindowOwnDCIcon
	Sleep 500
}
return
}
return

;==============================[END]==============================






;==============================[Auto_Heal_Life]==============================

Auto_Heal_Life:
Loop
{
; read a pointer - mem.BaseAddress is automatically set to the base address.
Vida := mem.read(mem.BaseAddress + 0x00D2B40C, "Int", 0x54, 0x04, 0x4C8, 0x6F4, 0x520)
if ( Vida <= Valor_Para_Healar_Vida3 )
{
	if ( Vida <= Valor_Para_Healar_Vida2 )
	{
		if ( Vida <= Valor_Para_Healar_Vida1 )
		{
			ControlSend,, %Hotkey_de_Cura1%, ahk_class Qt5QWindowOwnDCIcon
			Sleep 50
			ControlSend,, %Hotkey_de_HealthPotion1%, ahk_class Qt5QWindowOwnDCIcon
			Sleep 500
			return
		}
		ControlSend,, %Hotkey_de_Cura2%, ahk_class Qt5QWindowOwnDCIcon
		Sleep 50
		ControlSend,, %Hotkey_de_HealthPotion2%, ahk_class Qt5QWindowOwnDCIcon
		Sleep 500
		return
	}
	ControlSend,, %Hotkey_de_Cura3%, ahk_class Qt5QWindowOwnDCIcon
	Sleep 50
	ControlSend,, %Hotkey_de_HealthPotion3%, ahk_class Qt5QWindowOwnDCIcon
	Sleep 500
	return
}
return
}
return

;==============================[END]==============================





;==============================[Auto_Hur]==============================
Auto_Hur:
Loop
{
; read a pointer - mem.BaseAddress is automatically set to the base address.
Hur := mem.read(0x0D7CE978, "Int")
if ( Hur != 22 )
{
	ControlSend,, %Hotkey_de_UtaniHur%, ahk_class Qt5QWindowOwnDCIcon
	Sleep 500
}
return
;==============================[END]==============================
}
return