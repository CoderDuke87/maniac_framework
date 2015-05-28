#Rem monkeydoc Module maniac.maniacNumberSelector
	GUI - NumberSelector Module - Version 1.0 (alpha)  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	

		
#End

Import maniac


Class ManiacNumberSelector

	Field maniacID:Int 
	Field X:Float,oX:Float
	Field Y:Float,oY:float
	Field Width:Float, Height:Float
	Field oWidth:Float,oHeight:Float	'originale Breite und hoehe
	Field bChecked:Bool 
	Field Caption:String
	Field bCaption:Bool = True
	Field AlignText:Int 
	Field Alpha:Float = 1.0
	
	Field minValue:Int
	Field maxValue:Int 
	Field currNumber:Int = 12
	
	
	'##### ANIMATION STUFF #####
	Field bRunningAnimation:Bool 	= False 
	Field AnimStartTime:int		
	Field AnimTime:int		
	Field Angle:Float 			'Winkel zur Horizontalen in °
	
	'Tweener for position Stuff
	Field tweenY:Tween
	Field tweenX:Tween
	Field tweenAngle:Tween
	
	'Booleans for Effect
	Field AnimEffect:Int
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Caption:String="")
		If MANIAC_DEBUG = True
			Maniac_Debug.addStoredBools(1)
			Maniac_Debug.addStoredInts(1)
			Maniac_Debug.addStoredFloats(4)
			maniacID 		= Maniac_Debug.getNumberOfRegisteredObjects()
			Maniac_Debug.addRegisteredObject()
		Endif 
		X 		= _X
		Y		= _Y
		oX 		= _X
		oY		= _Y
		Width 	= _Width
		Height 	= _Height
		oWidth 	= _Width
		oHeight = _Height
		Caption =	_Caption
		AlignText = ALIGNMENT_TOP
	End Method 
	
	
	
	Method Draw()
		SetAlpha(Alpha)
		Drw_Rect(X,Y,Width,Height,2)
		
		If bChecked = True
			DrawImage ManiacImg[IMG_ICON_CHECKEDARROW] ,X+Width/2 ,Y+Height/2 ,0 , Width/ManiacImg[IMG_ICON_CHECKEDARROW].Width() , (Height)/ManiacImg[IMG_ICON_CHECKEDARROW].Height()
		Endif 

		If bCaption = True
			Select AlignText
				Case ALIGNMENT_LEFT
				Case ALIGNMENT_RIGHT
					Drw_ManiacText(Caption,X+Width+5,Y,DW*0.3,800,ALIGNMENT_LEFT,ALIGNMENT_TOP,1.1)
				Case ALIGNMENT_TOP
					Drw_ManiacText(Caption,X-DW*0.2,Y-60,DW*0.4+Width,800,ALIGNMENT_MIDDLE,ALIGNMENT_TOP,1.1)
				Case ALIGNMENT_BOTTOM
			End Select 
			
		Endif 
		
		DrawImage ManiacImg[IMG_ICON_ARROWUP], X+Width/2,Y-20,0, Width/ManiacImg[IMG_ICON_ARROWUP].Width() , (Height*0.5)/ManiacImg[IMG_ICON_ARROWUP].Height()
		DrawImage ManiacImg[IMG_ICON_ARROWDOWN], X+Width/2,Y+Height+20,0, Width/ManiacImg[IMG_ICON_ARROWDOWN].Width() , (Height*0.5)/ManiacImg[IMG_ICON_ARROWDOWN].Height()
		
		Drw_ManiacText(currNumber,X,Y,Width,Height,ALIGNMENT_MIDDLE,ALIGNMENT_MIDDLEY,1.1)
		
		SetAlpha 1
	End Method
	
	Method Update:int()
		'### USER INPUT ###
		If TouchHit()
			If MOBox(X-5,Y-25-(Height*0.25),Width+10,Height*0.5+10)
				
				If currNumber < maxValue
					currNumber +=1
				Else
					currNumber = minValue
				Endif
			Endif 
			
			If MOBox(X-5,Y+Height+15-(Height*0.25),Width+10,Height*0.5+10)		'down Array
				If currNumber > minValue
					currNumber -=1
				Else
					currNumber = maxValue
				Endif 
			Endif
		Endif 
		
		'### Animation Effects ###
		If bRunningAnimation = True
			If doAnimUpdate() = 1' And bRunOnClickAnim = true
				Return 2000
			End If 
		Endif
	End Method
	
	Method getChecked:Bool()
		Return bChecked
	End Method 
	
	Method setAlignText:Void(_AlignText:Int)
		AlignText = _AlignText
	End Method 

	Method setNumberMinMax(_MinValue:Int,_MaxValue)
		minValue = _MinValue
		maxValue = _MaxValue
	End Method 
	
	
	Method setTransparency:Void(_TransparencyAlpha:Float)
	
	End Method 
	
	public
	Method startAnimSlide(_fromX:Float,_AnimTime:Int = 1500,_Style:String = "Back",_Ease:String = "Out")
		tweenX = ll_Tween(_Style,_Ease,_fromX,oX,_AnimTime )
		tweenX.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = ANIM_SLIDE
	End Method
	
	
	Method doAnimUpdate:int()
		'Check if AnimationTime is Over
		If Millisecs() - AnimStartTime > AnimTime
			bRunningAnimation = False 
			setSize(oWidth,oHeight)
			'Print "W/H: " + oWidth + ":"+oHeight  
			Return 1
		Endif
			
			
		'If not, calculate the next Position Stuff
		Select AnimEffect
			Case ANIM_DROP
				tweenY.Update()
				Y = tweenY.Value()
				
				Return 0
			Case ANIM_FADE
			Case ANIM_ROTATE
				tweenAngle.Update()
				Angle = tweenAngle.Value()
				Return 0
			Case ANIM_ROLL
				tweenX.Update()
				tweenAngle.Update()
				Angle = tweenAngle.Value()
				X = tweenX.Value()
				Return 0
			Case ANIM_SLIDE
				tweenX.Update()
				X = tweenX.Value()
				Return 0
			Case ANIM_CIRCLE
				tweenY.Update()
				tweenX.Update()
					
				X = tweenX.Value()
				Y = tweenY.Value()
				Return 0
			Case ANIM_POPOUT
				tweenX.Update()
				tweenY.Update()
				setSize(tweenX.Value(),tweenY.Value())
				Return 0	
		End Select
		
		Return -1
	End Method
	
	#rem monkeydoc
		Set the current Size of the Button in Pixel.
	#end
	Method setSize(_Width:Float,_Height:Float)
		Width = _Width
		Height =_Height
	End Method
End Class
