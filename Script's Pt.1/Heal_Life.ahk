;==============================CONFIGURA��ES/CONFIGS==============================
;2) AUTO HEALING LIFE: 
;[ESTAGIO 1]
Porcentagem_Para_Healar_Vida1 := 95		;Se sua [VIDA] estiver abaixo desse valor o BOT ir� Apertar a [Hotkey_de_Cura1] e [Hotkey_de_HealthPotion1]
Hotkey_de_Cura1 = {F2}						;Hotkey da SPELL de CURA no TIBIA!!! ir� ser pressionada assim que a vida estiver abaixo do [Valor_Para_Healar_Vida1] 
Hotkey_de_HealthPotion1 =				;Hotkey da HealthPotion no TIBIA!!! ir� ser pressionada assim que a vida estiver abaixo do [Valor_Para_Healar_Vida1] 
;[ESTAGIO 2]
Porcentagem_Para_Healar_Vida2 := 75
Hotkey_de_Cura2 = {k}
Hotkey_de_HealthPotion2 =
;[ESTAGIO 3]
Porcentagem_Para_Healar_Vida3 := 60		;Se sua [VIDA] estiver abaixo desse valor o BOT ir� Apertar a [Hotkey_de_Cura1] e [Hotkey_de_HealthPotion1]
Hotkey_de_Cura3 = {F1}					;Hotkey da SPELL de CURA no TIBIA!!! ir� ser pressionada assim que a vida estiver abaixo do [Valor_Para_Healar_Vida1] 
Hotkey_de_HealthPotion3 =				;Hotkey da HealthPotion no TIBIA!!! ir� ser pressionada assim que a vida estiver abaixo do [Valor_Para_Healar_Vida1] 









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

SetTimer, Auto_Heal_Life, 20


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
memLife := new _ClassMemory("ahk_class Qt5QWindowOwnDCIcon", "", hProcessCopy) ; *****

; Check if the above method was successful.
if !isObject(memLife) 
{
    msgbox [Auto_Heal_Life] Falha ao verificar memoryAdress
    if (hProcessCopy = 0)
        msgbox O Programa nao esta aberto (nao foi encontrado) ou esta com um endere�o invalido
    else if (hProcessCopy = "")
        msgbox OpenProcess failed. If the target process has admin rights, then the script also needs to be ran as admin. Consult A_LastError for more information.
    ExitApp
}
return
;==============================[END]==============================





;==============================[Auto_Heal_Life]==============================
Auto_Heal_Life:
; read a pointer - mem.BaseAddress is automatically set to the base address.
Vida := memLife.read(memLife.BaseAddress + 0x00E09DDC, "Int", 0x43C, 0x354, 0x120, 0x124, 0, 0x170, 0xD70)
VidaMAX := memLife.read(memLife.BaseAddress + 0x00E09DDC, "Int", 0x43C, 0x354, 0x120, 0x124, 0, 0x178, 0xD38)
Sleep 100
if ( ((Vida/VidaMAX)*100) <= Porcentagem_Para_Healar_Vida1 )
{
	if ( ((Vida/VidaMAX)*100) <= Porcentagem_Para_Healar_Vida2 )
	{
		if ( ((Vida/VidaMAX)*100) <= Porcentagem_Para_Healar_Vida3 )
		{
			ControlSend,, %Hotkey_de_Cura3%, ahk_class Qt5QWindowOwnDCIcon
			Sleep 50
			ControlSend,, %Hotkey_de_HealthPotion3%, ahk_class Qt5QWindowOwnDCIcon
			Sleep 500
			return
		}
		ControlSend,, %Hotkey_de_Cura2%, ahk_class Qt5QWindowOwnDCIcon
		Sleep 50
		ControlSend,, %Hotkey_de_HealthPotion2%, ahk_class Qt5QWindowOwnDCIcon
		Sleep 500
		return
	}
	ControlSend,, %Hotkey_de_Cura1%, ahk_class Qt5QWindowOwnDCIcon
	Sleep 50
	ControlSend,, %Hotkey_de_HealthPotion1%, ahk_class Qt5QWindowOwnDCIcon
	Sleep 500
	return
}
return
;==============================[END]==============================