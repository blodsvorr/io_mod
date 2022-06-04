charNext()
{
	SendInput, +{Right}
	nChar := ghostCopy()
	SendInput, {Left}
	return % nChar
}
