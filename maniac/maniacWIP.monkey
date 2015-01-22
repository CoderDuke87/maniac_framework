#rem
	This is a Work in Progress Module.
	Here you can find some new features, which will be (maybe) implemented to the next Version.
#end


#rem
	done: deprecated Methods were Cleared.
	included FrymeTypes (Rect,SmoothRect,Circle for Button)
	included InactiveAnimation -> after a delaytime, the Button starts an Animation 
#end 

#rem
	New BUTTON Features:
		- now 3 Typs of Frames
		- added an "inactive-Animation" 
		- added a PopOut Animation for the Button

#end 

Import maniac 


'#### NEW CONSTS ####
Const BUTTON_FRAMETYPE_NOIMAGE:Int 		= -1
Const BUTTON_FRAMETYPE_RECT:Int 		= 0
Const BUTTON_FRAMETYPE_SMOOTHRECT:Int	= 1
Const BUTTON_FRAMETYPE_CIRCLE:Int 		= 2

Const BUTTON_EVENT_MOUSEOVER:Int 		= 87
Const BUTTON_EVENT_ONCLICK:Int			= 99
Const BUTTON_EVENT_ONRELEASE:Int		= 101

Const BUTTON_EVENT_IDLE:Int				= -1
Const BUTTON_EVENT_READY:Int			= 200

Class ManiacButtonWIP

	'Identificanitional Values
	Private 
	Field ID:Int 
	Field maniacID:Int
	Field MidX:Float,MidY:Float			'aktuelle Position des Buttons (Durch Animationen veränderbar
	Field oX:Float,oY:Float 		'Original X,Y << Das ist die Feste Position des Buttons
	Field Width:Float,Height:Float			'Breite und Höhe in Pxl
	Field oWidth:Float,oHeight:Float 
	
	'
	Field Caption:String		'Aufschrift
	Field CaptionColor:Int		'Color of the Caption
	Field Angle:Float 			'Winkel zur Horizontalen in °
	Field Alignment:Int			'ausrichtung des Textes (Left,Middle,Right)
	Field AlignmentVertical:int	
	Field bTransparent:Bool = False 
	
	'#### BACKGROUNDSTAUFF ####
	Field bBackgroundPic:Bool = False
	Field Color:Int 							'Color of the Background
	
	'#### EFFECTS STUFF ####
 
	
	'#### GLOW STUFF #####		Ready
	Field bGlow:Bool							'Wenn true, dann leuchtet der Button
	Field GlowHertz:Float 			= 0.5
	Field GlowAlpha:Float 						'Current Alpha for Glow Effect
	Field GlowAlphaFrom:Float		= 0.01		'Range for Alpha-Effekt.
	Field GlowAlphaTo:Float			= 0.3
	Field GlowStyle:Int				= 0			'0 - If Alpha reases max, it decreases from max ; 1 - if Alpha reaches max, it jumps to min
	Field bCurrGlowDirection:Bool 				'True - Raise, false - decrease
	Field GlowColor:Int	
	Field GlowRangeRatioX:Float = 1.3
	Field GlowRangeRatioY:Float = 1.7
	
	'#### FRAME STUFF ######
	Field bFramed:Bool 		= True 
	Field FrameColor:Int 
	Field FrameType:int
	
	
	
	'#### BUTTON MOUSEOVER STUFF #####
	Field bMO:Bool = False 
	Field bMOResize:Bool 		= false 
	Field bMOBrighter:Bool 		= false 
	Field bMOWobble:Bool		= false 
	Field AddWidthByMO:Int 		= 0
	Field AddHeightByMO:Int		= 0
	
	
	'##### BUTTON INACTIVE-ANIMATIONS #######
	Field bInactiveAnim:Bool = False
	Field bInactiveAnimating:Bool = False 
	Field InactiveTimeDelay:Int
	Field InactiveAnim:Int
	Field InactiveAnimType:Int 
	Field LastActiveTime:Int 
	
	'##### BUTTON ONCLICK ANIMATIONS ########
	Field bOnClickAnim:Bool = False 
	Field bOnClick_Spinning:Bool 
	Field bOnClick_Darkening:Bool 
	Field bOnClick_PlaySound:Bool 
	
	
	'##### WOBBLEEFFEKT STUFF #####
	Field lastWobble:Int 
	
	
	'##### ANIMATION STUFF #####
	Field bRunningAnimation:Bool 	= False 
	Field AnimStartTime:int		
	Field AnimTime:int		
	
	'Tweener for position Stuff
	Field tweenY:Tween
	Field tweenX:Tween
	Field tweenAngle:Tween
	
	'Booleans for Effect
	Field AnimEffect:Int 		
	 
	
	Public
	Method New(_MidX:Float,_MidY:Float,_Width:Float,_Height:Float,_Caption:String = "",_Alignment:Int = ALIGNMENT_MIDDLE,_Color:Int = COLOR_BLUE,_Glow:Bool = True,_GlowHertz:Float = 1,_Angle:Float = 0.0)
		If MANIAC_DEBUG = True
			Maniac_Debug.addStoredBools(9)
			Maniac_Debug.addStoredInts(12)
			Maniac_Debug.addStoredFloats(13)
			ID 		= Maniac_Debug.getNumberOfRegisteredObjects()
			Maniac_Debug.addRegisteredObject()
		Endif 
		oX 		= _MidX
		oY		= _MidY
		MidX 	= _MidX
		MidY 	= _MidY
		Width 	= _Width
		Height 	= _Height
		oWidth 	= _Width
		oHeight = _Height
		Alignment =_Alignment
		Caption =	_Caption
		CaptionColor = _Color +6
		Color		= _Color
		bGlow 		= _Glow
		GlowHertz	= _GlowHertz
		GlowColor = _Color
		Angle = _Angle
		FrameColor = _Color +6
	End Method 
	
	Method Draw()
		If MANIAC_DEBUG = True
			Maniac_Debug.addRenderedObject()
		Endif  
		
		'##### GLOW EFFECT STUFF #####
		If bGlow = True
			Maniac_Color(GlowColor)			'Set Glow Color
			SetAlpha GlowAlpha				'Set Glow Alpha 
			
			'Checking for which type of Frame (Rect, Round Rect, Circle or hardcoded ...
			Select FrameType
				Case BUTTON_FRAMETYPE_RECT
					DrawImage MANIAC_IMG_FRAME_BLUR , MidX,MidY,Angle,(Width+AddWidthByMO)/MANIAC_IMG_FRAME_RAW.Width(),(Height+AddHeightByMO)/MANIAC_IMG_FRAME_RAW.Height()
				Case BUTTON_FRAMETYPE_SMOOTHRECT
					DrawImage MANIAC_IMG_FRAME_SMOOTHRECTBLUR , MidX,MidY,Angle,(Width+AddWidthByMO)/MANIAC_IMG_FRAME_SMOOTHRECT.Width(),(Height+AddHeightByMO)/MANIAC_IMG_FRAME_SMOOTHRECT.Height()
				Case BUTTON_FRAMETYPE_CIRCLE
				Case BUTTON_FRAMETYPE_NOIMAGE
					'DrawRect(MidX- (Width +AddWidthByMO/2)/2+2,MidY-(Height+AddHeightByMO/2)/2+2,Width+AddWidthByMO-4,Height+AddHeightByMO-4)
			End Select
			
			If MANIAC_DEBUG = True
				Maniac_Debug.addTotDraws(1)
			Endif 
		End If
		
		
		'##### BUTTON BACKGROUND #####
		Maniac_Color(Color)
		If bTransparent = True 
			If bMO = True 
				SetAlpha 1
				If bMOResize = True
					AddWidthByMO = 10
					AddHeightByMO = 10
				Else
					AddWidthByMO = 0
					AddHeightByMO = 0
				Endif
			Else
				AddWidthByMO = 0
				AddHeightByMO = 0
				SetAlpha 0.6
			Endif 
		Else
			SetAlpha 1
			If bMO = True
				If bMOResize = True
					AddWidthByMO = 10
					AddHeightByMO = 10
				Else
					AddWidthByMO = 0
					AddHeightByMO = 0
				Endif 
			Else
				AddWidthByMO = 0
				AddHeightByMO = 0
			Endif 
		Endif 
		
		'Check if there is an loaded Image
		If bBackgroundPic = True 
			'TO DO : No Image reserved for this ... should be included next update
		Else 
			DrawRect(MidX- (Width +AddWidthByMO/2)/2+2,MidY-(Height+AddHeightByMO/2)/2+2,Width+AddWidthByMO-4,Height+AddHeightByMO-4)
		Endif 
		
		Maniac_Debug.addTotDraws(1)
		
		'###### BUTTON FRAME ########
		If bFramed = True	
			Maniac_Color(FrameColor)
			Select FrameType
				Case BUTTON_FRAMETYPE_RECT
					DrawImage MANIAC_IMG_FRAME_RAW , MidX,MidY,Angle,(Width+AddWidthByMO)/MANIAC_IMG_FRAME_RAW.Width(),(Height+AddHeightByMO)/MANIAC_IMG_FRAME_RAW.Height()
				Case BUTTON_FRAMETYPE_SMOOTHRECT
					DrawImage MANIAC_IMG_FRAME_SMOOTHRECT , MidX,MidY,Angle,(Width+AddWidthByMO)/MANIAC_IMG_FRAME_SMOOTHRECT.Width(),(Height+AddHeightByMO)/MANIAC_IMG_FRAME_SMOOTHRECT.Height()
				Case BUTTON_FRAMETYPE_CIRCLE
				Case BUTTON_FRAMETYPE_NOIMAGE
					
			End Select 
			
			Maniac_Debug.addTotDraws(1)
		Else
		
		Endif 
		
			
		 
		'##### DRAWING THE CAPTION TO THE BUTTON #####
		SetAlpha 1
		Maniac_Color(CaptionColor)
		Select Alignment
			Case ALIGNMENT_LEFT
				MANIAC_FONT.Wrap(Caption,MidX-Width/2,MidY-Height/5,Width,Height,Caption.Length())
				ResetMatrix()
			Case ALIGNMENT_MIDDLE
				Local l:Int = MANIAC_FONT.getW(Caption)
				MANIAC_FONT.Wrap(Caption,MidX-l/2+1,MidY-Height/5,Width,Height,Caption.Length())
				ResetMatrix()
			Case ALIGNMENT_RIGHT
				Local l:Int = MANIAC_FONT.getW(Caption)
				MANIAC_FONT.Wrap(Caption,MidX+Width/2-l,MidY-Height/5,Width,Height,Caption.Length())
				ResetMatrix()	
		End Select 
		
		
		If bTransparent = False
			If bMO = True 
				If bMOBrighter = True 
					SetAlpha 0.2
					SetColor 255,255,255
					DrawRect(MidX- (Width +AddWidthByMO/2)/2,MidY-(Height+AddHeightByMO/2)/2,Width+AddWidthByMO,Height+AddHeightByMO)
					Maniac_Debug.addTotDraws(1)
				Endif 
			Else
				'SetAlpha 0.6
			Endif 
			
		Endif 
		
	End Method 
	
	Method Update:Int()
		If MANIAC_DEBUG = True
			'Maniac_Debug.addCalc()
			Maniac_Debug.addCall()
		Endif  
		
		'### Updating Glow Effect ###
		'this will have effect to all Animation & Non Animation stuff.
		If bGlow = True 
			If bCurrGlowDirection = True
				GlowAlpha += EqToFPS(GlowHertz)
				If GlowAlpha >= GlowAlphaTo
					bCurrGlowDirection = False
				Endif 
			Else
				GlowAlpha -= EqToFPS(GlowHertz)
				If GlowAlpha <= GlowAlphaFrom
					bCurrGlowDirection = true
				Endif 
			Endif
		Endif 
		
		
		'### Animation Effects ###
		If bRunningAnimation = True
		
			'Check if AnimationTime is Over
			If Millisecs() - AnimStartTime > AnimTime
				bRunningAnimation = False   
			Endif
			
			
			'If not, calculate the next Position Stuff
			Select AnimEffect
				Case ANIM_DROP
					tweenY.Update()
					MidY = tweenY.Value()
				Case ANIM_FADE
				Case ANIM_ROTATE
				Case ANIM_ROLL
					tweenX.Update()
					tweenAngle.Update()
					Angle = tweenAngle.Value()
					MidX = tweenX.Value()
				Case ANIM_SLIDE
					tweenX.Update()
					MidX = tweenX.Value()
					
				Case ANIM_CIRCLE
					tweenY.Update()
					tweenX.Update()
					
					MidX = tweenX.Value()
					MidY = tweenY.Value()
					
				Case ANIM_POPOUT
					tweenX.Update()
					tweenY.Update()
					setSize(tweenX.Value(),tweenY.Value())
					
			End Select 
			
			
		Endif 
		
		If bInactiveAnim = True
			'Check when was the Last Animation
			'bInactiveAnimating
		Endif 
		
		'### User Input Stuff like MouseOver, ClickOn etc. ###
		If MOBox(MidX-Width/2	, MidY-Height/2, Width, Height)
			bMO = True 
			If bMOWobble = True
				doWobble()
			Endif 
			If TouchHit()
				Return 99
			Endif 
			Return 101
		Else
			bMO = False 
			If bRunningAnimation = False
				resetPosition()
			Endif 
		Endif
	End Method 
	
	
	Method startAnim(_AnimType:Int,  fromX:Float ,toX:Float ,_AnimTime:Int = 1000,ias:Float = 720,iae:Float = 0)
	
	End Method 
	
	Method startAnimDrop(_fromY:Float,_AnimTime:Int = 1500,_Style:String = "Bounce",_Ease:String = "Out")
	
		tweenY = ll_Tween(_Style,_Ease,_fromY,oY,_AnimTime )
		tweenY.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = ANIM_DROP
	End Method 
	
	Method startAnimRoll(_fromX:Float,_AnimTime:Int = 3000,_NumberRounds:Float = 10,_Style:String = "Bounce",_Ease:String = "Out")
		tweenX = ll_Tween(_Style,_Ease,_fromX,oX,_AnimTime )
		tweenX.Start()
		tweenAngle = ll_Tween(_Style,_Ease,_NumberRounds*(360),0,_AnimTime )
		tweenAngle.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = ANIM_ROLL
	End Method 
	
	Method startAnimSlide(_fromX:Float,_AnimTime:Int = 1500,_Style:String = "Bounce",_Ease:String = "Out")
		tweenX = ll_Tween(_Style,_Ease,_fromX,oX,_AnimTime )
		tweenX.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = ANIM_SLIDE
	End Method 
	
	Method startAnimCircle(_fromX:Float,_fromY:Float,_AnimTime:Int = 5000)
		tweenX = New Tween(Tween.Sine.EaseOut,_fromX,oX,_AnimTime)
		tweenX.Start()
		tweenY = New Tween(Tween.Sine.EaseInOut,_fromY,oY,_AnimTime)
		tweenY.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = ANIM_CIRCLE
	End Method 
	
	
	Method startAnimPopOut(_AnimTime:Int = 1500,_Style:String = "Back",_Ease:String = "Out")
		tweenX = ll_Tween(_Style,_Ease,0,oWidth,_AnimTime )
		tweenX.Start()
		tweenY = ll_Tween(_Style,_Ease,0,oHeight,_AnimTime )
		tweenY.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = ANIM_POPOUT
	End Method 
	
	
	Method setAlignment(_Alignment:Int)
	
		'Checking for using right Alignment Convention, else set to ALIGNMENT_MIDDLE
		Select _Alignment
			Case ALIGNMENT_LEFT
				Alignment = _Alignment
			Case ALIGNMENT_MIDDLE
				Alignment = _Alignment
			Case ALIGNMENT_RIGHT
				Alignment = _Alignment
			Default 
				Print "Alignment doesnt exist, Set To Middle!!!"
				Alignment =	ALIGNMENT_MIDDLE
		End Select
	End Method 
	
	Method setAlignmentVertical(_Alignment:Int)
		'Checking for using right Alignment Convention, else set to ALIGNMENT_MIDDLE
		Select _Alignment
			Case ALIGNMENT_TOP
				AlignmentVertical = _Alignment
			Case ALIGNMENT_MIDDLE
				AlignmentVertical = _Alignment
			Case ALIGNMENT_BOTTOM
				AlignmentVertical = _Alignment
			Default 
				Print "Alignment doesnt exist, Set To Middle!!!"
				AlignmentVertical =	ALIGNMENT_MIDDLE
		End Select
	End Method 
	
	Method setCaption(_Caption:String,_Color:int)
		Caption = _Caption
		CaptionColor = _Color
	End Method 
	
	Method setPosition(_X:float,_Y:float)
		MidX = _X
		MidY = _Y
	End Method 
	
	Method setSize(_Width:Float,_Height:Float)
		Width = _Width
		Height =_Height
	End Method 
	
	Method setAngle:Void(_Angle:Float)
		Angle = _Angle
	End Method 
	
	
	#Rem monkeydoc
		This Method sets the current Glow Effect.
		
		to switch Glow effect off, just call
		
		Example:
		<pre>
			'To Switch Off, just call within OnUpdate()
			 objName.setGlow(false) 
			 
			 'To Specify the Glow effect, use the params:~n
			 _isGlowing << true - glow is active, else it doesnt render glow effect ~n
			 _GlowColor << use one of the Maniac preset Color Ints.
			 _GlowHertz << 1.0 means it raises 100% Alpha within 1 Second ; 0.5 means it need 2 Seconds
			 
			 _GlowStyle	<< at the Moment just Style 0 implemented (Standard)
		</pre>
	#End
	Method setGlow(_isGlowing:Bool = True ,_GlowColor:Int = COLOR_WHITE ,_GlowHertz:Float = 1.0,_GlowAlphaFrom:Float = 0.2,_GlowAlphaTo:Float = 0.7,_GlowStyle:Int = 0)
		bGlow 		= _isGlowing
		GlowHertz	= _GlowHertz
		GlowColor 	= _GlowColor
		GlowAlphaFrom 	= _GlowAlphaFrom
		GlowAlphaTo 	= _GlowAlphaTo
		GlowStyle = _GlowStyle
	End Method 
	
	Method setFrame(_isFramed:Bool = True,_FrameColor:Int = 0,_FrameType:Int = 0)
		bFramed = _isFramed
		FrameColor = _FrameColor
		FrameType = _FrameType
	End Method 
	
	Method setMouseOverEffects(_isResizing:Bool= True ,_isBrightening:Bool=False,_isWobbling:Bool = false )
		bMOResize		= _isResizing
		bMOBrighter		= _isBrightening
		bMOWobble		= _isWobbling
	End Method 
	
	Method setMouseOnClickAnim(_isOnClickEffect:Bool = True,_isSpinning:Bool = True, _isSoundOn:Bool = True ,_isDarkening:Bool = True)
		bOnClickAnim = _isOnClickEffect
		
		'Checking for different types
		bOnClick_Spinning  = _isSpinning
		bOnClick_Darkening = _isDarkening
		bOnClick_PlaySound = _isSoundOn
	End Method 
	
	Method setInactiveAnim(_isActive:Bool = True,_inactiveTime:Int = 7500,_inactiveAnimType:Int = 0)
		bInactiveAnim = _isActive
		InactiveTimeDelay = _inactiveTime
		InactiveAnim:Int
		InactiveAnimType = _inactiveAnimType
	End Method 
	
	
	Method doWobble(_ShakeDistance:Float = 3.5,_Hertz:Float = 60,_Strength:Float = 0.9)
		If MANIAC_DEBUG = True
			'Maniac_Debug.addCalc()
			Maniac_Debug.addCall()
		Endif
		If Millisecs()-lastWobble >= (1000 / _Hertz)
			lastWobble = Millisecs()
			MidX += Rnd(-_Strength,_Strength)
			MidY += Rnd(-_Strength,_Strength)
			
			If MidX > (oX+_ShakeDistance)
				MidX = oX+_ShakeDistance
			Endif 
			If MidX < (oX-_ShakeDistance)
				MidX = oX-_ShakeDistance
			Endif 
			If MidY > (oY+_ShakeDistance)
				MidY = oY+_ShakeDistance
			Endif 
			If MidY < (oY-_ShakeDistance)
				MidY = oY-_ShakeDistance
			Endif
		Endif 
	
	End Method 
	
	
	Method doRotate(_AngleSpeed:Float)
		If MANIAC_DEBUG = True
			Maniac_Debug.addCall()
		Endif
		Angle += EqToFPS(_AngleSpeed)
	End Method  
	
	Method resetPosition()
		If MANIAC_DEBUG = True
			'Maniac_Debug.addCalc()
			Maniac_Debug.addCall()
		Endif
		MidX = oX
		MidY = oY
		Angle = 0
	End Method 
	
	Method doInstantTranslate(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Angle:Float)
	
	End Method 
End Class 


