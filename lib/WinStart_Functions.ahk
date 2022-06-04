onStart()
{
	Run, Open "c:\cmd_\AHKs\lib\taskkill.ahk.BAT" ,, Hide
	runGest( false )
	scripts := []
	scripts.Push("C:\cmd_\AHKs\KeyHoldHotekys.ahk")
	scripts.Push("C:\cmd_\AHKs\CodingHotstrings.ahk")
	scriPIDs := []
	for si, script in scripts {
		scriPIDs.Push( ahkScion( script ) )
	}
/*
	igPath := "C:\cmd_\AHKs\invertGray.ahk"
	igPIDpath := "C:\cmd_\AHKs\lib\igPID.var"
	Run, %igPath%, Hide, igPID
	FileDelete, %igPIDpath%
	FileAppend, igPID, %igPIDpath%
*/
	return % scriPIDs
}

; ON TERMINATION OF WinStartMain.AHK
exitum()
{
	global subscripts
	DetectHiddenWindows, On
	for ssi, sPID in subscripts
		WinKill, ahk_pid %sPID%
	DetectHiddenWindows, Off
	return
}


; S A V E S
;-----------

; SYNTHWAVE SCHEMACHROMATIKA SAVE & DiSTRiBUTE
uiThemeSave()
{
	SendInput, ^s
	synthwaveMASTER := "C:\cmd_\ATOM\SYNTHWAVE_schemaChromatika.less"
	fiPaths := []
	fiPaths.Push("C:\Users\blods\.atom\packages\syrinx-dark-syntax\styles\colors.less")
	fiPaths.Push("C:\Users\blods\.atom\packages\nord-atom-ui\styles\synthwave.less")
	fiPaths.Push("C:\Users\blods\.atom\synthwaveSC.less")
	fiPaths.Push("C:\cmd_\AHKs\lib\SWsX.ahk")
	for i, cp in fiPaths
		FileCopy, % synthwaveMASTER, % cp, 1
	return
}

; SAVE ACTiVE & CREATE BACKUP
saveBAK()
{
	SendInput, {Ctrl down}{s down}{s up}{Ctrl up}
	currentFi := ghostCopy(true)
	fiNameDotExt := ""
	SplitPath, currentFi, fiNameDotExt
	bakPath := "C:\cmd_\BAKs\" . fiNameDotExt . ".BAK" . A_Now
	FileCopy, %currentFi%, %bakPath%, 1
	return
}

; T O G G L E S
;------------------
;		N	U	L	L

; A T O M   P R O J E C T   A R R A Y S
;------------------------------------------

openAtomProj( projName )
{
	atomProjAtom := {}
	atomProjAtom.Push("C:\Users\blods\.atom\")
	atomProjAtom.Push("C:\Users\blods\.atom\packages\syrinx-dark-syntax\")
	atomProjAtom.Push("C:\Users\blods\.atom\packages\nord-atom-ui\")
	atomProjAtom.Push("C:\Users\blods\.atom\init.coffee")
	atomProjAtom.Push("C:\Users\blods\.atom\styles.less")
	atomProjAtom.Push("C:\Users\blods\.atom\packages\syrinx-dark-syntax\styles\editor.less")
	atomProjAtom.Push("C:\Users\blods\.atom\packages\script\styles\script.less")
	atomProjAtom.Push("C:\Users\blods\.atom\packages\syrinx-dark-syntax\styles\syntax-variables.less")
	atomProjAtom.Push("C:\cmd_\ATOM\SYNTHWAVE_schemaChromatika.less")

	atomProjAHK := {}
	atomProjAHK.Push("C:\cmd_\AHKs\")
	atomProjAHK.Push("C:\cmd_\AHKs\WinStartMain.ahk")
	atomProjAHK.Push("C:\cmd_\AHKs\lib\WinStart_Functions.ahk")
	atomProjAHK.Push("C:\cmd_\AHKs\KeyHoldHotekys.ahk")
	atomProjAHK.Push("C:\cmd_\AHKs\CodingHotstrings.ahk")
	atomProjAHK.Push("C:\cmd_\AHKs\WinStart_LOAD.ahk")
	atomProjAHK.Push("C:\cmd_\AHKs\lib\ToggleStateBlink.ahk")
	atomProjAHK.Push("C:\cmd_\AHKs\lib\DiTriToggle.ahk")
	atomProjAHK.Push("C:\cmd_\AHKs\lib\Fellmark.ahk")
	atomProjAHK.Push("C:\cmd_\AHKs\lib\Lightkey.ahk")

	atomProjCS := {}
	atomProjCS.Push("C:\cmd_\CODE\")
	atomProjCS.Push("C:\cmd_\CODE\SearchMatrix.cs")
	atomProjCS.Push("C:\cmd_\CODE\SearchMatrix_DESCRIPTION.jpg")
	atomProjCS.Push("C:\cmd_\CODE\ToHex.cs")

	return
}

; T O O L S
;---------------

; HOLD SCRiPT UNTiL USER iNPUT iS ALLOWED
holdForInputCursor()
{
	keepHolding := true
 	while ( keepHolding )
	{
		Sleep, 30
		SendInput, 1
		Sleep, 20
		if ( charPrev() = 1 )
		{
			SendInput, {Backspace}
			keepHolding := false
		}
	}
	return
}

;SWsX() {}


; SELECT CURRENT LiNE
selectLine( includeLWS:=false )
{
	SendInput,{End}
	if includeLWS {
		SendInput, {Home}
	}
	SendInput, {Home}
	SendInput, +{End}
	return
}

; iNPUT DiALOGUE TO RETRiEVE KEY KV & SC FROM KEY NAME
DIA_get_VK_SC()
{
	_ := A_Space
	4_ := _ . _ . _ . _
	8_ := 4_ . 4_
	N12_ := "`n" . 8_ . 4_
	N16_ := N12_ . 4_
	N20_ := N16_ . 4_

	inTitle := "KEY NAME / KEY VK & SC"
	inPrompt := N20_ . ": :  E N T E R  : :"
					. N16_ . "A   K E Y   N A M E"
					. N12_ . "T O   R E T R I E V E   K V   `&   S C  :"
	inW := 272
	inH := 170 + 20
	inX := ( (A_ScreenWidth - inW) / 2 ) - inW
	inY := A_ScreenHeight / 4

	InputBox, in, % inTitle, % inPrompt,
				, % inW, % inH, % inX, % inY, Locale, 30

	if !ErrorLevel {
		get_VK_SC( in )
	} else {}
	return
}

; GET KEY KV & SC FROM KEY NAME
; iNPUT: KEY NAME / OUTPUT: KEY KV & SC
get_VK_SC( keyName )
{
	keyVK := GetKeyVK( keyName )
	keySC := GetKeySC( keyName )

	4_ := "    "
	N4_ := "`n" . 4_
	N8_ := N4_ . 4_

	msg := 4_ . "___ KEY TRINOMEN ___" . N4_ . "-  -  -      -  -  -      -  -  -`n"
	msg .= N8_ . "NAME :`t" . keyName
	msg .= N8_ .  "  VK :`t"
				. ( (keyVK != "")
					? Format("{1:x}", keyVK)
					: "INVALID NAME, VOID VK" )
	msg .= N8_ . "  SC :`t" . ( (keySC != "")
										? Format("{1:x}", keySC)
										: "INVALID NAME, VOID SC" ) . "`n"
	msg .= N4_ . "-  -  -      -  -  -      -  -  -"

	MsgBox, 0, %  "KEY NAME / KEY VK & SC", % msg
	return
}

; OPEN FULL-PATH FiLE LiNK
openFileLink( link )
{
	if ( SubStr(link, 0, 1) = "\" ) {
		Run, C:\Windows\explorer.exe %link%
	} else {
		Run, Open %link%
	}
	return
}

; AHK WiNDOW SEARCH
winSearch()
{
	DetectHiddenWindows, ON
	InputBox, tit, AHK Window Search, `n    Enter Window Title`n:,, 240, 160, 1024, 512, Locale, 20, atom.exe
	winTit := tit
	if ( SubStr( tit, -3, 4 ) = ".exe" ) {
		winTit := "ahk_exe " . tit
	}
	if WinExist( winTit ) {
		WinGet, path_IDs, List, %winTit%
		proc := path_IDs[1]
		WinGet, procPath, ProcessPath, %winTit%
		path_IDs[0] := procPath
		Clipboard := path_IDs[0]
		ahkMsg( tit , path_IDs , 500 , "ISH" , "1F6B46" )
	}
	else {
		ahkMsg( tit , "X" , 500 , "ISH" , "e2319e" )
		path_IDs := false
	}
	return % path_IDs
}

; RETIEVE STRING X BETWEEN STRINGS S1 & S2
stringBetweenLT(_string, _before, _after)
{
	strBet := ""
	if ( !_string || !_before || !_after ) {
		ret = "INVALID_ARGUMENTS"
	}
	else {
		bLen := InStr(_string, _before, true)
		startPos := bLen + StrLen(_before) + 1
		aPos := InStr(_string, _after, true, startPos)
		retLen := aPos - startPos
		ret := SubStr(_string, startPos, retLen)
	}
	return % ret
}

; A P P S
;---------

/* NOT NEEDED, USiNG TabletPenTool SHORTCUTS & REMAPS
; TouchMousePointer TOOLBAR TOGGLE
tproToolbar( mode )
{
	StringUpper, modeENUM, mode
	if ( modeEHUM = "FLOAT" || modeENUM = "SIDE" || modeENUM = "OFF" ) {
		if ( WinExist( "ahk_exe TouchMousePointer.exe" ) ) {
			;current := cursorCoords()
			Send, #t
			Send, {Tab}{Right}
			Send, {AppsKey}{Down}
			;MouseMove, 2364, 43, 0
			;Click, Right
			;Sleep, 50
			if ( modeENUM = "OFF" ) {
				Send, c
			}
			if ( modeENUM = "FLOAT" ) {
				Send, {Down}{Enter}
			}
			if ( modeENUM = "SIDE" ) {
				Send, {Down 2}{Enter}
			}
			;MouseMove, % current.x, % current.y, 0
		} else {
			Run, "C:\Program Files\TouchMousePointer\TouchMousePointer.exe"
		}
	}
	return
}
*/

; OPEN GESTURESiGN / GS CONTROL PANEL
runGest( controlPanel := true )
{
	cp := ".ControlPanel"
	gPath := "C:\cmd_\GestureSign" . ( (controlPanel) ? cp : "" ) . ".lnk"
	isGSRunning := WinExist( "ahk_exe GestureSign.exe"  )
	if ( controlPanel || ( !controlPanel && !isGSRunning ) ) {
		Run, Open %gPath%
		err := "Error"
		WinWait, % err
		WinKill, % err
	}
	return
}

; [ LEONARDO.FULLSCREEN ]
; MOVE CURSOR TO EDGE THAT PULLS TOOLBARS iNTO ViEW
EdgePush( toggleSidebarShift )  ; F_U_N_C_T_i_O_N_
{
	current := cursorCoords()
	show := (toggleSidebarShift)
				? {x: 0, y: 720}
				: {x: (A_ScreenWidth / 2), y: 0}
	MouseMove, % show.x, % show.y, 0

	if (toggleSidebarShift) {
		shift := {x: 144, y: 720}
		Sleep, 25
		Click, % shift.x . " " . shift.y
		MouseMove, % current.x, % current.y, 0
	}
	return
}

; OPEN <index.html> iN EDGE
indexLH()
{
	lhm := "localhost/main/"
	lhmFULL := "http://localhost/main"
	if WinExist(lhm)
		WinActivate % lhm
	else
	{
		ahkMsg("edge", "index.html",, "SHA")
		witi := "ahk_exe msedge.exe"
		Run, % "msedge.exe " . lhmFULL . " --new-window",,, indexPID
		WinWait, ahk_pid %indexPID%
		WinActivate, ahk_pid %indexPID%
	}
	Sleep, 250
	WinMaximize
	Send, {F5}
	return
}

; MAXiMiZE THEN FULLSCREEN ACTiVE WiNDOW
winMaxFull()
{
	WinMaximize, A
	Send, {F11}
	return
}

; START AHK SCRiPT & RETURN PID
ahkScion(ahkPath)
{
	Run, *RunAs %ahkPath%,,, pidVar
	return % pidVar
}

; CLOSE ACTiVE WiNDOW PROGRAM
EndProg(winTit) ; winTit either "A", "*.exe" or a UID
{
	appTit := ""
	if (winTit = "A") {
		WinGet, aID, ID, A
		appTit := "ahk_id " . aID
	} else if ( SubStr( winTit, -3, 4 ) = ".exe" ) {
		appTit := "ahk_exe " . winTit
	} else {
		appTit := "ahk_id " . _winID
	}
	WinClose, % appTit
	Sleep, 250
	if WinExist(appTit) {
		WinKill, % appTit
	}
	return
}

; O S   &   P R O C E S S E S
;-----------------------------

; OnClipboardChange FUNCTiON
clipChange( Type )
{
	ToolTip, CLIP_CHANGE
	Sleep, 100
	ToolTip
	return
}

; TOGGLE SCREEN ORiENTATiON
scrOriensToggle()
{
	ratio := A_ScreenWidth / A_ScreenHeight
	arrow := (ratio > 1) ? "Left" : "Up"
	SendInput, ^!{%arrow%}
	return % ratio
}

; CLOSES ALL OTHER SCRiPTS
closeHidden()
{
	DetectHiddenWindows, On
	WinGet, AHKList, List, ahk_class AutoHotkey
	Loop, % AHKList
	{
		ID := AHKList%A_Index%
		If (ID != A_ScriptHwnd) {
			EndProg(ID)
		}
	}
	DetectHiddenWindows, Off
	Return
}

; TERMiNATE UNWANTED AUTORUN PROCESSES
killMarkedProcs()
{
	SetTimer, Terminate, -10000
	Terminate:
		Run, Open "c:\cmd_\AHKs\taskkill.ahk.BAT",,Hide
	return
}

; BUiLD STRiNG FOR TASKKiLL.AHK.BAT COMMAND
markedProcs()
{
	DetectHiddenWindows, On
	procs := ["DSATray", "DSAService", "DSAUpdateService", "esrv", "esrv_svc", "IntelCpHDCPSvc", "esif_uf", "dpef_helper", "IntelCpHeciSvc", "igfxEM", "OfficeClickToRun", "YourPhone", "YourPhoneServer", "MKCHelper"]
	procNames := []
	for i, pName in procs
		procNames[i] := pName . ".exe"
	DetectHiddenWindows, Off
	procNamesStr := ""
	for i, pExe in procNames
	{
		procNamesStr .= "/IM " . pExe
		if (A_Index != procNames.Length())
			procNamesStr .= " "
	}
	return % procNamesStr
}
