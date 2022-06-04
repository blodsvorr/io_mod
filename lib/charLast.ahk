charLast(line := "")
{
	if !line
	{
		SendInput, {End}
		SendInput, +{Left}
		str := ghostCopy()
		SendInput, {Right}
	}
	else
		str := line
	ultimum := SubStr(str, 0, 1)
	return % ultimum
}
