xcv(ccp := "c")
{
	key := ""
	if ( ccp != "p" ) {
		if ( ccp = "x" || ccp = "v" )
			key := ccp
		else
			key := "c"
		SendInput ^%key%
	} else {
		SendInput !c
	}
	return
}
