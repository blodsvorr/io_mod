; GET CURSOR PIXEL COLOR HEX
getPixelHex( inX=-1 , inY=-1 )
{
	cpX := ""
	cpX := ""
	pixelchrome := ""
	validInput := false
	if ( (inX >= 0 && inX <= A_ScreenWidth) && (inY >= 0 && inY <= A_ScreenHeight) ) {
		validInput := true
	}
	origCMP := A_CoordModePixel
	CoordMode, Pixel, Screen
	if ( validInput ) {
		cpX := inX
		cpY := inY
	}
	else {
		coordsDUP := cursorCoords()
		cpX := coordsDUP.x
		cpY := coordsDUP.y
	}
	PixelGetColor, cursorPixelHex, % cpX, % cpY, RGB
	pixelchrome := SubStr( cursorPixelHex, 3 )
	StringUpper, pixelchrome, pixelchrome
	if ( !validInput ) {
		Clipboard := ""
		Clipboard := pixelchrome
		ahkMsg( "pixelchrome" , "  " . pixelchrome . "  " , 2000 , "IND" , pixelchrome )
	}
	CoordMode, Pixel, %origCMP%
	return pixelchrome
}
