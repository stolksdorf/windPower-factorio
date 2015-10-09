#SingleInstance force
!^r::Reload

; Do a dummy export to setup pathing, change the default export settings to export to a 5000px image
; Make sure Scenes and Shadows are extended

!y::
	MsgBox, running
	Sleep, 1000
	Loop, 6
	{
		SelectRotateScene()
		RotateModel()
		SelectMoneyShot()
		ExportImage(A_Index)
		ExportNoShadow(A_Index)
	}
	MsgBox, Done!
return



FocusSketchUp(){
	SetTitleMatchMode, 2
	WinActivate, SketchUp
}

SelectMoneyShot(){
	MouseClick, left, 1340, 580 , 2
	Sleep, 3000
	FocusSketchUp()
}

SelectRotateScene(){
	MouseClick, left, 1400, 580 , 2
	Sleep, 3000
	FocusSketchUp()
}

RotateModel(){
	MouseClick, left, 390, 70 ;;Select rotate tool
	Sleep, 500
	MouseClick, left, 660, 408 ;;Select center point
	Sleep, 500
	MouseClick, left, 1000, 460 ;;Draw out arm
	MouseMove, 1000, 550
	Sleep, 500
	Send, 15{Enter} ;; Enter in degrees
	Sleep, 500
	MouseClick, left, 35, 70 ;;Select pointer tool
}

ExportImage(frameNum){
	Send, ^e
	Sleep, 500
	Send, windturbine%frameNum%{enter}
	Sleep, 8000
	FocusSketchUp()
}

ExportNoShadow(frameNum){
	MouseClick, left, 1276, 379 ;;Turn off ground shadows
	Sleep, 500
	FocusSketchUp()
	Send, ^e
	Sleep, 500
	Send, windturbine%frameNum%_noshadow{enter}
	Sleep, 8000
	MouseClick, left, 1276, 379 ;;Turn on ground shadows
	FocusSketchUp()
}