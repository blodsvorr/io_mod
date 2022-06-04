ghostCopy( path := false )
{
	hold := Clipboard
	Clipboard := ""
	if !path
		xcv()
	else
		SendInput, !c
	ClipWait
	copied := Clipboard
	Clipboard := hold
	return % copied
}
