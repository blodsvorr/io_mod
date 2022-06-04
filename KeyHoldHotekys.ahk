;  A U T O   E X E C U T E   S E C T i O N
#Persistent
#SingleInstance force
icoFi := "C:\cmd_\AHKs\AHK_icons\Synthwave_Raven_icon_256.ico"
Menu, Tray, Icon, %icoFi%, 1, 1
#NoTrayIcon
#InstallKeybdHook
#UseHook
SetKeyDelay, 5
;#MaxThreadsPerHotkey 1
;#MaxThreadsBuffer Off

;  K E Y   F U N C T i O N   A R R A Y S

primaKeys := ["``", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "[", "]", "\", "`;", "'", "`,", ".", "/"]
secoKeys := ["~", "!", "@", "#", "$", "`%", "^", "&", "*", "(", ")", "_", "+", "{", "}", "|", ":", """", "<", ">", "?" ]

primaKeysStr := """"
for i2, key2 in primaKeys
	primaKeysStr .= "{" . key2 . "}"
primaKeysStr .= """"
;MsgBox % primaKeysStr

global khhKeys := {}
for i1, key1 in primaKeys
	khhKeys[key1] := secoKeys[i1]
for i0, key0 in khhKeys
	khhKeysStr .= "        " . i0 . "        " . key0 . "`n"
;MsgBox % khhKeysStr

global dubHook := InputHook("V")
dubHook.KeyOpt(primaKeysStr, "V N")
dubHook.OnKeyDown := Func("khhPress")
dubHook.Start()

Return

; H O T K E Y S



;  F U N C T i O N S

khhPress(InputHook, VK, SC)
{
	kName := GetKeyName(Format("vk{:x}sc{:x}", VK, SC))
	;	MsgBox % kName
 	fn1 := Func("interval_1st").Bind(kName)
	SetTimer, %fn1%, -175
	KeyWait, %kName%
	SetTimer, %fn1%, Delete
	return
}

interval_1st(kName)
{
	currKey := kName
	isKeyDown := GetKeyState(currKey, "P")
	fn1 := Func("interval_1st").Bind(kName)
	SetTimer, %fn1%, Delete
	currValue := khhKeys[currKey]
	;	MsgBox % currKey . "    " . isKeyDown . "    " . currValue
	if isKeyDown
	{
		Send, {BS}
		SendLevel, 2
		Send, {Text}%currValue%
	}
	return
}

;  K E Y H O L D   H O T K E Y S

/*
`::
	SendLevel, 0
	Send, {Text}``
	return
1::
	SendLevel, 0
	Send, {Text}1
	return
2::
	SendLevel, 0
	Send, {Text}2
	return
3::
	SendLevel, 0
	Send, {Text}3
	return
4::
	SendLevel, 0
	Send, {Text}4
	return
5::
	SendLevel, 0
	Send, {Text}5
	return
6::
	SendLevel, 0
	Send, {Text}6
	return
7::
	SendLevel, 0
	Send, {Text}7
	return
8::
	SendLevel, 0
	Send, {Text}8
	return
9::
	SendLevel, 0
	Send, {Text}9
	return
0::
	SendLevel, 0
	Send, {Text}0
	return
-::
	SendLevel, 0
	Send, {Text}-
	return
=::
	SendLevel, 0
	Send, {Text}=
	return
[::
	SendLevel, 0
	Send, {Text}[
	return
]::
	SendLevel, 0
	Send, {Text}]
	return
\::
	SendLevel, 0
	Send, {Text}\
	return
`;::
	SendLevel, 0
	Send, {Text}`;
	return
'::
	SendLevel, 0
	Send, {Text}'
	return
,::
	SendLevel, 0
	Send, {Text}`,
	return
.::
	SendLevel, 0
	Send, {Text}.
	return
/::
	SendLevel, 0
	Send, {Text}/
	return
*/

;  H O T K E Y S
/*
!j::
	MsgBox % dubHook.Input
	return
!g::
	Run, "C:\cmd_\AHKs\lib\KeyHoldHK_Ghost.ahk"
	return
*/

;  A R C H i V E D   C O D E
/*
`::
	SendLevel, 0
	Send, {Text}``
	SendLevel, 1
	KeyWait, ``, t0.175
	if ErrorLevel
	{
		SendInput, {Blind}{BS}
		Send, {Text}~
		KeyWait, ``, t0.625
		if ErrorLevel
		{
			Loop
			{
				KeyWait, ``, t0.050
				if ErrorLevel
				{
					if (A_Index <= 4)
					{
						Sleep, 25
						if (A_Index <= 2)
						{
							Sleep, 25
							if (A_Index <= 1)
								Sleep, 50
						}
					}
					Send, {Text}~
				}
			}
			Until ErrorLevel = 0
		}
	}
	else
	{
		KeyWait, ``, D t0.150
		if !ErrorLevel
		{
			Send, {Text}``
			KeyWait, ``, t0.600
			if ErrorLevel
			{
				Loop
				{
					KeyWait, ``, t0.050
					if ErrorLevel
					{
						if (A_Index <= 4)
						{
							Sleep, 25
							if (A_Index <= 2)
							{
								Sleep, 25
								if (A_Index <= 1)
									Sleep, 50
							}
						}
						Send, {Text}``
					}
				}
				Until ErrorLevel = 0
			}
		}
	}
return

1::
	SendLevel, 0
	Send, {Text}1
	SendLevel, 1
	KeyWait, 1, t0.175
	if ErrorLevel
	{
		SendInput, {Blind}{BS}
		Send, {Text}!
		KeyWait, 1, t0.625
		if ErrorLevel
		{
			Loop
			{
				KeyWait, 1, t0.050
				if ErrorLevel
				{
					if (A_Index <= 4)
					{
						Sleep, 25
						if (A_Index <= 2)
						{
							Sleep, 25
							if (A_Index <= 1)
								Sleep, 50
						}
					}
					Send, {Text}!
				}
			}
			Until ErrorLevel = 0
		}
	}
	else
	{
		dubHook := InputHook("V I1")
		dubHook.KeyOpt("{All}", "E")
		dubHook.KeyOpt("{1}", "S")
		dubHook.Start()
		dubHook.Wait()
		eK_dub := dubHook.EndKey
		eR_dub := dubHook.EndReason
		;MsgBox % eR_dub . "`n" eK_dub
		;KeyWait, 1, D t0.150
		if (eK_dub = "1")
		{
			Send, {Text}1
			KeyWait, 1, t0.600
			if ErrorLevel
			{
				Loop
				{
					KeyWait, 1, t0.050
					if ErrorLevel
					{
						if (A_Index <= 4)
						{
							Sleep, 25
							if (A_Index <= 2)
							{
								Sleep, 25
								if (A_Index <= 1)
									Sleep, 50
							}
						}
						Send, {Text}1
					}
				}
				Until ErrorLevel = 0
			}
		}
	}
return

	if (dubHook.EndReason = "Timeout")
	{
		SendInput, {Blind}{BS}
		SendLevel, 2
		Send, {Text}@
		KeyWait, 2, t0.625
		if ErrorLevel
		{
			Loop
			{
				KeyWait, 2, t0.050
				if ErrorLevel
				{
					if (A_Index <= 4)
					{
						Sleep, 25
						if (A_Index <= 2)
						{
							Sleep, 25
							if (A_Index <= 1)
								Sleep, 50
						}
					}
					Send, {Text}@
				}
			}
			Until ErrorLevel = 0
		}
	}
	else
	{
		KeyWait, 2, D t0.150
		if !ErrorLevel
		{
			Send, {Text}2
			KeyWait, 2, t0.600
			if ErrorLevel
			{
				Loop
				{
					KeyWait, 2, t0.050
					if ErrorLevel
					{
						if (A_Index <= 4)
						{
							Sleep, 25
							if (A_Index <= 2)
							{
								Sleep, 25
								if (A_Index <= 1)
									Sleep, 50
							}
						}
						Send, {Text}2
					}
				}
				Until ErrorLevel = 0
			}
		}
	}
return
*/
