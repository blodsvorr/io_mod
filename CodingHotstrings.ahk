; A U T O   E X E C U T E   S E C T i O N
#Persistent
#SingleInstance force
icoFi := "C:\cmd_\AHKs\AHK_icons\Synthwave_Raven_icon_256.ico"
Menu, Tray, Icon, %icoFi%, 1, 1
#NoTrayIcon
#InstallKeybdHook
#InstallMouseHook
#UseHook
;SetTitleMatchMode, 2
;SetTitleMatchMode, Slow
SetKeyDelay, 8
#MaxThreadsPerHotkey 8
#Hotstring EndChars `t'[
#Hotstring * ? B0 Z
global lvl := 0
SendLevel, 0

; H O T S T R i N G S

;	while ( GetKeyState("%", "P" ) )
;	{} ; empty loop yields a pause until condition is false

:P%lvl%:{::
	KeyWait, [
	KeyWait, [, D T0.5
	if !ErrorLevel
	{
		SendInput, {BS}
		if ( charPrev() = "{" )
		{
			SendInput, {}}
			brackets("{}")
		}
	}
	return

:P%lvl%:;::
	key := ";"
	KeyWait, %key%
	KeyWait, %key% , D, T0.5
	if !ErrorLevel
	{
		SendInput, {Left}{BS}{{}
		if ( charPrev() = "{" )
		{
			SendInput, {}}
			brackets("{};")
		}
	}
	return

:P%lvl%:(::
	KeyWait, 9
	KeyWait, 9, D T0.5
	if !ErrorLevel
	{
		SendInput, {BS}
		if ( charPrev() = "(" )
		{
			SendInput, )
			brackets("()")
		}
	}
	return

:*0P%lvl%:[::
	SendInput, {BS}
	if ( charPrev() = "[" )
	{
		SendInput, ]
		brackets("[]")
	}
	return

:P%lvl%:<::
	KeyWait, `,
	KeyWait, `,, D T0.5
	if !ErrorLevel
	{
		SendInput, {BS}
		if ( charPrev() = "<" )
		{
			SendInput, >
			brackets("<>")
		}
	}
	return

:ZP%lvl%:`%::
	KeyWait, 5,
	KeyWait, 5, D T0.5
	if !ErrorLevel
	{
		SendInput, {BS}
		if ( charPrev() = "%" )
		{
			SendInput, `%
			brackets("%%")
		}
	}
	return

:P%lvl%:`"::
	KeyWait, % """"
	KeyWait, % "'", D T0.5
	if !ErrorLevel
	{
		SendInput, {BS}
		if ( charPrev() = """" )
		{
			SendInput, % """"
			brackets("""""")
		}
	}
	return

:*0P%lvl%:'::
	SendInput, {BS}
	if ( charPrev() = "'" )
	{
		SendInput, % "'"
		brackets("''")
	}
	return

:B:`;--::
	commentOpen := "/*---- "
	SendInput, %commentOpen%
	return

:B:--`;::
	commentClose := " ----*/"
	SendInput, %commentClose%
	return

; F U N C T i O N S

brackets(pair)
{
	global lvl
	lvl ++
	SendInput, {Left}
	CHhook(pair, "")
	lvl --
	return
}

CHhook(hk, inString)
{
	hkEnd := SubStr(hk, 2)
	hkEndL := StrLen(hkEnd)
	hkEnd := SubStr(hkEnd, 1, 1)
	hook := ih(2,, "{Backspace}+")
	eK := hook[2]
	in := inString . hook[3]
	if (eK = "Backspace" )
	{
		if ( charPrev() = SubStr(hk, 1, 1) && charNext() = SubStr(hk, 2, 1) )
		{
			SendInput, {Right}
			SendInput, {BS %hkEndL%}
		}
		else
		{
			SendInput, {BS}
			CHhook(hk, in)
		}
	}
	else if (eK = "Escape")
	{
		;delAll := StrLen(in) + StrLen(hk)
		SendInput, {Right}{Left 2}{Right}
	}
	else if (eK = "Enter")
	{
		if (hkEnd = charNext())
		{
			prevChar := charPrev()
			SendInput, {Right %hkEndL%}
			if (hkEnd = "}")
			{
				hookCB := ih(, 0.25, "{Enter}")
				eR_CB := hookCB[1]
				if (eR_CB = "EndKey" && prevChar = "{")
				{
					SendInput, {Left %hkEndL%}
					codeBlock()
					hookEsc := ih(, 2, "{Escape}")
					eR_Esc := hookEsc[1]
					if (eR_Esc = "EndKey")
					{
						SendInput, {Down}
						SendInput, {Shift down}
						SendInput, {Up 2}
						SendInput, {Left}
						SendInput, {Shift up}
						SendInput, {BS}
					}
				}
			}
		}
		else
			SendInput, {Enter}
	}
	else
	{
		Loop
		{
			SendInput, !{Right}
;			SendInput, {Alt down}
;			SendInput, {Right}
;			SendInput, {Alt up}
			nextChar := charNext()
		} Until (nextChar = hkEnd || A_Index = 4)
		SendInput, {Right}
	}
	return
}

codeBlock()
{
	tabs := getTabCount()
	lws := "{Tab " . tabs . "}"
	SendInput, {Space}{Left}{Enter}
	SendInput, {Delete}{Enter}
	SendInput, % lws
	SendInput, {Up}
	SendInput, % lws
	SendInput, % A_Tab
	return

}

getTabCount()
{
	SendInput, {Home}
	SendInput, {Shift down}
	SendInput, {Home}
	SendInput, {Shift up}
	str := ghostCopy()
	SendInput, {End}
	if ( charPrev() = ";" ) {
		SendInput, {Left}
	}
	SendInput, {Left}
	tabCount := ""
	if !str
		tabCount := 0
	else
		subStr := StrReplace(str, A_Tab,, tabCount)
	return % tabCount
}
