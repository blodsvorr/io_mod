#Include C:\cmd_\AHKs\lib\
#Include ahkMsg.ahk
#Persistent
#SingleInstance force
icoFi := "C:\cmd_\AHKs\AHK_icons\Synthwave_Raven_icon_256.ico"
Menu, Tray, Icon, %icoFi%, 1, 1
#NoTrayIcon
DetectHiddenWindows, On

Run, *RunAs "C:\cmd_\AHKs\WinStartMain.ahk"


!#w::
	Run, *RunAs "C:\cmd_\AHKs\WinStartMain.ahk"
	ahkMsg( "W S M" , "START" , 800 , "SHI" )
	return
