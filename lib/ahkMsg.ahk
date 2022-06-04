; MESSAGE BANNER

ahkMsg( _cmd:="SW" , _str:="SW" , _t:="defT"
		, _disMode:="SHA" , _c:="defC" , _fs:=false )
{
	displayMode := _disMode

	defaultTime := 150
	mSecs := ""
	if ( _t = "defT" )
		mSecs := defaultTime
	else if ( _t > 0 )
		mSecs := _t

	scrW := A_ScreenWidth
	scrH := A_ScreenHeight
	scrSz := scrW . "x" . scrH

	sw_indigo := "4900E2"
	sw_shadow := "060609"

	font := "MonoLisa LightItalic"
	fontK := "MonoLisa BlackItalic"
	fontSz := ""
  	pt2px := 4/3

	fontColor := ""
	if ( _c = "defC" )
		fontColor := sw_indigo
	else
		fontColor := _c

	boxHeight := ""
	boxWidth := scrW / 2
	yPos := ""
	msgText := ""

	if ( _cmd = "SW" )
	{
		boxHeight := scrH / 2
		fontSz := 32
		yPos := 0
		if (_str = "ATOM")
			msgText := "a t o m . s y n t h w a v e"
		else if (_str = "SW")
			msgText := "S y n t h W a v e ()"
	}
	else
	{
		fontSz := 24
		boxHeight := fontSz * 4
		if ( _cmd = "Cursor X,Y" || _cmd = "pixelchrome" )
			multiplix := 14 / 9
		else
			multiplix := 8 / 9  ; 4 / 3
		yPos := Round( ( ( scrH / 2 ) * multiplix ) - ( boxHeight / 2 ) )
	  	msgText := buildStr( _cmd , _str )
	}

	msgLen := StrLen( msgText ) * fontSz * pt2px
	textX := ( (scrW - msgLen) / 2 ) * (1/5)
	textY := ""

	_ := A_Space
	_fontParams := "c" . fontColor . _ . "s" . fontSz
	_fontParamsInd := "c" . sw_shadow . _ . "s" . fontSz
	_guiOpts := "-Caption" . _ . "-Border"
	_winParams := "w" . boxWidth . _ . "h" . boxHeight . _ . "x0" . _ . "y" . yPos

	textY := ""
	if _fs
	{
		_winParams .= _ . "Maximize"
		textY := boxHeight / 2
	}
	else
	{
		textY := ( boxHeight - ( fontSz * pt2px ) ) * 3/7
		_guiOpts .= _ . "+AlwaysOnTop"
	}
	_msgParams := "x" . textX . _ . "y" . textY

	Gui, SWW_sha:New
	Gui, SWW_sha:Color, %sw_shadow%, %sw_shadow%
	Gui, SWW_sha:Font, %_fontParams%, %font%
	Gui, SWW_sha:%_guiOpts%
	Gui, SWW_sha:Add, Text, %_msgParams%, %msgText%

	Gui, SWW_indx:New
	Gui, SWW_indx:Color, %fontColor%, %fontColor%
	Gui, SWW_indx:Font, %_fontParamsInd%, %fontK%
	Gui, SWW_indx:%_guiOpts%
	Gui, SWW_indx:Add, Text, %_msgParams%, %msgText%

	blink := ""
	if ( mSecs <= 200 )
		blink := 80
	else if (mSecs > 1000)
		blink := 250
	else
		blink := mSecs / 2

	switch, displayMode
	{
		case "SHA":
			Gui, SWW_sha:Show, %_winParams%
			Sleep, %mSecs%
			Gui, SWW_sha:Destroy
			Gui, SWW_indx:Destroy
			return
		case "IND":
			Gui, SWW_indx:Show, %_winParams%
			Sleep, %mSecs%
			Gui, SWW_indx:Destroy
			Gui, SWW_sha:Destroy
			return
		case "SHI":
			Gui, SWW_sha:Show, %_winParams%
			Sleep, %mSecs%
			Gui, SWW_indx:Show, %_winParams%
			Gui, SWW_sha:Destroy
			Sleep, %blink%
			Gui, SWW_indx:Destroy
			return
		case "ISH":
			Gui, SWW_indx:Show, %_winParams%
			Sleep, %mSecs%
			Gui, SWW_sha:Show, %_winParams%
			Gui, SWW_indx:Destroy
			Sleep, %blink%
			Gui, SWW_sha:Destroy
			return
		default:
			Gui, SWW_sha:Show, %_winParams%
			Sleep, %mSecs%
			Gui, SWW_sha:Destroy
			Gui, SWW_indx:Destroy
			return
	}
	return
}


; S U P P L E M E N T L E   F U N C T i O N S

buildStr( command, string )
{
	msgSTR := spaceLetters(command) . "  (   " . spaceLetters(string) . "   ) "
	return % msgStr
}

spaceLetters( orig )
{
	output := ""
	chars := StrSplit( orig )
	arrSize := chars.Length()

	i := 1
	Loop,
		if ( i <= arrSize )
		{
			output .= chars[i]
			if ( i = arrSize )
				break
			output .= " "
			i++
		}

	return % output
}



/*
	endStr := "< / >"
	paramsLiteralMsg := "c10 w%boxWidth% h%boxHeight% x0 y%yPos% xm+8 ym+16"
	Transform, paramsMsg, Deref, %paramsLiteralMsg%

	paramsLiteralEnd := "c10 w%boxWidth% h%boxHeight% x0 y%yPos% xm+8 ym+4"
	Transform, paramsEnd, Deref, %paramsLiteralEnd%

	Progress, %paramsMsg%, %msgText%,,, %font%
	Progress, %paramsEnd%, %endStr%,,, %fontK%

	Progress, Options, Sub Text, Main Text, Win Title, Font
*/
