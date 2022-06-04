ih( i := 0 , t := 0 , keys := "" , suppress := "" )
{
	defaultKeys := "{Enter}{Escape}"
	hookOpts := "V"
	if i
		hookOpts .= " I" . i
	if t
		hookOpts .= " T" . t

	if keys
	{
		if (SubStr(keys, 0, 1) = "+")
		{
			endInd := StrLen(keys) - 1
			addKeys := SubStr(keys, 1, endInd)
			endKeys := defaultKeys . addKeys
		}
		else
			endKeys := keys
	}
	else
		endKeys := defaultKeys

	if suppress
		suppKeys := suppress
	else
		suppKeys := endKeys

	hook := InputHook(hookOpts, endKeys)
	hook.KeyOpt(suppKeys, "+S")

	hook.Start()
	hook.Wait()
	hookOut := [hook.EndReason, hook.EndKey, hook.Input]

	return % hookOut
}
