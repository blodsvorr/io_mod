; GET CURSOR COORDiNATES
cursorCoords()
{
	origCMP := A_CoordModeMouse
	CoordMode, Mouse, Screen
	MouseGetPos, xpos, ypos
	xyDUP := {x: xpos , y: ypos}
	CoordMode, Mouse, %origCMP%
	return % xyDUP
}
