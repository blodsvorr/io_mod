;=============================================
;  A U T O   E X E C U T E   S E C T i O N
;-------------------------------------------
#Persistent
#SingleInstance force
icoFi := "C:\cmd_\AHKs\AHK_icons\Synthwave_Raven_icon_256.ico"
Menu, Tray, Icon, %icoFi%, 1, 1
#Include C:\cmd_\AHKs\lib\WinStart_Functions.ahk
#InstallKeybdHook
#UseHook On
#MaxThreads 60
CoordMode, Mouse, Screen
SetTitleMatchMode, 2
SetTitleMatchMode, Slow
SendLevel, 1
SetWorkingDir, % "C:\cmd_\wDIR"
OnExit( "exitum" )
DetectHiddenWindows, ON
Hotkey, ~Escape, OFF
global subscripts := onStart()
global akTarr := { -1:"Middle" , 0:"OFF" , 1:"Right" }
global appskeyToggle := 0
global magToggle := 0
global desktop_T := 1
global atomPID := ""
global igPID := ""
OnClipboardChange( "clipChange" )
cmd := "C:\Windows\System32\cmd.exe"
hardwareSimRS_T := 1
;ig := Func("invGray")

cmdRun( arg , start:=true )
{
	if ( !start ) {
		Run, C:\Windows\System32\cmd.exe /c %arg%
	} else {
		Run, C:\Windows\System32\cmd.exe /c Start %arg%
	}
	return
}

;--------------------------------------------------------
;    S E C   L O C K   V A R S   &   H O T K E Y S


; HOTKEY MAP
global navArrows := { e: "Up" , s: "Left" , d: "Down" , f: "Right" , i: "Up" , j: "Left" , k: "Down" , l: "Right" }
SecLockKeys := { "w": "wasdNav", "a": "wasdNav" ,"s": "wasdNav" , "d": "wasdNav" }
SecLockKeys["+w"] := "wasdShiftNav"
SecLockKeys["+a"] := "wasdShiftNav"
SecLockKeys["+s"] := "wasdShiftNav"
SecLockKeys["+d"] := "wasdShiftNav"

; VARiABLES
global SecLock_T := 0
arrowNav := Func("arrow")
altArrowNav := Func("altArrow")
arrowShiftNav := Func("arrowShift")
cut_ := Func("xcv").Bind("x")
copy_ := Func("xcv").Bind("c")
paste_ := Func("xcv").Bind("v")

; SEC LOCK HOTKEYX
Hotkey, e, %arrowNav%, Off
Hotkey, s, %arrowNav%, Off
Hotkey, d, %arrowNav%, Off
Hotkey, f, %arrowNav%, Off
Hotkey, i, %altArrowNav%, Off
Hotkey, j, %altArrowNav%, Off
Hotkey, k, %altArrowNav%, Off
Hotkey, l, %altArrowNav%, Off
Hotkey, +e, %arrowShiftNav%, Off
Hotkey, +s, %arrowShiftNav%, Off
Hotkey, +d, %arrowShiftNav%, Off
Hotkey, +f, %arrowShiftNav%, Off
Hotkey, `,, %cut_%, Off
Hotkey, ., %copy_%, Off
Hotkey, /, %paste_%, Off

;================================================
;----     W  i  P       F  O  C  U  S
;  ----------------------------------------

; REFORMAT keymap.json KEYBOARD SHORTCUT ENTRY FOR awiki
!+k::
	reformatKBShC()
	return

reformatKBShC()
{
	SendInput, {End}{Home}
	if ( charNext() = "'" ) {
		selectLine()
		KBShC_line := ghostCopy()
		SendInput {Delete}
		KBShC := SubStr( StrReplace( KBShC_line, "': '", "|" ), 2, -1 )
		SendInput % KBShC
	}
	return
}

;================================
;    W i L D C A R D ( S )
;--------------------------------------------------
/*
	U N U S E D   H O T K E Y   C O M B i N A T i O N S :
			~RShift & AppsKey::
			#y::
	3 - B U T T O N   H O T K E Y   i M P L E M E N T A T I O N
			#If ( GetKeyState ( "[KEY]" , "P" ) )
			[2-KEY HOTKEY]::
	H O T K E Y   R E M A P   H A C K   [ RCTRL :: APPSKEY ]
			~RControl up::
			If (A_priorkey="RControl")
			Send {Appskey}
			Return
	W i L D C A R D   H O T K E Y   F U N C T i O N S :
	; RETRiEVE VK & SC FROM KEY NAME - DiALOGUE
		DIA_get_VK_SC()
		return
*/ ;--------------------------------------------------

~AppsKey & \::
	Loop, 8
	{
		chars := ["a", "b", "c", "d", "e", "f", "g", "h"]
		i := chars[A_Index]
		str := "RAM8 ( in = in , load = load" . i . " , address = address[3..5] "
			str .= ", out = o" . i . " ) `;"
			str .= "`n`t"
		SendInput, % str
	}
	return

#w::
	return

; L i G H T K E Y
#l::
	Lightkey()
	return

;-------------------------
;     A P P S K E Y

$AppsKey::
	KeyWait, AppsKey, t0.150
	if !ErrorLevel {
		KeyWait, AppsKey, D, t0.200
		if !ErrorLevel
		{
			KeyWait, AppsKey, t0.225
			if !ErrorLevel {
				; DOUBLE TAP
				SetCapsLockState, % !GetKeyState("CapsLock", "T")
			} else {
				; DOUBLE TAP HOLD
				Run, *RunAs "C:\cmd_\cmd_.lnk"
			}
		} else {
			; SiNGLE KEYSTROKE
			if ( WinActive( "Edge") ) {
				SendInput, {MButton}
			}
		}
	}
	return
/*
CapsLock::
	KeyWait, CapsLock, t0.125
	if !ErrorLevel {
		SecLockToggle()
	} else {
		KeyWait, CapsLock, t0.125
		if ErrorLevel {
			SetCapsLockState, % !GetKeyState("CapsLock", "T")
		}
	}
	return
*/
;=========================================
;   S E C   L O C K   (Secondary Lock)
;--------------------------------------

; TOGGLE  ,  CAN ALSO BE TRIGGERED BY AppsKey DOUBLE TAP
~AppsKey & Space::
	SecLockToggle()
	return

; SEC LOCK TOGGLE FUNCTiON
SecLockToggle()
{
	global SecLock_T
	SecLock_T := Abs( SecLock_T - 1 )
	if (SecLock_T) {
		SecLock("On")
		toggleColor :=  "1F6B46"
	} else {
		SecLock("Off")
		toggleColor :=  "c41c68"
	}
	ahkMsg( "SecLock", SecLock_T, 25, "SHA", toggleColor )
	return
}

; SEC LOCK STATE TOGGLE FUNCTiON
SecLock( state )
{
	Hotkey, e, %arrowNav%, %state%
	Hotkey, s, %arrowNav%, %state%
	Hotkey, d, %arrowNav%, %state%
	Hotkey, f, %arrowNav%, %state%
	Hotkey, i, %altArrowNav%, %state%
	Hotkey, j, %altArrowNav%, %state%
	Hotkey, k, %altArrowNav%, %state%
	Hotkey, l, %altArrowNav%, %state%
	Hotkey, +e, %arrowShiftNav%, %state%
	Hotkey, +s, %arrowShiftNav%, %state%
	Hotkey, +d, %arrowShiftNav%, %state%
	Hotkey, +f, %arrowShiftNav%, %state%
	Hotkey, `,, %cut_%, %state%
	Hotkey, ., %copy_%, %state%
	Hotkey, /, %paste_%, %state%
	return
}

; SEC LOCK WASD ARROWS FUNCTiON
arrow()
{
	global navArrows
	arrow := navArrows[A_ThisHotkey]
	inKey := "{" . arrow . "}"
	SendInput, %inKey%
	return
}

altArrow()
{
	global navArrows
	arrow := navArrows[A_ThisHotkey]
	inKey := "{" . arrow . "}"
	if ( arrow = "Up" ) {
		upX8()
	} else if ( arrow = "Down" ) {
		downX8()
	} else {
		SendInput, !%inKey%
	}
	return
}

arrowShift()
{
	global navdArrows
	key := A_ThisHotkey
	key := SubStr(key, 2)
	inKey := "{" . navArrows[key] . "}"
	KeyWait, %key%, t0.225
	if ErrorLevel {
		SendInput, +^%inKey%
	} else {
		SendInput, +%inKey%
	}
	return
}

;====================================
;   B A S i C   F U N C T i O N S
;----------------------------------
/*
; ENTER HOLD TO MATCH PREV LiNE iNDENT
Enter::
	SendLevel, 0
	SendInput, {Enter}
	KeyWait, Enter, t0.150
	if ErrorLevel {
		SendInput, {Up}
		SendInput, +{Home}
		StrReplace( ghostCopy(), "`t",, tabCount )
		SendInput, {Down}
		SendInput, {Tab %tabCount%}
	}
	SendInput, {Enter up}
	return
*/
; APPSKEY MiDDLE / RiGHT MOUSE CLiCK TOGGLE
;~AppsKey % c::

; GET MOUSE CURSOR COORDiNATES
#x::
	coords := cursorCoords()
	coordsStr := " " . coords.x . " , " . coords.y . " "
	ahkMsg( "Cursor X,Y" , coordsStr , 3200 , "SHA" , "551AE4" )
	Clipboard := coords.x . " " . coords.y
	return

; GET PIXEL COLOR HEX
#c::
	getPixelHex()
	return

;  COPY  ||  CUT  ||  COPY PATH [ATOM]  ||  2nd COPY
~RAlt & AppsKey::
	KeyWait, AppsKey, t0.275
	if !ErrorLevel {
	; Copy |  RAlt & AppsKey (release)
		xcv( "c" )
		KeyWait, AppsKey
		KeyWait, AppsKey, D, t0.175
		if !ErrorLevel {
			RAltState := GetKeyState( "RAlt", "P" )
			if ( RAltState ) {
				if ( WinActive( "ahk_exe atom.exe" ) ) {
	; Copy Path |  RAlt & AppsKey, AppsKey Tap
					xcv( "p" )
				}
			}
		}
	} else {
		KeyWait, RAlt, t0.275
		KeyWait, RAlt, D, t0.125
		if !ErrorLevel {
	; 2nd Copy |  RAlt & AppsKey, RAlt Tap
			SecondCopyJoin()
		} else {
	; Cut |  RAlt & AppsKey, RAlt release AppsKey Hold
			xcv( "x" )
		}
	}
	return

; PASTE
~AppsKey & RAlt::
	KeyWait, RAlt, t0.225
	if !ErrorLevel {
		xcv( "v" )
	} else {}
	return

; SECOND COPY CONCAT WiTH JOIN STRiNG DiALOGUE
SecondCopyJoin()  ; _F_U_N_C_T_i_O_N
{
	first := Clipboard
	Clipboard := ""
	xcv()
	ClipWait
	second := Clipboard
	Sleep, 150
	inBoxTit := "Interconcatenand"
	inBoxPrompt := "`n        I.  " . first . "`n`n       II.  " . second
	inBoxPrompt .= "`n`n  Enter a char or string to concatenate between I and II :`n`n"
	InputBox, join, %inBoxTit%, %inBoxPrompt%,, 400, 240, 1080, 360, Locale, 30
	Clipboard := first
	if !ErrorLevel	{
	; I/O : InputBox ErrorLevel : =1 Cancel, =2 Timeout
		Clipboard .= join . second
	}
	return
}

; CLiPBOARD [WiNDOWS SHORTCUT]
;	#v

; BACKSPACE
~AppsKey & ,::
!z::
	SendInput, {BackSpace}
	return

; DELETE
~AppsKey & .::
!x::
	SendInput, {Delete}
	return

; SELECT ALL
~AppsKey & RShift::
	KeyWait, RShift
	KeyWait, RShift, D, t0.2
	if ( GetKeyState( "RShift" , "P" ) ) {
		SendInput, ^a
	}
	return

; UNDO
!/::
	SendInput, ^z
	return

; REDO
!.::
	SendInput, +^z
	return

; RENAME (F2)
#If !WinActive("ahk_exe atom.exe")
!n::
	SendInput, {F2}
	return
#If

;===========================================================]
;  T E X T   &   i N T E R F A C E   N A V i G A T i O N
;---------------------------------------------------------

; CURSOR UP X8
~AppsKey & Up::
upX8()
{
		Loop, 4  {
			SendInput, {Up 2}
			Sleep, 10
		}
		KeyWait, Up, t0.400
		if ErrorLevel {
			SendInput, ^{Home}
		}
		return
}
return

; CURSOR DOWN X8
~AppsKey & Down::
downX8()
{
		Loop, 4
		{
			SendInput, {Down 2}
			Sleep, 10
		}
		KeyWait, Down, t0.400
		if ErrorLevel {
			SendInput, ^{End}
		}
		return
}

; HOME  /  NAV LEFT (CTRL+L)
~AppsKey & Left::
	KeyWait, Left, t0.375
	if !ErrorLevel {
		SendInput, !{Left}
	} else {
		SendInput, {Home}
	}
	return

; END  /  NAV RiGHT (CTRL+R)
~AppsKey & Right::
	KeyWait, Right, t0.375
	if !ErrorLevel {
		SendInput, !{Right}
	} else {
		SendInput, {End}
	}
	return

; SHiFT / SHiFT+ALT LEFT SELECT
+Left::
	SendInput, +{Left}
	KeyWait, Left, t0.225
	if ErrorLevel {
		SendInput, ^+{Left}
	} else {
		KeyWait, Left, d, t0.125
		KeyWait, Left, t0.175
		if ErrorLevel {
			SendInput, +{Home}
		}
		KeyWait, Left, t0.375
		if ErrorLevel {
			SendInput, +{Home}
		}
		KeyWait, Left, t3
	}
	return

; SHiFT / SHiFT+ALT RiGHT SELECT
+Right::
	SendInput, +{Right}
	KeyWait, Right, t0.225
	if ErrorLevel {
		SendInput, ^+{Right}
	} else {
		KeyWait, Right, d, t0.125
		KeyWait, Right, t0.175
		if ErrorLevel {
			SendInput, +{End}
		}
		KeyWait, Right, t3
	}
	return

; SELECT LiNE
+AppsKey::
	KeyWait, AppsKey, t0.325
		if ErrorLevel {
		; iNCLUDE LWS iF AppsKey HOLD
		selectLine( true )
	} else {
		; SANS LWS
		selectLine()
	}
	KeyWait, AppsKey
	KeyWait, AppsKey, D, t0.175
	if !ErrorLevel {
		KeyWait, AppsKey, t0.500
		if !ErrorLevel {
			; COPY LiNE iF AppsKey DOUBLE TAP
			xcv( "c" )
		} else {
			; CUT LiNE iF AppsKey DOUBLE TAP HOLD
			xcv( "x" )
			SendInput, +{Home}{Delete 2}
		}
		KeyWait, AppsKey, t6
	}
	return

; MOVE LINE UP
!Up::
	SendInput, ^{Up}
	return

; MOVE LINE DOWN
!Down::
	SendInput, ^{Down}
	return

; ALTERNATE TAB
!'::
	Send, {Tab}
	return

; ALTERNATE SHIFT+TAB
!`;::
	Send, +{Tab}
	return

; NEXT TAB  >
!]::
	Send, ^{Tab}
	return

;  <  PREV TAB
![::
	Send, ^+{Tab}
	return

;===========================
;   S Y S T E M   I / O
;-------------------------

; RESTART WiNDOWS, FORCE
~AppsKey & `::
	Shutdown, 6
	ahkMsg("word of power", "restart",, "IND")
	return

; SHUTDOWN WiNDOWS, FORCE
~AppsKey & Escape::
	Shutdown, 12
	ahkMsg("word of power", "shutdown",, "IND")
	return

; OPEN TASK MANAGER
!Escape::
	SendInput, ^+{Escape}
	WinWait, Task Manager
	winMaxFull()
	return

; OPEN ENViRONMENT VARiABLES DiALOGUE WiNDOW
~AppsKey & e::
	Run, *RunAs C:\Windows\System32\SystemPropertiesAdvanced.exe
	WinWait, System Properties
	ControlClick, Button7, System Properties
	return

; SCREEN ORiENTATiON TOGGLE
#o::
	scrOriensToggle()
	return

; DISPLAY COLOR FILTER : INVERT GRAYSCALE _H_O_T_K_E_Y
#i::
	SendInput, ^#c
	return

/*
invGray()
{
	if ( WinActive( "Atom" ) ) {
		colorRef := getPixelHex(8, 8)
		if ( colorRef = "0C0C0F" ) {
			SendInput, ^#c
			OnWin( "Active", "Atom", ig )
			OnWin( "NotActive", "Atom", ig )
		} else {
			SendInput, ^#c
		}
	}
	return
}
*/

; ALT_ ZOOM INm
~AppsKey & -::
	SendInput, ^-
	return

; ALT_ ZOOM OUT
~AppsKey & =::
	SendInput, ^=
	return

; ON-SCREEN KEYBOARD TOGGLE
~AppsKey & k::
^F11::
	SendInput, ^#o
	return

; TOGGLE ViRTUAL NUMBER PAD
~AppsKey & n::
	if WinExist( "ahk_exe Numpad_1.7.1.exe" ) {
		SendInput, {F10}
	} else {
		Run, *RunAs "C:\cmd_\Numpad_1.7.1.lnk"
	}
	return

;==========================================
;   A  P  P  L  i  C  A  T  i  O  N  S
;=======================================
;   A P P S   N A V i G A T i O N
;-----------------------------------

; WiNDOW, LAST
~AppsKey & Enter::
	Send, !{Tab}
	return

; FULL SCREEN
#f::
	winMaxFull()
	return

; MiNiMiZE ALL WiNDOWS
#m::
	SendInput, #d
	return

; EXiT PROGRAM
~AppsKey & Delete::
!q::
	; EXiT ATOM
	if WinActive("ahk_exe atom.exe") {
		SendInput, !+a
	; EXiT ALL OTHER APPS
	} else {
		EndProg("A")
	}
	return

; TOGGLE BETWEEN DESKTOPS
#d::
	desktop_T := desktop_T * (-1) + 3
	if ( desktop_T = 1 ) {
		SendInput, ^#{Left}
	}
	if ( desktop_T = 2 ) {
		SendInput, ^#{Right}
	}
	return


;-------------------------------------
;   W i N D O W S   E X P L O R E R
;-------------------------------

; OPEN WiNDOWS EXPLORER
#e::
	Run, *RunAs "C:\Windows\explorer.exe"
	return


; TOGGLE NAViGATiON PANE
#n::
	if WinActive( "ahk_exe explorer.exe" ) {
		SendInput, {LAlt down}
		Sleep, 25
		SendInput, {LAlt up}
		Sleep, 50
		SendInput, {1 down}{1 up}
	}
	return

; OPEN APPS FOLDER
~AppsKey & a::
	Run, %cmd% /c explorer appsfolder,, Hide
	return

; TOGGLE BLUETOOTH ON / OFF
~AppsKey & b::
	Run, %cmd% /c Start ms-settings:bluetooth,, Hide
	WinWait, Settings
	Sleep, 500
	SendInput {Tab}
	Sleep, 50
	SendInput {Space}
	return

;------------------------------------
;   C O M S P E C   C O N S O L E
;-OPEN-----------------------------
!Enter::
	SendInput, {F2}
	Sleep, 50
	SendInput, {End}
	Sleep, 50
	str := "_XFVS"
	SendInput, % str
	Sleep, 50
	SendInput, {Enter}
	;Run, *RunAs "C:\cmd_\cmd_.lnk"
	return

; RUN SCRCPY ViA ADB TCP/IP		DELTA.ELEM
#y::
	batFilePath := "C:\cmd_\AHKs\lib\SCRCPYvIP.BAT"
	inFilePath := "C:\cmd_\AHKs\lib\wanderer.IP.port"
	inTitle := "SCRCPY | Wand IP Port"

	__ := "                    "
	N__ := "`n                "
	inPrompt := "`n" . __ . ": :  E N T E R  : :" . N__ . "W A N D E R E R   I P" . N__ . "P O R T   N U M B E R  :"

	inW := 272
	inH := 170 + 20
	inX := ( (A_ScreenWidth - inW) / 2 ) - inW
	inY := A_ScreenHeight / 4

	FileRead, lastPort, %inFilePath%
	InputBox, in, % inTitle, % inPrompt,, % inW, % inH, % inX, % inY, Locale, 30, % lastPort

	if !ErrorLevel {
		FileDelete, %inFilePath%
		FileAppend, %in%, %inFilePath%
		Run, Open %batFilePath%,, Hide
	} else {}

	return

;==================
;    A T O M
;--------------

; OPEN ATOM
#a::
	Run, "C:\cmd_\atom.lnk",, Hide
	WinWait, ahk_exe atom.exe
	ahkMsg("SW", "ATOM", 4800, "SHI",, true)
	WinActivate, ahk_exe atom.exe
	return

; RESTART ATOM
!a::
	if WinActive("ahk_exe atom.exe") {
		Send, ^r
		WinWait, ahk_exe atom.exe
		ahkMsg("SW", "ATOM", 3600, "SHI",, true)
		WinActivate, ahk_exe atom.exe
	} else {
		SendInput, !a
	}
	return

; DEV TOOLS
^d::
	if WinActive("ahk_exe atom.exe") {
		SendInput, ^+i
	}
	else {
		SendInput, ^d
	}
	return

; RELOAD <WinStartMain.ahk>
!w::
	ahkMsg("RELOAD", "WinStartMain",, "SHA")
	Reload
	return

; HIDE GUTTER
!g::
	if WinActive("ahk_exe atom.exe") {
		SendInput, {RCtrl down}gg{RCtrl up}
	} else {
		SendInput, !g
	}
	return

; BAK-SAVE & VARiANTS
^s::
	if WinActive("ahk_exe atom.exe") {
		saveBAK()
		SendInput, ^s
		; SAVE CORE WIN-START & RELOAD WinStartMain.ahk
		if ( WinActive("WinStartMain") || WinActive("WinStartMain_Functions") ||  WinActive("KeyHoldHotkeys") || WinActive("CodingHotsrings") ) {
			ahkMsg("BAK-SAVE RELOAD", "WinStartMain",, "SHI")
			Reload
		; ATOM COLOR SCHEME MASTER SAVE & SYNC
		} else if WinActive("SYNTHWAVE_schemaChromatika") {
			uiThemeSave()
			ahkMsg("SCION BAK-SAVE", "SYW_SXX",, "SHI")
		; DEFAULT ahkMsg FOR SiMPLE BAK-SAVE
		} else {
			ahkMsg("BAK-SAVE", "ATOMOS", 120, "SHI")
		}
	} else {
		SendInput, ^s
	}
	return

; SAVE ACTiVE FiLE & RELOAD <WinStartMain.ahk>
!s::
	saveBAK()
	SendInput, ^s
	; SAVE DOM FiLES & RELOAD index.html
	if ( WinActive("index.html") || WinActive("style.css") || WinActive("script.js") || WinActive("upload.php") ) {
		indexLH()
	} else {
		ahkMsg("BAK-SAVE RELOAD", "WinStartMain", 120, "SHI")
		Run, *RunAs "C:\cmd_\AHKs\WinStartMain.ahk"
	}
	return

; OPEN <http://localhost/main> iN A NEW EDGE BROWSER WINDOW
!i::
	indexLH()
	return

;-------------------------------------
;   N A N D   2   T E T R i S
;---------------------------------

; OPEN HARDWARE SiMULATOR
~AppsKey & h::
	Run, Open "C:\cmd_\NAND2TETRIS\nand2tetris\tools\HardwareSimulator.bat"
	return

; HARDWARE SIM SPECIFIC HOTKEYS
#If WinActive( "Hardware Simulator" )

; LOAD CHiP : DOUBLE TAP
; LOAD SCRIPT : DOUBLE TAP HOLD
AppsKey::
	KeyWait, AppsKey
	KeyWait, AppsKey, D, t0.175
	if !ErrorLevel {
		KeyWait, AppsKey, t0.325
		SendInput, !f
		Sleep, 50
		if ErrorLevel {
			SendInput, p
		} else {
			SendInput, l
		}
		Sleep, 50
		SendInput, +{Tab}{Home}
	}
	return

; RUN : TAP
; RESET : DOUBLE TAP
Space::
	KeyWait, Space
	KeyWait, Space, D, t0.225
	if ErrorLevel {
			SendInput, {F5}
	} else {
		SendInput, !r
		Sleep, 25
		SendInput, r
	}
	return

; STOP
Backspace::
	SendInput, +{F5}
	return

#If

;----------------------------------------
;   A P A C H E   W E B   S E R V E R
;--------------------------------------

; START
!1::
	ahkMsg("apache", "starting...", 1000)
	Run, *RunAs "C:\cmd_\APACHE\apache_start.bat",, Hide
	iAPath := "C:\cmd_\APACHE\isApache.bool"
	FileDelete, %iAPath%
	FileAppend, 1, %iAPath%
	EnvSet, isApache, 1
	ahkMsg("start", "apache")
	return

; RESTART
!2::
	ahkMsg("apache", "restarting...", 1000)
	Run, *RunAs "C:\cmd_\APACHE\apache_restart.bat",, Hide
	iAPath := "C:\cmd_\APACHE\isApache.bool"
	FileDelete, %iAPath%
	FileAppend, 1, %iAPath%
	EnvSet, isApache, 1
	ahkMsg("restart", "apache", 1000)
	return

; STOP
!3::
	apacheSTOP()  ; _F_U_N_C_T_i_O_N
	{
		ahkMsg("apache", "stopping...", 1000)
		Run, "C:\cmd_\APACHE\apache_stop.bat",, Hide
		iAPath := "C:\cmd_\APACHE\isApache.bool"
		FileDelete, %iAPath%
		FileAppend, 0, %iAPath%
		EnvSet, isApache, 0
		ahkMsg("stop", "apache")
		return
	}
	return

; STATUS
!4::
	apacheSTATUS(invis := false)  ; _F_U_N_C_T_i_O_N
	{
		DetectHiddenWindows, On
		iAPath := "C:\cmd_\APACHE\isApache.bool"
		FileRead, statCheck, %iAPath%
		statCheck := SubStr(currStat0, 1, 1)
		FileDelete, %iAPath%
		if (WinExist("ahk_exe httpd.exe") || statCheck) {
			FileAppend, 1, %iAPath%
		} else {
			FileAppend, 0, %iAPath%
		}
		FileRead, currStat, %iAPath%
		currStat := SubStr(currStat, 1, 1)
		if !invis {
			ahkMsg("Apache ? ", currStat)
		}
		return % currStat
	}
	return

;===========================
;   O T H E R   A P P S
;------------------------

; OPEN PAINT 3D
~AppsKey & p::
	paint := "mspaint"
	cmdRun( paint )
	Sleep, 500
	xcv( "v" )
	Sleep, 250
	SendInput, ^s
	return

; FREE CODE CAMP . ORG  PANEL ADJUST
^Space::
	if WinActive("JavaScript") {
		Click, 2059 1020 D
		Click, 1406 1020 0
		Click, U
	} else {
		SendInput, ^{Space}
	}
	return

; OPEN GESTURE SiGN
~AppsKey & g::
!#g::
	runGest()
	return

; OPEN SNiP & SKETCH
#s::
	SendInput, #+s
	return

; OPEN EDGE BROWSER
~AppsKey & i::
	edgeExe := "ahk_exe msedge.exe"
	edgePath := "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Edge.lnk"
	Run, % edgePath
	WinWait % edgeExe
	WinActivate % edgeExe
	Sleep, 500
	WinMaximize % edgeExe
 	return

; OPEN SPOTiFY
~AppsKey & s::
	spotifyPath := "C:\cmd_\Spotify.lnk"
	Run, %spotifyPath%
	return

; OPEN LEONARDO
~AppsKey & l::
	leoPath := "C:\cmd_\Leonardo.lnk"
	Run, %leoPath%
	return

; [LEONARDO] TOGGLE SiDEBAR SHiFT
!+=::
	EdgePush( true )
	return

;[LEONARDO] REVEAL TITLEBAR FROM FULL SCREEN
!+t::
	EdgePush( false )
	return

#If WinActive("ahk_exe leonardo.exe")
^!+s::
sidebarShift()  ; _F_U_N_C_T_i_O_N
{
	current := cursorCoords()
	show := {x: 0, y: 720}
	shift := {x: 144, y: 720}
	MouseMove, % show.x, % show.y, 0
	Sleep, 25
	Click, % shift.x . " " . shift.y
	MouseMove, % current.x, % current.y, 0
	return
}
#If

; OPEN CiRCUiTVERSE
~AppsKey & v::
	cvPath := "C:\cmd_\CircuitVerse.lnk"
	Run, %cvPath%
	WinWait, CircuitVerse
	winMaxFull()
	return

; SNAGiT SOFTWARE KEY
:*:snagitkey::
	SendInput, % "YUC2C-DBCM4-YDCTV-J6ZP4-LM472"
	return

;================================
;    A U T O  H O T  K E Y
;------------------------------

; DOCUMENTATiON
^/::
	ahkDocuPath := "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\AutoHotkey\AutoHotkey.lnk"
	Run, % ahkDocuPath
	return

; KiLL WinStartMaiwn.ahk
!+w::
	ahkMsg("terminate", "W S M", 1000, "SHI")
	ExitApp
	return

; KEY HiSTORY
!h::
	if !WinActive("ahk_exe scrcpy.exe")
		KeyHistory
	return

; AHK WiNOW SEARCH
~AppsKey & w::
	winSearch()
	return

; RUN WiNDOW SPY
!y::
	global varWS := "Window Spy"
	winSpyPath := "C:\Program Files\AutoHotkey\WindowSpy.ahk"
	wsID := WinExist(varWS)
	if wsID {
		WinGet, mmState, MinMax, ahk_id %wsID%
		WinGet, currAWin, ID, A
		if (mmState < 0) {
			WinRestore, ahk_id %wsID%
			WinActivate, ahk_id %currAWin%
		} else {
			if (currAWin = wsID) {
				SendInput, !{Tab}
			} else {
				WinActivate, ahk_id %wsID%
			}
		}
	} else {
		Run, % winSpyPath
	}
	Hotkey, Escape, ON
	return

; WiNDOW SPY CLOSE
~Escape::
	if WinExist(varWS) {
		WinGet, mmState, MinMax, %varWS%
		WinGet, wsID, ID, %varWS%
		if (mmState >= 0) {
			EndProg(wsID)
		} else {
			SendInput, {Escape}
		}
	}
	Hotkey, Escape, OFF
	return

;  ~ak  =>  ~AppsKey
#If WinActive(".ahk")
:*:~ak::
	SendInput % "~AppsKey & "
	return
#If


;==========================================================
/*           . . .    W    i    P    . . .
;----------------------------------------------------------

; F U N C T i O N
; TO REPLACE CSS COLOR MiXES
; WiTH HEX FROM PiGMENT GUTTER SWATCHES
getPigmentsHex()
{
	getPixelHex()
	Click
	SendInput, {Home}{Right}
	while ( charPrev() != ":" )
	{
		SendInput, ^{Right}
	}
	SendInput, {Right}
	xcv( "v" )
	while ( charNext() != ";" )
	{
		SendInput, {Delete}
	}
	MouseMove, 0, 50,, R
	return
}
*/

;---------------------------------------------------------
;         X    - D E A C T i V A T E D -    X
;---------------------------------------------------------

/*
	gate := "Mux"
	ina := gate . "( a="
	inb := ", b="
	insel := ", sel="
	ino := ", out="
	inz := " );"
	out := "out"
	sel := "sel"
	open := "["
	close := "]"
	sels := [ "000", "001", "010", "011", "100", "101", "110", "111" ]
	alphs := [ "a", "b", "c", "d", "e", "f", "g", "h" ]
	loopi := 16

	Loop, %loopi%
	{
		i := A_Index - 1
		ind := open . i . close
		a_ := alphs[1] . ind
		b_ := alphs[2] . ind
		sel_ := sel
		out_ := out . ind
		str := ina . a_ . inb . b_ . insel . sel_
			str .= ino . out_ . inz
		SendInput, % str . "`n`t"
		if ( A_Index = loopi ) {
			SendInput,{BS}
		}
	}
	return
*/
/*
NOT WORKiNG :: REMAPS FOR TabletPenTool
; RUN TouchMousePointer : FLOAT
~AppsKey & [::
	SendInput, {LWin down}{LShift down}
	SendInput, {f down}{f up}
	SendInput, {LShift up}{LWin up}
	return

; RUN TouchMousePointer : SIDE
~AppsKey & ]::
	SendInput, +#q
	return

; RUN TouchMousePointer : OFF
~AppsKey & '::+#d

; START SCRCPY		DELTA.ELEM
~AppsKey & y::
	Run, "C:\cmd_\ScrCpy.lnk"
	return
*/
/*
~AppsKey & c::
	Run, %cmd% /c Start ms-settings:clipboard,, Hide
		return
ms-settings-connectabledevices:devicediscovery /*ms-settings:bluetooth
*/


;------------------------------------------------------------
;---------- --   -                          -   -- ---------
;                 E  N  D    S  C  i  P  T
;__ _   _ __  -                              -  ___ _   _ __
;-----------------------------------------------------------
;============================================================
