#Rem monkeydoc Module maniac.gui.maniacGuiBase
	Gui-Base Module - Version 1.0 (alpha)  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	~n
	All Gui_Objects will be extended by GuiBase~n
	It brings with some Anim,ColorScheme & stuff feature.~n
	
	
#End
Import maniac

Const BASE_DISPOSE_NORTH:Int		= 0
Const BASE_DISPOSE_EAST:Int			= 1
Const BASE_DISPOSE_WEST:Int			= 2
Const BASE_DISPOSE_SOUTH:Int		= 3

Const DISPOSE_NORTH:Int			= 0
Const DISPOSE_EAST:Int			= 1
Const DISPOSE_SOUTH:Int			= 2
Const DISPOSE_WEST:Int 			= 3

Const GUIBASE_ANIM_DROP:Int 	= 361
Const GUIBASE_ANIM_FADE:Int 	= 362
Const GUIBASE_ANIM_ROTATE:Int 	= 363
Const GUIBASE_ANIM_ROLL:Int 	= 364
Const GUIBASE_ANIM_SLIDE:Int 	= 365
Const GUIBASE_ANIM_CIRCLE:Int 	= 366
Const GUIBASE_ANIM_POPOUT:Int 	= 367

Const GUIBASE_MOUSESTATE_MOUSEOVER:Int		= 310
Const GUIBASE_MOUSESTATE_ONCLICK:Int		= 320
Const GUIBASE_MOUSESTATE_ONMOUSEDOWN:Int	= 325
Const GUIBASE_MOUSESTATE_ONLEAVE:Int		= 330
Const GUIBASE_MOUSESTATE_ONENDANIM:Int		= 340
Const GUIBASE_ANIMUPDATE_STATE_END:Int		= 350
Const GUIBASE_ANIMUPDATE_STATE_IDLE:Int		= -1
Const GUIBASE_ANIMUPDATE_STATE_RUNNING:Int	= 351

Const MANIAC_GUIBASE_STYLE_PLAIN:Int 	= 0
Const MANIAC_GUIBASE_STYLE_STANDARD:Int = 1
Const MANIAC_GUIBASE_STYLE_ROUND:Int 	= 2
Const MANIAC_GUIBASE_STYLE_MODERN:Int 	= 3
Const MANIAC_GUIBASE_STYLE_MODERN2:Int 	= 4
Const MANIAC_GUIBASE_STYLE_CIRCLE:Int 	= 5


#rem
	Schema: Ein Schema is ein Konzept eines Sachverhalts.
			Merkmale der Ausführung

#end 
Class cGuiBase

	private
	'Coordinates
	Field mID:Int 
	Field X:Float,Y:Float,oX:Float,oY:Float							'X,Y - Current Position ; oX,oY - original Position, this is the Position, where the Element should be shown, after an animation
	Field Width:Float,Height:Float,oWidth:Float,oHeight:Float 		'Width,Height - current Size ; oWidth,oHeight - see X & Y
	
	#rem
		Global Data
	#end 
	Field Angle:Float		= 0.0
	Field oAngle:Float 		
	Field Alpha:Float 		= 1.0
	Field Scale:Float 		= 1.0
	Field bSelected:Bool					'If true, the MouseCursor is over the Gui Element
	Field bActivated:Bool 					'If true, the Gui Element was clicked and is still 
	Field bRunningAnimation:Bool			'If true, The Gui Element will perform a specific Animation
	Field bVisible:Bool				= True 
	Field bMO:Bool			= False 
'	Field bActivated:Bool  	= False 
	Field AddWidthByMO:Int 		= 0
	Field AddHeightByMO:Int		= 0
	
	Field Style:Int 	
	
	#rem
		BEHAVIOUR STATES
		
	#end
	Field act_OnClickAnim:Bool 					'if True, it will start an animation, els
	Field act_OnMouseOverWobble:Bool 
	Field bRunOnClickAnim:Bool
	
	Field doSpinning:Bool 
	
	Field OnClickedAnimStartTime:Int 
	
			
	#rem	############### TITLE DATA ###################
		Title Datas.
		A Title will be shown next to the Gui Element.
		It can be placed "North,East,West,South"
	#end
	Field Title:String 						'Title; this will be Shown Outside the GUI Element // Should be descriptive like 
	Field bTitled:Bool 						'If true, the Title will be Shown, else it won't
	Field TitleDispose:Int					' 1-North,2-East,3-South,4-West
	Field TitleAlignX:Int,TitleAlignY:Int 	
	Field TitleColor:int
	
	
	#rem ################ TEXT DATA ###################
		Text Datas.
		A Text will be shown within the Width/Height.
	#end
	Field Text:String 						'Text within the GUI Element
	Field TextAlignX:Int,TextAlignY:Int 	'
	Field bTextWrapToSize:Bool 				'If True, the Text will be Resized to Width/Height
	Field TextColor_Unselected:Int
	Field TextColor_Selected:Int
	Field TextColor_Activated:Int 
	Field TextScale:Float = 1.0

	#rem ############### BACKGROUND DATA ##############
	
	#end
	Field Color_BG_Selected:Int
	Field Color_BG_Unselected:Int 
	Field Color_BG_Activated:Int
	Field BG_Style:Int  
	
	Field bShowBGRect:Bool
	Field RectColor:Int 
	Field RectX:Float,RectY:Float,RectWidth:Float,RectHeight:Float 
	
	
	
	#rem ############### FRAME DATA ###################
		The Frame will be shown around the Gui Element
	#end
	Field bFramed:Bool 		= True  
	Field FrameType:Int 	= 0
	Field FrameThickness:Int = 1
	Field Color_Glow:Int 
	Field Color_Frame:Int 
	Field Color_Frame_Activated:Int			'Depricated in Version 1.0		// will be deleted in Version 1.1
	Field Color_Frame_Unselected:Int		'Depricated in Version 1.0		// will be deleted in Version 1.1
	Field Color_Frame_Selected:Int 			'Depricated in Version 1.0		// will be deleted in Version 1.1
	
	Field FrameColor_Activated:Int
	Field FrameColor_Selected:Int
	Field FrameColor_Unselected:Int 
	
	
	'##### ANIMATION STUFF #####
	'Field bRunningAnimation:Bool 	= False 
	Field AnimStartTime:int		
	Field AnimTime:Int
	Field AnimEffect:Int
	
	'Tweener for position Stuff
	Field tweenY:Tween
	Field tweenX:Tween
	Field tweenAngle:Tween
	Field tweenAlpha:Tween
	Field tweenScale:Tween
	
	Field bBlink:Bool 		= False 
	Field bCurrBlinkDirection:Bool = True 
	Field BlinkHertz:Float = 1.5
	Field BlinkAlphaFrom:Float
	Field BlinkAlphaTo:Float 
	
	
	public
	
	Method updateBase:Int() Final 
		If bVisible = False
			Return
		Endif 
		'### Animation Effects ###
		If bRunningAnimation = True
			If doAnimUpdate() = GUIBASE_ANIMUPDATE_STATE_END And bRunOnClickAnim = True
				'Print "anim_end: " + GUIBASE_ANIMUPDATE_STATE_END
				Return GUIBASE_ANIMUPDATE_STATE_END
			End If 
			
			
		Endif
		
		If bBlink = True
			doUpdateBlink()
		Endif 
		
		'### User Input Stuff like MouseOver, ClickOn etc. ###
		If MOBox(X-Width/2	, Y-Height/2, Width, Height)
			bMO = True 
			'If bMOWobble = True
				'doWobble()
			'Endif 
			If TouchHit()
				'If GLOBAL_SOUNDON = True And bSound = True 
					'PlaySound(MANIAC_SND_SLIDE3)
				'Endif
				'Print "Clicked"
				If act_OnClickAnim = True
					OnClickedAnimStartTime = Millisecs()
					bRunOnClickAnim = True 
					
					'### Start Spinning Animation
					If doSpinning = True		
						startAnimRotate(1000,1,"Back","InOut")
					Endif 
				Endif 
				Return GUIBASE_MOUSESTATE_ONCLICK
			Endif 
			Return GUIBASE_MOUSESTATE_MOUSEOVER		'Return that there's just a MouseOver
			
		Else
			bMO = False 
			If bRunningAnimation = False
				resetPosition()
			Endif 
		Endif
	End Method 
	
	Method drawBase:Void() Final 
		If bVisible = False
			Return
		Endif 
	
		'If Angle <> 0.0
		RotateAt(X,Y, Angle)
		'Endif
		
		#rem
			##### GLOW EFFECT STUFF #####
		#end 
		 
		'doDrawGlow()
		
		doDrawBackground()
		 
		doDrawFrame()
		
		doDrawText()
		
		doDrawTitle()
		
		
		ResetMatrix()
	End Method 
	
	
	#rem	####################### SETTER METHODS ##############################
	
	#end 
	Public
	
	Method getX:Float()
		Return X
	End Method
	
	Method getY:Float()
		Return Y
	End Method 
	Method getWidth:Float()
		Return Width
	End Method
	
	Method getHeight:Float()
		Return Height
	End Method 
	Method getoX:Float()
		Return oX
	End Method
	
	Method getoY:Float()
		Return oY
	End Method 
	Method getoWidth:Float()
		Return oWidth
	End Method
	
	Method getoHeight:Float()
		Return oHeight
	End Method 
	
	Method getAngle:Float()
		Return Angle
	End Method 
	Method getAlpha:Float()
		Return Alpha
	End Method 
	
	Method getbMO:Bool()
		Return bMO
	End Method 
	
	Method getVisible:Bool()
		Return bVisible
	End Method 
	Method setID:Void(_ID:Int)
		mID = _ID
	End Method 
	
	Method getID:Int()
		Return mID
	End Method 
	
	Method getText:String()
		Return Text
	End Method 
	
	Method setAlpha(_Alpha:Float)
		Alpha = _Alpha
	End Method
	Method setAngle:Void(_Angle:Float)
		Angle = _Angle
		oAngle = _Angle
	End Method 
	Method setBlink:Void(_Bool:Bool)
		bBlink = _Bool 
		
		If _Bool = False
			Alpha = 1
		Endif 
	End Method 
	
	Method setBlinkRange:Void(_BlinkFromAlpha:Float = 0.2,_BlinkToAlpha:Float = 1.0)
		Alpha = _BlinkFromAlpha
		BlinkAlphaFrom 	= _BlinkFromAlpha
		BlinkAlphaTo 	= _BlinkToAlpha
	End Method
	
	
	Method setBlinkHertz:Void(_Hertz:Float)
		BlinkHertz = _Hertz
	End Method
	#rem
		This Setter configs the OnClick Behaviour.
		_activated:Bool << True if you want to use onClickAnimations
		_isSpinning << set true, if you want to make this element Spinning, when the user clicked at it.
	#end
	Method setOnClickAction:Void(_activated:Bool, _isSpinning:Bool = True )
		act_OnClickAnim = _activated
		doSpinning = _isSpinning
	End Method
	
	Method setColor_Title:Void(_ColorTitle:Int)
		TitleColor = _ColorTitle
	End Method 
	
	Method setColor_Text:Void(_ColorUnselected:Int,_ColorSelected:Int,_ColorActivated:Int = 0)
		'Color_Text_Unselected = _ColorUnselected
		'Color_Text_Selected = _ColorSelected
		
		TextColor_Unselected 	= _ColorUnselected
		TextColor_Selected		= _ColorSelected
		TextColor_Activated		= _ColorActivated
	End Method 
	'Method setFrame
	#rem monkeydoc
		This Method sets the Backgroundcolor of a GuiBase-Element.
		The params are Ints. The Color-Consts to use, you can find in the Link Section.
		Links: [[maniac.maniacGraphics]]
	#end
	Method setColor_Frame:Void(_ColorUnselected:Int,_ColorSelected:Int,_ColorActivated:Int)
		Color_Frame 				= _ColorUnselected			'#Depricated since 1.0 will be deleted latest on Ver. 1.1
		Color_Frame_Activated		= _ColorActivated
		Color_Frame_Unselected		= _ColorUnselected
		Color_Frame_Selected		= _ColorSelected
	End Method
	
	
	#rem monkeydoc
		This Method sets the Backgroundcolor of a GuiBase-Element.
		The params are Ints. The Color-Consts to use, you can find in the Link Section.
		Links: [[maniac.maniacGraphics]]
	#end
	Method setColor_Glow:Void(_Color:Int)
		Color_Glow = _Color
	End Method 
	
	
	#rem monkeydoc
		This Method sets the Backgroundcolor of a GuiBase-Element.
		The params are Ints. The Color-Consts to use, you can find in the Link Section.
		Links: [[maniac.maniacGraphics]]
	#end 
	Method setColor_BG:Void(_ColorUnselected:Int,_ColorSelected:Int,_ColorActivated:Int)
		Color_BG_Unselected	= _ColorUnselected
		Color_BG_Selected	= _ColorSelected
		Color_BG_Activated	= _ColorActivated
	End Method 
	
	#rem monkeydoc
		This Method sets up the Position & Size of Gui Base, and the original Position & Size
	#end
	Method setGeo(_X:Float,_Y:Float,_Width:Float,_Height:Float)
		X		= _X
		oX 		= _X
		Y 		= _Y
		oY 		= _Y
		Width 	= _Width
		oWidth 	= _Width
		Height 	= _Height
		oHeight = _Height
	End Method 
	
	Method setPosition(_X:float,_Y:float)
		X = _X
		Y = _Y
	End Method 
	Method setOrigPosition(_X:Float,_Y:Float)
		oX = _X
		oY = _Y
	End Method
	
	#rem monkeydoc
		Set the current Size of the Button in Pixel.
	#end
	Method setSize(_Width:Float,_Height:Float)
		Width = _Width
		Height =_Height
	End Method 
	
	
	#rem monkeydoc
		Set the original Size of the Button in Pixel.~n
		This values are needed for Resize-Effect, so the Button can auto-resize to the original Size after an effect has ended.
	#end
	Method setOrigSize(_Width:Float,_Height:Float)
		oWidth = _Width
		oHeight =_Height
	End Method
	#rem monkeydoc
		Sets the Current Title String, and Dispose ~n
		Params: _text:String << Text which will be shown
				_Dispose << Sets the Position in relation to the GuiBase Element; can be one of these: BASE_DISPOSE_NORTH,BASE_DISPOSE_EAST,BASE_DISPOSE_WEST,BASE_DISPOSE_SOUTH
	#end
	Method setTitle:Void(_text:String,_Dispose:Int = BASE_DISPOSE_NORTH)
		Title = _text
		TitleDispose = _Dispose
	End Method 
	
	
	#rem monkeydoc
		Sets the Current shown Text within the Base Element.~n
		Params: _text:String~n
				_TextAlignX:int << sets the Align of text in Horizontal~n
				_TextAlignY:int << sets the Align of Text in Vertical~n
	#end 
	Method setText:Void(_text:String,_TextAlignX:Int = ALIGNMENT_MIDDLE,_TextAlignY:Int =ALIGNMENT_MIDDLEY )
		Text = _text
		TextAlignX = _TextAlignX
		TextAlignY = _TextAlignY
	End Method
	
	Method setTextScale:Void(_Scale:Float)
		TextScale = _Scale
	End Method 
	
	Method setStyle(_Style:Int)
		Print "SetBtnStyle: " + _Style
		Style = _Style
		BG_Style = _Style
	End Method
	
	Method setBGStyle(_Style:Int)
		BG_Style = _Style
	End Method 
	
	Method setBGRect(_pX:Float,_pY:Float,_pW:Float,_pH:Float,_Color:Int)
		bShowBGRect = True 
		RectColor = _Color 
		RectX = X + _pX*Width - Width*0.5
		RectY = Y + _pY*Height - Height*0.5
		RectWidth = _pW*Width
		RectHeight = _pH*Height
	End Method 
	
	
	#rem monkeydoc
		set the current visibility. if True, this element will be shown, else not.
	#end 
	Method setVisible:Void(_visible:Bool)
		bVisible = _visible
	End Method
	
	Method setWrapTextToSize:Void(_Bool:Bool)
		bTextWrapToSize = _Bool
	End Method
	
	Method getColor_BG_Unselected:int()
		Return Color_BG_Unselected
	End method
	Method showFrame:Void()
		bFramed = True 
	End Method
	
	Method hideFrame:Void()
		bFramed = False
	End Method 
	#rem monkeydoc
		This Method starts a horizontally SlideAnimation.
		
		typically usecase: If you have a Game with different States, you may like to animate them when switching~n
		the GameStates. You may call one of the startAnims within the onEnter() onLeave() methods.
	#end 
	Method startAnimSlide(_fromX:Float,_AnimTime:Int = 1500,_Style:String = "Back",_Ease:String = "Out")
		'initing tweener
		tweenX = ll_Tween(_Style,_Ease,_fromX,oX,_AnimTime )
		tweenX.Start()
		'set runningAnimation State to true, so it will calculated
		bRunningAnimation = True 
		AnimEffect = GUIBASE_ANIM_SLIDE
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		
	End Method
	
	#rem monkeydoc
		This Method starts an "Falling-Down" Animation to the Origin!.~n
		_fromY << needs a Float from where to fall
		_AnimTime << needs a Int, it's the duration-time in ms for the animation
	#end
	Method startAnimDrop(_fromY:Float,_AnimTime:Int = 1500,_Style:String = "Back",_Ease:String = "Out")
		tweenY = ll_Tween(_Style,_Ease,_fromY,oY,_AnimTime )
		tweenY.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = GUIBASE_ANIM_DROP
	End Method


	Method startAnimRoll:Void(_fromX:Float,_AnimTime:Int = 3000,_NumberRounds:Float = 10,_Style:String = "Back",_Ease:String = "Out")
		tweenX = ll_Tween(_Style,_Ease,_fromX,oX,_AnimTime )
		tweenX.Start()
		tweenAngle = ll_Tween(_Style,_Ease,_NumberRounds*(360),0,_AnimTime )
		tweenAngle.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = GUIBASE_ANIM_ROLL
	End Method
	
	
	Method startAnimRotate(_AnimTime:Int = 3000,_NumberRounds:Float = 10,_Style:String = "Back",_Ease:String = "Out")
		tweenAngle = ll_Tween(_Style,_Ease,oAngle + _NumberRounds*(360),0,_AnimTime )
		tweenAngle.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = GUIBASE_ANIM_ROTATE
	End Method
	
	
	Method startAnimPopOut(_AnimTime:Int = 1000,_Style:String = "Back",_Ease:String ="Out")
		tweenX = ll_Tween(_Style,_Ease,0,oWidth,_AnimTime )
		tweenX.Start()
		tweenY = ll_Tween(_Style,_Ease,0,oHeight,_AnimTime )
		tweenY.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = GUIBASE_ANIM_POPOUT
	End Method 
	
	Method startAnimPopIn(_AnimTime:Int = 1000,_Style:String = "Back",_Ease:String ="Out")
		tweenX = ll_Tween(_Style,_Ease,DW*1.1,oWidth,_AnimTime )
		tweenX.Start()
		tweenY = ll_Tween(_Style,_Ease,DH*1.1,oHeight,_AnimTime )
		tweenY.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = GUIBASE_ANIM_POPOUT
	End Method 
	Private 
	#rem monkeydoc
	#end 
	Method doAnimUpdate:Int()
		'Check if AnimationTime is Over.
		'Then it will Return Guibase-End-State
		If Millisecs() - AnimStartTime > AnimTime
			bRunningAnimation = False 
			setSize(oWidth,oHeight) 
			Return GUIBASE_ANIMUPDATE_STATE_END
		Endif
			
		
		'If not, calculate the next Position Stuff
		Select AnimEffect
			Case GUIBASE_ANIM_DROP
				tweenY.Update()
				Y = tweenY.Value()
				Return GUIBASE_ANIMUPDATE_STATE_RUNNING
				
			Case GUIBASE_ANIM_FADE
				tweenAlpha.Update()
				Alpha = tweenAlpha.Value()/100.0
				Return GUIBASE_ANIMUPDATE_STATE_RUNNING
				
			Case GUIBASE_ANIM_ROTATE
				tweenAngle.Update()
				Angle = tweenAngle.Value()
				Return GUIBASE_ANIMUPDATE_STATE_RUNNING
				
			Case GUIBASE_ANIM_ROLL
				tweenX.Update()
				tweenAngle.Update()
				Angle = tweenAngle.Value()
				X = tweenX.Value()
				Return GUIBASE_ANIMUPDATE_STATE_RUNNING
				
			Case GUIBASE_ANIM_SLIDE
				tweenX.Update()
				X = tweenX.Value()
				Return GUIBASE_ANIMUPDATE_STATE_RUNNING
				
			Case GUIBASE_ANIM_CIRCLE
				tweenY.Update()
				tweenX.Update()
				X = tweenX.Value()
				Y = tweenY.Value()
				Return GUIBASE_ANIMUPDATE_STATE_RUNNING
				
			Case GUIBASE_ANIM_POPOUT
				tweenX.Update()
				tweenY.Update()
				setSize(tweenX.Value(),tweenY.Value())
				Return GUIBASE_ANIMUPDATE_STATE_RUNNING	
		End Select
		
		Return GUIBASE_ANIMUPDATE_STATE_IDLE
	End Method 
	
	Method doUpdateBlink()
		If bCurrBlinkDirection = True
			Alpha += EqToFPS(BlinkHertz)
			If Alpha >= BlinkAlphaTo
				bCurrBlinkDirection = False
			Endif 
		Else
			Alpha -= EqToFPS(BlinkHertz)
			If Alpha <= BlinkAlphaFrom
				bCurrBlinkDirection = true
			Endif 
		Endif
	End Method
	Method doDrawGlow:Void()
		If bGlow = True
			
		End If
	End Method 
	
	
	Method doDrawBackground:Void()
		#rem
			1. Step, SET THE TRANSPERENTY 
		#end 
		SetAlpha Alpha
		
		
		#rem
			1. Step, SET THE COLOR TO THE BACKGROUND
		#end
		If bMO = True
			Maniac_Color(Color_BG_Selected)
		Else
			Maniac_Color(Color_BG_Unselected)
			If bActivated = True
				Maniac_Color(Color_BG_Activated)
			Endif
		Endif

		'
		'Check for GuiBase Style
		Select BG_Style
			Case MANIAC_GUIBASE_STYLE_PLAIN
				DrawRect(X- (Width +AddWidthByMO/2)/2,Y-(Height+AddHeightByMO/2)/2,Width+AddWidthByMO,Height+AddHeightByMO)
				
			Case MANIAC_GUIBASE_STYLE_STANDARD
				DrawImage ManiacImg[IMG_BACKGROUND],X,Y,0,Width/ManiacImg[IMG_BACKGROUND].Width,Height/ManiacImg[IMG_BACKGROUND].Height() 
	
			Case MANIAC_GUIBASE_STYLE_ROUND 
				DrawImage ManiacImg[IMG_STYLE_ROUND_BACKGROUND], X,Y,0,( (Width+AddWidthByMO)/ManiacImg[IMG_STYLE_ROUND_BACKGROUND].Width() )*Scale,((Height+AddHeightByMO)/ManiacImg[IMG_STYLE_ROUND_BACKGROUND].Height() )*Scale
				
			Case MANIAC_GUIBASE_STYLE_MODERN
				DrawImage ManiacImg[IMG_STYLE_MODERN_BACKGROUND], X,Y,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_MODERN_BACKGROUND].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_MODERN_BACKGROUND].Height()
			
			Case MANIAC_GUIBASE_STYLE_MODERN2
				DrawImage ManiacImg[IMG_STYLE_MODERN2_BACKGROUND], X,Y,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_MODERN2_BACKGROUND].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_MODERN2_BACKGROUND].Height()
			
			Case MANIAC_GUIBASE_STYLE_CIRCLE
				DrawImage ManiacImg[IMG_STYLE_CIRCLE_BACKGROUND], X,Y,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_CIRCLE_BACKGROUND].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_CIRCLE_BACKGROUND].Height()
			#rem
			Case MANIAC_STYLE_MODERN
				DrawImage ManiacImg[IMG_STYLE_MODERN_BACKGROUND], X,Y,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_MODERN_BACKGROUND].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_MODERN_BACKGROUND].Height()
				If bFramed = True
					
					Maniac_Color(Color_Frame)
					If bActivated = True
						Maniac_Color(Color_BG_Activated)
					Endif
					DrawImage ManiacImg[IMG_STYLE_MODERN_FRAME], X,Y,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_MODERN_FRAME].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_MODERN_FRAME].Height()
				Endif
					
			Case MANIAC_STYLE_ROUND
				DrawImage ManiacImg[IMG_STYLE_ROUND_BACKGROUND], X,Y,0,( (Width+AddWidthByMO)/ManiacImg[IMG_STYLE_ROUND_BACKGROUND].Width() )*Scale,((Height+AddHeightByMO)/ManiacImg[IMG_STYLE_ROUND_BACKGROUND].Height() )*Scale
				If bFramed = True
					Maniac_Color(Color_Frame)
					DrawImage ManiacImg[IMG_STYLE_ROUND_FRAME], X,Y,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_ROUND_FRAME].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_ROUND_FRAME].Height()
				Endif
			Case MANIAC_STYLE_CIRCLE
				DrawImage ManiacImg[IMG_STYLE_CIRCLE_BACKGROUND], X,Y,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_CIRCLE_BACKGROUND].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_CIRCLE_BACKGROUND].Height()
				If bFramed = True
					Maniac_Color(Color_Frame)
					DrawImage ManiacImg[IMG_STYLE_CIRCLE_FRAME], X,Y,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_CIRCLE_FRAME].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_CIRCLE_FRAME].Height()
				Endif
					
			Case MANIAC_STYLE_MODERN2
					DrawImage ManiacImg[IMG_STYLE_MODERN2_BACKGROUND], X,Y,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_MODERN2_BACKGROUND].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_MODERN2_BACKGROUND].Height()
					If bFramed = True
						If bMO = True
							Maniac_Color(Color_Frame_Selected)
						Else
							Maniac_Color(Color_Frame_Unselected)
						Endif
						DrawImage ManiacImg[IMG_STYLE_MODERN2_FRAME], X,Y,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_MODERN2_FRAME].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_MODERN2_FRAME].Height()
					Endif
				
			Default 
			#end 
		End Select 	
		
		If bShowBGRect = True  
			Maniac_Color(RectColor)
			DrawRect(RectX,RectY,RectWidth,RectHeight) 
		Endif 	
	End Method 
	
	
	Method doDrawFrame:Void()
		If bFramed = True
			Select Style
				Case MANIAC_GUIBASE_STYLE_PLAIN
				Case MANIAC_GUIBASE_STYLE_STANDARD
				
					Maniac_Color(Color_Frame)
					
					If bMO = True
						Maniac_Color(Color_Frame_Selected)
					Else
						Maniac_Color(Color_Frame_Unselected)
						If bActivated = True
							Maniac_Color(Color_Frame_Activated)
						Endif
					Endif
					
					Drw_Rect(X- (Width +AddWidthByMO/2)/2,Y-(Height+AddHeightByMO/2)/2,Width+AddWidthByMO,Height+AddHeightByMO,3)
				 
			 
			
				Case MANIAC_GUIBASE_STYLE_ROUND 
					If bFramed = True
						If bMO = True
							Maniac_Color(Color_Frame_Selected)
						Else
							Maniac_Color(Color_Frame_Unselected)
						Endif
						DrawImage ManiacImg[IMG_STYLE_ROUND_FRAME], X,Y,0,( (Width+AddWidthByMO)/ManiacImg[IMG_STYLE_ROUND_FRAME].Width() )*Scale,((Height+AddHeightByMO)/ManiacImg[IMG_STYLE_ROUND_FRAME].Height() )*Scale
					Endif 
					
				Case MANIAC_GUIBASE_STYLE_MODERN
					DrawImage ManiacImg[IMG_STYLE_MODERN_FRAME], X,Y,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_MODERN_FRAME].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_MODERN_FRAME].Height()
				
				Case MANIAC_GUIBASE_STYLE_MODERN2
					DrawImage ManiacImg[IMG_STYLE_MODERN2_FRAME], X,Y,0,(Width+AddWidthByMO)/ManiacImg[IMG_STYLE_MODERN2_FRAME].Width(),(Height+AddHeightByMO)/ManiacImg[IMG_STYLE_MODERN2_FRAME].Height()
				
				Case MANIAC_GUIBASE_STYLE_CIRCLE
			End Select
		Endif 
	End Method 
	
	Method doDrawText:Void()
		'##### DRAWING THE CAPTION TO THE BUTTON #####
		SetAlpha 1
		'If bActive = True
			
		'Endif 
		If bMO = True
			Maniac_Color(TextColor_Selected)
		Else
			Maniac_Color(TextColor_Unselected)
		Endif 
		
		If bTextWrapToSize
			Drw_ManiacText(Text,X-Width/2,Y-Height/2,Width,Height,TextAlignX,TextAlignY,Width/15)
		Else 
			Drw_ManiacText(Text,X-Width/2,Y-Height/2,Width,Height,TextAlignX,TextAlignY,TextScale)
		Endif 
	End Method
	
	Method doDrawTitle:Void()
		If bTitled = True 
			'##### DRAWING THE CAPTION TO THE BUTTON #####
			SetAlpha 1
	
			Maniac_Color(TitleColor)
			Select TitleDispose
				'Case 
				
			End Select

			Drw_ManiacText(Title,X-Width/2,Y-Height/2-30,Width,Height,TextAlignX,TextAlignY)
		Endif 
	End Method 
	
	
	Method resetPosition()
		If MANIAC_DEBUG = True
			Maniac_Debug.addCall()
		Endif
		setPosition(getoX(),getoY())
		setAngle(oAngle)
		'Alpha = 1
	End Method
	
	Public
	Method isMO:Bool()
		Return bMO
	End Method 
	
	
	Method saveColorToFile(_file:FileStream)

		_file.WriteInt(TextColor_Unselected)
		_file.WriteInt(TextColor_Selected)
		_file.WriteInt(TextColor_Activated)
		_file.WriteInt(FrameColor_Activated)
		_file.WriteInt(FrameColor_Selected)
		_file.WriteInt(FrameColor_Unselected)
		_file.WriteInt(Color_BG_Selected)
		_file.WriteInt(Color_BG_Unselected)
		_file.WriteInt(Color_BG_Activated)
		_file.WriteInt(Color_Glow)
		
	End Method 
	
	Method loadColorFromFile(file:FileStream)
		TextColor_Unselected = file.ReadInt()
		TextColor_Selected	= file.ReadInt()
		TextColor_Activated	= file.ReadInt()
		FrameColor_Activated= file.ReadInt()
		FrameColor_Selected	= file.ReadInt()
		FrameColor_Unselected= file.ReadInt()
		Color_BG_Selected	= file.ReadInt()
		Color_BG_Unselected	= file.ReadInt()
		Color_BG_Activated	= file.ReadInt()
		Color_Glow			= file.ReadInt()
	End Method 
	
	Method saveGeoToFile(_file:FileStream)
		_file.WriteFloat(X)
		_file.WriteFloat(Y)
		_file.WriteFloat(Width)
		_file.WriteFloat(Height)
		_file.WriteFloat(oX)
		_file.WriteFloat(oY)
		_file.WriteFloat(oWidth)
		_file.WriteFloat(oHeight)
	End Method 
	
	Method loadGeoFromFile(_file:FileStream)
		X = _file.ReadFloat()
		Y =_file.ReadFloat()
		Width =_file.ReadFloat()
		Height =_file.ReadFloat()
		_file.WriteFloat(oX)
		_file.WriteFloat(oY)
		_file.WriteFloat(oWidth)
		_file.WriteFloat(oHeight)
	End Method 
End Class 
