#Rem monkeydoc Module maniac.maniacLowLevel
	LowLevel Modue-Version 0.1.4  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	
	This is the Maniac LowLevel Module.~n
	Functions in here should only be called by the Maniac Higher Level Functions.~n
	So the user shouldn't worry about the following Classes and Functions, unless he needs some special lowlevel Functions~n
	~n
	VERSION HISTORY: ~n
	
	0.1.4  @ 21.01.2015~n
		added: ll_ContainDate, ll_convertsDateToMonth, ll_convertDateToDay
	0.1.3  @ 18.01.2015~n
		added: ll_Tween
	0.1.2~n
		added: ll_Width
	0.1.1~n
		Integrated some Debug Stuff
	0.1.0~n
		added some
	
	Implemented Feature: LowLevel
		- Calculating Distance between two Points
		- Calculating Delta Timing Values
		- Some Date Convert & Checking Functions
#End


Import mojo
Import maniac

#rem	Put them into the main maniac Source File
Global gl_clicked:Bool
Global gl_mousereleased:Bool
#end

#Rem monkeydoc
	### READY TO USE ###~n
	This Functions checks the actual MouseState.~n
	It will be called automatically within the maniacUpdate() Method.
#End
Function Maniac_CheckMouseState()
	If MANIAC_DEBUG = True
		Maniac_Debug.addCall()
	Endif
	gl_mousereleased = False 
	If gl_clicked = False and TouchHit()
		gl_clicked = True 
	Endif
		
	If TouchDown()
		
	Else
		If gl_clicked = True
			gl_mousereleased = True 
			gl_clicked = False 
		Endif 
	Endif 
End Function



#Rem monkeydoc
	### READY TO USE ###~n
	This Function calculates the distance between two Points in Pixels.
	returning the Ergebnis as a Float
#End
Function ll_Distance:Float(fromX:Float,fromY:Float,toX:Float,toY:Float)
	If MANIAC_DEBUG = True
		Maniac_Debug.addCalc()
		Maniac_Debug.addCall()
	Endif
	Local dx:Float = fromX-toX
	Local dy:Float = fromY-toY
	Return Sqrt(dx*dx+dy*dy)
End Function 

#Rem monkeydoc
	### READY TO USE ###~n
	This function Calculates the time ellapsed since last frame.
	It will be called automatically within the maniacUpdate() Method.
	For using the Delta-Timing System, make sure to call maniacUpdate() once a frame within your OnUpdate().
#End
Function ll_UpdateSpeeds()
	If MANIAC_DEBUG = True
		Maniac_Debug.addCalc()
		Maniac_Debug.addCall()
	Endif
	Local currentTime = Millisecs()
	local deltaTime = currentTime - maniac_lastTime
  	maniac_lastTime = currentTime

  	'And calculate a scale value to convert -per-second values to -per-frame values
  	maniac_timeScale = deltaTime / 1000.0
End Function

#Rem monkeydoc
	### READY TO USE ###~n
	This function Calculates the width of ... .
#End
Function ll_Width:Float(_Width:Float,_Number:Float,_Distance:Float)
	If MANIAC_DEBUG = True
		Maniac_Debug.addCalc()
		Maniac_Debug.addCall()
	Endif
	Local fW:Float 
	fW = (_Width-_Number*_Distance-_Distance)/(_Number)
	Return fW
End Function 



Function ll_ConvertToBool:bool(_int:Int)
	If _int = 0
		Return False 
	Else
		Return True 
	Endif 
End Function 

#rem 
	Gibt den "Grid"-Wert des Cursors zurück.
	Bsp:
	Ihre Map besteht aus 20x20'er Kacheln 100pxl von beiden Ordinaten abstand.
	dann enstricht die Mouseposition 134,110 einem Gridwert von 2,1
#end 
Function ll_GridX:Int(width_p:Int, offset:Int = 0)
	
	Return (MouseX() -offset) / (width_p)

End Function

Function ll_GridY:Int(width_p:Int, offset:Int = 0)

	Return (MouseY() -offset) / (width_p)

End Function
#Rem monkeydoc
	### Experimental ###~n
	This Function initialises a new Tween Object with Costum setting.
	Makes the Tweening a little bit more code-dynamic
	Useable: Bounce, Elastic, Quad, Sine , Back , Circ
	ToDo: -Linear , Cubic , Expo , Quart , Quint
	
#End
Function ll_Tween:Tween(_Style:String,_Ease:String = "In",_fromX:Float,_toX:Float,_AnimTime:Int )
	Select _Style
		Case "Bounce"
			Select _Ease
				Case "Out" '#easeOut
					Return (New Tween(Tween.Bounce.EaseOut,_fromX,_toX,_AnimTime))
				Case "In" '#easeIn
					Return (New Tween(Tween.Bounce.EaseIn,_fromX,_toX,_AnimTime))
				Case "InOut" '#easeInOut
					Return (New Tween(Tween.Bounce.EaseInOut,_fromX,_toX,_AnimTime))
				Case "OutIn" '#easeInOut
					Return (New Tween(Tween.Bounce.EaseInOut,_fromX,_toX,_AnimTime))
			End Select
			
			
		Case "Elastic"
			Select _Ease
				Case "Out" '#easeOut
					Return  (New Tween(Tween.Elastic.EaseOut,_fromX,_toX,_AnimTime))
				Case "In" '#easeIn
					Return (New Tween(Tween.Elastic.EaseIn,_fromX,_toX,_AnimTime))
				Case "InOut" '#easeInOut
					Return (New Tween(Tween.Elastic.EaseInOut,_fromX,_toX,_AnimTime))
				Case "OutIn" '#easeInOut
					Return (New Tween(Tween.Elastic.EaseInOut,_fromX,_toX,_AnimTime))
			End Select 
			
			
		Case "Quad"
			Select _Ease
				Case "Out" '#easeOut
					Return  (New Tween(Tween.Quad.EaseOut,_fromX,_toX,_AnimTime))
				Case "In" '#easeIn
					Return (New Tween(Tween.Quad.EaseIn,_fromX,_toX,_AnimTime))
				Case "InOut" '#easeInOut
					Return (New Tween(Tween.Quad.EaseInOut,_fromX,_toX,_AnimTime))
				Case "OutIn" '#easeInOut
					Return (New Tween(Tween.Quad.EaseInOut,_fromX,_toX,_AnimTime))
			End Select
			
			
		Case "Sine"
			Select _Ease
				Case "Out" '#easeOut
					Return  (New Tween(Tween.Sine.EaseOut,_fromX,_toX,_AnimTime))
				Case "In" '#easeIn
					Return (New Tween(Tween.Sine.EaseIn,_fromX,_toX,_AnimTime))
				Case "InOut" '#easeInOut
					Return (New Tween(Tween.Sine.EaseInOut,_fromX,_toX,_AnimTime))
				Case "OutIn" '#easeInOut
					Return (New Tween(Tween.Sine.EaseInOut,_fromX,_toX,_AnimTime))
			End Select
			
			
		Case "Back"
			Select _Ease
				Case "Out" '#easeOut
					Return  (New Tween(Tween.Back.EaseOut,_fromX,_toX,_AnimTime))
				Case "In" '#easeIn
					Return (New Tween(Tween.Back.EaseIn,_fromX,_toX,_AnimTime))
				Case "InOut" '#easeInOut
					Return (New Tween(Tween.Back.EaseInOut,_fromX,_toX,_AnimTime))
				Case "OutIn" '#easeInOut
					Return (New Tween(Tween.Back.EaseInOut,_fromX,_toX,_AnimTime))
			End Select
			
			
		Case "Circ"
			Select _Ease
				Case "Out" '#easeOut
					Return  (New Tween(Tween.Circ.EaseOut,_fromX,_toX,_AnimTime))
				Case "In" '#easeIn
					Return (New Tween(Tween.Circ.EaseIn,_fromX,_toX,_AnimTime))
				Case "InOut" '#easeInOut
					Return (New Tween(Tween.Circ.EaseInOut,_fromX,_toX,_AnimTime))
				Case "OutIn" '#easeInOut
					Return (New Tween(Tween.Circ.EaseInOut,_fromX,_toX,_AnimTime))
			End Select
		
		
		Case "Cubic"
			Select _Ease
				Case "Out" '#easeOut
					Return  (New Tween(Tween.Cubic.EaseOut,_fromX,_toX,_AnimTime))
				Case "In" '#easeIn
					Return (New Tween(Tween.Cubic.EaseIn,_fromX,_toX,_AnimTime))
				Case "InOut" '#easeInOut
					Return (New Tween(Tween.Cubic.EaseInOut,_fromX,_toX,_AnimTime))
				Case "OutIn" '#easeInOut
					Return (New Tween(Tween.Cubic.EaseInOut,_fromX,_toX,_AnimTime))
			End Select
		Case "Expo"
			Select _Ease
				Case "Out" '#easeOut
					Return  (New Tween(Tween.Expo.EaseOut,_fromX,_toX,_AnimTime))
				Case "In" '#easeIn
					Return (New Tween(Tween.Expo.EaseIn,_fromX,_toX,_AnimTime))
				Case "InOut" '#easeInOut
					Return (New Tween(Tween.Expo.EaseInOut,_fromX,_toX,_AnimTime))
				Case "OutIn" '#easeInOut
					Return (New Tween(Tween.Expo.EaseInOut,_fromX,_toX,_AnimTime))
			End Select
		Case "Quart"
			Select _Ease
				Case "Out" '#easeOut
					Return  (New Tween(Tween.Quart.EaseOut,_fromX,_toX,_AnimTime))
				Case "In" '#easeIn
					Return (New Tween(Tween.Quart.EaseIn,_fromX,_toX,_AnimTime))
				Case "InOut" '#easeInOut
					Return (New Tween(Tween.Quart.EaseInOut,_fromX,_toX,_AnimTime))
				Case "OutIn" '#easeInOut
					Return (New Tween(Tween.Quart.EaseInOut,_fromX,_toX,_AnimTime))
			End Select
			
		Default
			Print "Starting default tweenModifier"
	End Select  
End Function 

#Rem monkeydoc
	Color of centre of lightning strike
#End
Function ll_ColorCentre()
	If MANIAC_DEBUG = True
		Maniac_Debug.addCall()
	Endif
	SetColor 255,255,255

End Function

#Rem monkeydoc
	Main color theme of lightning strike
#End
Function ll_ColorInnerEdge()
	If MANIAC_DEBUG = True
		Maniac_Debug.addCall()
	Endif
	SetColor 0,128,255

End Function

#Rem monkeydoc
	;;Faint outer colour of lightning strike...
#End
Function ll_ColorOuterEdge()

	If MANIAC_DEBUG = True
		Maniac_Debug.addCall()
	Endif
	SetColor 0,32,128

End Function 

Global ll_months:String[] = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
Global ll_day:Int[] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,24,25,26,27,28,29,30,31]


#Rem monkeydoc
	Checks if a String Contains a Date a la "Jan_02" or "Aug_22" ...
#End
Function ll_ContainDate:Bool(iStr:String)

	For Local m:Int = 0 Until 12
		For Local d:Int = 0 Until 31
			Local strDay:String 
			If ll_day[d] < 10
				strDay = "0" + ll_day[d]
			Else
				strDay = ll_day[d]
			Endif 
			If iStr.Contains(ll_months[m]+"_"+strDay)
				Return True 
			Endif 
		Next
	Next 

	Return False 
End Function 


#Rem monkeydoc
	Returns an Integer belonging to a Month.
	Jan = 0 , Feb = 1 ...
#End
Function ll_convertDateToMonth:Int(_Date:String)
	For Local m:Int = 0 To 12
		
		If _Date.Contains(ll_months[m])
			Return m
		Endif 
	Next 
End Function 


#Rem monkeydoc
	Returns an Integer belonging to a Day.
	01 = 0 , 02 = 1 ...
#End
Function ll_convertDateToDay:Int(_Date:String)
	For Local d:Int = 0 To 31
		Local strDay:String 
		If ll_day[d] < 10
			strDay = "0" + ll_day[d]
		Else 
			strDay = ll_day[d]
		Endif 
		If _Date.Contains(strDay)
			Return d
		Endif 
	Next 

End Function 

Function ll_Rotate(x:Float, y:Float, angle:Float)
	PushMatrix				' Store current rotation, scale, etc
	Translate x, y			' Shift origin across to here
	Rotate angle			' Rotate around origin
	Translate -x, -y		' Shift origin back where it was
End

' ResetDisplay: resets view back to normal...
Function ll_Reset()
	PopMatrix				' Restore rotation, scale, etc
End

#rem
	The following Skew and Mirror functions are from Danilo posted on Monkey
	http://www.monkey-x.com/Community/posts.php?topic=8066
#end
' - Shear/Skew  -------------------->> REQUIRES DECISION: What's the best name? Skew or Shear?
Function SkewX:Void(angle:Float)
    Transform(1,0,Tan(angle),1,0,0)
End

Function SkewY:Void(angle:Float)
    Transform(1,Tan(angle),0,1,0,0)
End

Function ShearX:Void(angle:Float)
    Transform(1,0,Tan(angle),1,0,0)
End

Function ShearY:Void(angle:Float)
    Transform(1,Tan(angle),0,1,0,0)
End


' - Mirror
Function MirrorX:Void()
    Transform(1,0,0,-1,0,0)
End

Function MirrorY:Void()
    Transform(-1,0,0,1,0,0)
End

' - 'At' functions apply a function
'        at/around a specific point

' - Shear/Skew  -------------------->> REQUIRES DECISION: What's the best name? Skew or Shear?
Function SkewXAt:Void(x:Float, y:Float, angle:Float)
    Translate(x, y)
    Transform(1,0,Tan(angle),1,0,0)
    Translate(-x, -y)
End

Function SkewYAt:Void(x:Float, y:Float, angle:Float)
    Translate(x, y)
    Transform(1,Tan(angle),0,1,0,0)
    Translate(-x, -y)
End

Function ShearXAt:Void(x:Float, y:Float, angle:Float)
    Translate(x, y)
    Transform(1,0,Tan(angle),1,0,0)
    Translate(-x, -y)
End

Function ShearYAt:Void(x:Float, y:Float, angle:Float)
    Translate(x, y)
    Transform(1,Tan(angle),0,1,0,0)
    Translate(-x, -y)
End


Function RotateAt:Void(x:Float, y:Float, angle:Float)
    Translate(x, y)
    Rotate(angle)
    Translate(-x, -y)
End

Function ScaleAt:Void(x:Float, y:Float, scaleX:Float, scaleY:Float)
    Translate(x, y)
    Scale(scaleX, scaleY)
    Translate(-x, -y)
End

Function MirrorXAt:Void(x:Float, y:Float)
    Translate(x, y)
    Transform(1,0,0,-1,0,0)
    Translate(-x, -y)
End

Function MirrorYAt:Void(x:Float, y:Float)
    Translate(x, y)
    Transform(-1,0,0,1,0,0)
    Translate(-x, -y)
End

' - reset Matrix to standard
Function ResetMatrix:Void()
    SetMatrix(1,0,0,1,0,0)
End

#Rem monkeydoc
	TO DO
	This wil be a Class for a Logo. 
	It consists of seperate Layers, all will be animated by its own.
#End
Class ManiacLogo
	Field X:Float,Y:Float,Width:Float,Height:Float
	
End Class 

