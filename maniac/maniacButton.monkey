#Rem monkeydoc Module maniac.maniacButton
	This Class is a Button Gui Element.~n
	Version: 0.9 
	ToDo: Sounds , GlowEffect
	
	
	~n
	Featurelist:~n
		- Introanimations, MouseOverEffects, OnClickAnimations, 4 Different Styles (BUTTON_STYLE_STD,BUTTON_STYLE_MODERN, BUTTON_STYLE_ROUND, BUTTON_STYLE_CIRCLE) ~n
		
Example:
<pre>
Global tB:ManiacButton = new ManiacButton(100,100,300,32)

Function Main:Int()
	New Example							
	Return 0
End Function  
		
Class Example extends App

	field BtnTest:ManiacButton
	
	Method OnCreate:Int()
		SetUpdateRate( 60 )
		maniacInit()			' THIS INITS THE MANIAC FRAMEWORK! THIS NEED TO BE DONE BEFORE USING IT!!!!!
		
		
		BtnTest = New ManiacButton(DW*0.5,DH*0.6,DW*0.3,DH*0.1,"Rounded")
		BtnTest.setStyle(BUTTON_STYLE_ROUND)
		BtnTest.setAlignment(ALIGNMENT_RIGHT)
		BtnTest.setMouseOnClickAnim(True, false , True,false)
	end Method 
		
	Method OnUpdate:int()
		maniacUpdate()			'THIS UPDATES ALL NEEDED DATA FOR THE MANIAC-GLOBALS
	end method
		
	Method OnRender:int()
		Cls
		
		maniacDraw()
	end Method  
End class


</pre>
	

#End
Import maniac




Class ManiacButton

	'Identificanitional Values
	public 
	Field ID:Int 
	Field maniacID:Int
	Field MidX:Float,MidY:Float			'aktuelle Position des Buttons (Durch Animationen veränderbar
	Field oX:Float,oY:Float 			'Original X,Y << Das ist die Feste Position des Buttons
	Field Width:Float,Height:Float		'Breite und Höhe in Pxl
	Field oWidth:Float,oHeight:Float	'originale Breite und hoehe
	'
	Field Caption:String		'Aufschrift
	Field CaptionColor:Int		'Color of the Caption
	Field Angle:Float 			'Winkel zur Horizontalen in °
	Field Alignment:Int			'ausrichtung des Textes (Left,Middle,Right)
	Field AlignmentX:Int
	Field AlignmentY:Int 
	Field bWrapText:Bool 
	Field bTransparent:Bool = false 
	Field bVisible:Bool 	= True 
	Field bSound:Bool 		= True 
	Field bWithImage:Bool 	= False 
	
	'#### EFFECTS STUFF ####
	'Field 
	
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
	Field FrameType:Int 	= 0
	Field FrameThickness:Int = 1
	
	Field ButtonStyle:Int = 0
	Field Color:Int 							'Integerwert einer Farbe aus der Maniac_Color Funktion
	
	'#### BUTTON MOUSEOVER STUFF #####
	Field bMO:Bool = False 
	Field bMOResize:Bool 		= false 
	Field bMOBrighter:Bool 		= false 
	Field bMOWobble:Bool		= false 
	Field AddWidthByMO:Int 		= 0
	Field AddHeightByMO:Int		= 0
	
	
	'##### BUTTON ON CLICK ANIMATIONS #####
	Field bOnClickAnim:Bool 	= True 
	Field OnClickedAnimStartTime:Int
	Field OnClickAnimeTime:Int 
	Field bOnClick_Spinning:Bool
	Field bOnClick_Darkening:bool
	Field bOnClick_PlaySound:Bool
	Field bRunOnClickAnim:Bool 
	
	'##### BUTTON INACTIVE-ANIMATIONS #######
	Field bInactiveAnim:Bool = False
	Field bInactiveTime:Int
	Field InactiveAnim:Int 
	Field LastActiveTime:Int 
	 
	
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
		#rem
			Some Debug Stuff. 
		#end	
		If MANIAC_DEBUG = True
			Maniac_Debug.addStoredBools(12)
			Maniac_Debug.addStoredInts(20)
			Maniac_Debug.addStoredFloats(15)
			maniacID = Maniac_Debug.getNumberOfRegisteredObjects()
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
	
	
	
	
	
	public
	Method Draw:Int()		
		Local draws:Int = 0
		If bVisible = False
			Return -1
		Endif 
		If Angle <> 0.0
			RotateAt(MidX,MidY, Angle)
		Endif
		
		
		'##### GLOW EFFECT STUFF #####
		If bGlow = True
			doGlowDraw()
		End If
		
		'##### BUTTON BACKGROUND #####
		If bOnClick_Darkening = True And bRunOnClickAnim = True 
			Maniac_Color(Color+7)
		Else
			Maniac_Color(Color)
		Endif 
		
		
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
		'
		'Check for Button Style
		Select ButtonStyle
			Case BUTTON_STYLE_STD
				If bWithImage = False 
					DrawRect(MidX- (Width +AddWidthByMO/2)/2,MidY-(Height+AddHeightByMO/2)/2,Width+AddWidthByMO,Height+AddHeightByMO)
				Else 
					'DrawImage MANIAC_IMG_BACKGROUND, MidX- (Width +AddWidthByMO/2)/2,MidY-(Height+AddHeightByMO/2)/2,0,(Width+AddWidthByMO)/MANIAC_IMG_BACKGROUND.Width(),(Height+AddHeightByMO)/MANIAC_IMG_BACKGROUND.Height()
				Endif 
				
				If bFramed = True
					Maniac_Color(FrameColor)
					Drw_Rect(MidX- (Width +AddWidthByMO/2)/2,MidY-(Height+AddHeightByMO/2)/2,Width+AddWidthByMO,Height+AddHeightByMO,3)
				Endif 
				'draws += 1
			Case BUTTON_STYLE_MODERN
				DrawImage ManiacImg[IMG_STYLE_MODERN_BACKGROUND], MidX,MidY,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_MODERN_BACKGROUND].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_MODERN_BACKGROUND].Height()
				If bFramed = True
					Maniac_Color(FrameColor)
					DrawImage ManiacImg[IMG_STYLE_MODERN_FRAME], MidX,MidY,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_MODERN_FRAME].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_MODERN_FRAME].Height()
				Endif
				
			Case BUTTON_STYLE_ROUND
				DrawImage ManiacImg[IMG_STYLE_ROUND_BACKGROUND], MidX,MidY,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_ROUND_BACKGROUND].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_ROUND_BACKGROUND].Height()
				If bFramed = True
					Maniac_Color(FrameColor)
					DrawImage ManiacImg[IMG_STYLE_ROUND_FRAME], MidX,MidY,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_ROUND_FRAME].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_ROUND_FRAME].Height()
				Endif
			Case BUTTON_STYLE_CIRCLE
				DrawImage ManiacImg[IMG_STYLE_CIRCLE_BACKGROUND], MidX,MidY,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_CIRCLE_BACKGROUND].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_CIRCLE_BACKGROUND].Height()
				If bFramed = True
					Maniac_Color(FrameColor)
					DrawImage ManiacImg[IMG_STYLE_CIRCLE_FRAME], MidX,MidY,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_CIRCLE_FRAME].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_CIRCLE_FRAME].Height()
				Endif
		End Select 		
		 
		'##### DRAWING THE CAPTION TO THE BUTTON #####
		SetAlpha 1
		Maniac_Color(CaptionColor)
		Drw_ManiacText(Caption,MidX-Width/2,MidY-Height/2,Width,Height,Alignment)

		
		If bTransparent = False
			If bMO = True 
				If bMOBrighter = True 
					SetAlpha 0.2
					SetColor 255,255,255
					DrawRect(MidX- (Width +AddWidthByMO/2)/2,MidY-(Height+AddHeightByMO/2)/2,Width+AddWidthByMO,Height+AddHeightByMO)
					'Maniac_Debug.addTotDraws(1)
					draws += 1
				Endif 
			Else
				'SetAlpha 0.6
			Endif 
			
		Endif 
		
		
		'### Reset The MAtrix
		If Angle <> 0.0
			ResetMatrix()
		Endif 
		
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
			Maniac_Debug.addRenderedObject()
			Maniac_Debug.addTotDraws(draws)
		Endif
	End Method 
	
	Method Update:Int()
		If MANIAC_DEBUG = True
			Maniac_Debug.addCall()
		Endif  
		
		'### Updating Glow Effect ###
		'this will have effect to all Animation & Non Animation stuff.
		If bGlow = True 
			doGlowUpdate()
		Endif 
		
		
		'### Animation Effects ###
		If bRunningAnimation = True
			 doAnimUpdate()
		Endif 
		
		'### OnClick-Animations ###
		If bOnClickAnim = True And bRunOnClickAnim = true
			doOnClickAnim()
		Endif 
		
		
		'### User Input Stuff like MouseOver, ClickOn etc. ###
		If MOBox(MidX-Width/2	, MidY-Height/2, Width, Height)
			bMO = True 
			If bMOWobble = True
				doWobble()
			Endif 
			If TouchHit()
				If GLOBAL_SOUNDON = True And bSound = True 
					'PlaySound(MANIAC_SND_SLIDE3)
				Endif
				'Print "Clicked"
				If bOnClickAnim = True
					OnClickedAnimStartTime = Millisecs()
					bRunOnClickAnim = True 
					
					'### Start Spinning Animation
					If bOnClick_Spinning = True		
						startAnimRotate(1000,1,"Back","InOut")
					Endif 
				Endif 
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
	
	
	#rem monkeydoc
		This Method starts an "Falling-Down" Animation to the Origin!.~n
		_fromY << needs a Float from where to fall
		_AnimTime << needs a Int, it's the duration-time in ms for the animation
	#end
	Method startAnimDrop(_fromY:Float,_AnimTime:Int = 1500,_Style:String = "Bounce",_Ease:String = "Out")
		tweenY = ll_Tween(_Style,_Ease,_fromY,oY,_AnimTime )
		tweenY.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = ANIM_DROP
	End Method 
	
	
	#rem monkeydoc
		This Method starts an "Falling-Down" Animation from the Origin!.~n
		_fromY << needs a Float to where to fall~n
		_AnimTime << needs a Int, it's the duration-time in ms for the animation~n
	#end
	Method endAnimDrop(_toY:Float,_AnimTime:Int = 1500,_Style:String = "Bounce",_Ease:String = "InOut")
		tweenY = ll_Tween(_Style,_Ease,oY,_toY,_AnimTime )
		tweenY.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = ANIM_DROP
	End Method 
	
	
	Method startAnimRoll:Void(_fromX:Float,_AnimTime:Int = 3000,_NumberRounds:Float = 10,_Style:String = "Back",_Ease:String = "Out")
		tweenX = ll_Tween(_Style,_Ease,_fromX,oX,_AnimTime )
		tweenX.Start()
		tweenAngle = ll_Tween(_Style,_Ease,_NumberRounds*(360),0,_AnimTime )
		tweenAngle.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = ANIM_ROLL
	End Method 
	
	
	Method endAnimRoll:Void(_toX:Float,_AnimTime:Int = 3000,_NumberRounds:Float = 10,_Style:String = "Back",_Ease:String = "Out")
		tweenX = ll_Tween(_Style,_Ease,oX,_toX,_AnimTime )
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
	
	
	Method endAnimSlide(_toX:Float,_AnimTime:Int = 1500,_Style:String = "Back",_Ease:String = "InOut")
		tweenX = ll_Tween(_Style,_Ease,oX,_toX,_AnimTime )
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
	
	
	'BUG:  It won't PopUp when its size is 0 ... 
	Method endAnimPopOut(_AnimTime:Int = 1500,_Style:String = "Back",_Ease:String = "Out")
		tweenX = ll_Tween(_Style,_Ease,oWidth,0,_AnimTime )
		tweenX.Start()
		tweenY = ll_Tween(_Style,_Ease,oHeight,0,_AnimTime )
		tweenY.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = ANIM_POPOUT
	End Method
	
	
	Method startAnimRotate(_AnimTime:Int = 3000,_NumberRounds:Float = 10,_Style:String = "Back",_Ease:String = "Out")
		tweenAngle = ll_Tween(_Style,_Ease,_NumberRounds*(360),0,_AnimTime )
		tweenAngle.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = ANIM_ROTATE
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
				'Print "Alignment doesnt exist, Set To Middle!!!"
				Alignment =	ALIGNMENT_MIDDLE
		End Select
	End Method 
	
	
	Method setCaption(_Caption:String,_Color:Int = COLOR_WHITE)
		Caption = _Caption
		CaptionColor = _Color
	End Method 
	
	
	Method setPosition(_X:float,_Y:float)
		MidX = _X
		MidY = _Y
	End Method 
	
	
	Method setOrigPosition(_X:Float,_Y:Float)
		oX = _X
		oY = _Y
	End Method 
	
	
	Method setSize(_Width:Float,_Height:Float)
		Width = _Width
		Height =_Height
	End Method 
	
	
	Method setOrigSize(_Width:Float,_Height:Float)
		oWidth = _Width
		oHeight =_Height
	End Method
	
	Method setColors:Void(_MainColor:Int = -1, _FrameColor:Int = -1, _CaptionColor:Int = -1)
	
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
	
	
	Method setMouseOverEffects(_isResizing:Bool= True ,_isBrightening:Bool=False,_isWobbling:Bool = false )
		bMOResize		= _isResizing
		bMOBrighter		= _isBrightening
		bMOWobble		= _isWobbling
	End Method 
	
	
	Method setMouseOnClickAnim(_isOnClickEffect:Bool = True, _isSoundOn:Bool = True ,_isDarkening:Bool = True,_isSpinning:Bool = false)
		bOnClickAnim = _isOnClickEffect
		
		'Checking for different types
		bOnClick_Spinning  = _isSpinning
		bOnClick_Darkening = _isDarkening
		bOnClick_PlaySound = _isSoundOn
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
	
	
	Method setVisible(_Bool:Bool)
		bVisible = _Bool
	End Method 
	
	
	#rem monkeydoc
		Style can be one of the following Const Int:~n
		const BUTTON_STYLE_RECTSTD:Int 	= 0~n
		Const BUTTON_STYLE_RECT2:Int 	= 1~n
		Const BUTTON_STYLE_ROUND1:Int 	= 2~n
		Const BUTTON_STYLE_ROUND2:Int 	= 3~n
		Const BUTTON_STYLE_ROUND3:int   = 4~n
	#end 
	Method setStyle:Void(_Style:Int)
		ButtonStyle = _Style
	End Method 
	
	
	Method setSound:Void(_Bool:Bool)
		bSound = _Bool
	End Method 
	
	
	Method setBackground:Void(_Color:Int,_WithImage:Bool= False ,_Image:Image=Null)
		Color = _Color
		bWithImage = _WithImage
		'ImgBackground = _Image
	End Method 
	
	Private 
	Method doGlowUpdate:Void()
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
	End Method 
	
	
	Method doGlowDraw:Void()
		Maniac_Color(GlowColor)
		SetAlpha GlowAlpha
		'DrawImage MANIAC_IMG_FRAME_BLUR, MidX,MidY,0,Width*GlowRangeRatioX/MANIAC_IMG_FRAME_BLUR.Width(),Height*GlowRangeRatioY/MANIAC_IMG_FRAME_BLUR.Height()
		'Maniac_Debug.addTotDraws(1)
		'draws += 1
	End Method
	
	Method doOnClickAnim:Void()
		If Millisecs() - OnClickedAnimStartTime > AnimTime
			bRunOnClickAnim = False
			bOnClickAnim = True  
		Endif
	End Method 
	
	
	Method doAnimUpdate:Void()
		'Check if AnimationTime is Over
		If Millisecs() - AnimStartTime > AnimTime
			bRunningAnimation = False 
			setSize(oWidth,oHeight)
			'Print "W/H: " + oWidth + ":"+oHeight  
		Endif
			
			
		'If not, calculate the next Position Stuff
		Select AnimEffect
			Case ANIM_DROP
				tweenY.Update()
				MidY = tweenY.Value()
			Case ANIM_FADE
			Case ANIM_ROTATE
				tweenAngle.Update()
				Angle = tweenAngle.Value()
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
	
	
	#rem
		### This Method is deprecated!!! Please don't use it in Future. Use startAnimRoll instead It's just for backward compatibatibility ####
	#end 
	Method doRoll(_AngleSpeed:Float)
		If MANIAC_DEBUG = True
			'Maniac_Debug.addCalc()
			Maniac_Debug.addCall()
		Endif
		Angle += EqToFPS(_AngleSpeed)
	End Method
	
	
	Method doRotate(_AngleSpeed:Float)
		If MANIAC_DEBUG = True
			Maniac_Debug.addCall()
		Endif
		Angle += EqToFPS(_AngleSpeed)
	End Method
	
	Method getID:Int()
		Return ID
	End Method 
	
	Method setID:Void(_ID:Int)
		ID = _ID
	End Method 
End Class 
