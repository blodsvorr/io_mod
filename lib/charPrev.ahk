charPrev()
{
	SendInput, +{Left}
	pChar := ghostCopy()
	SendInput, {Right}
	return % pChar
}
