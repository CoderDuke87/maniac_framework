#Rem monkeydoc Module maniac.maniacSimpleGUI
	Simple GUI - Version 0.1.4 (alpha)  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	
	Here You can find some GUI Elements to use for your App.
	They can be used 'ad-hoc'-like. the have to be managed by the Programmer.
	
#End

#rem
	Work On:
		DropDown,RadioGroup,FileExplorer,ListView for Version 0.1.5
		
		- need Color Scheme
		- need Graphics Update
		
		- Buglist:
			ManiacButton -> Rolling Animation is not Ready yet
	VERSION:~n
	0.1.4	- added: ManiacCheckBox,DropDown,ListView, Dialog
	0.1.3	- added a ImageGallery-Class >> ToDo: some imageLoading Bugfixes. UpdateEventAsync testing around ...
	
	0.1.2:	- bugfixes Frame
			- added some setter
			- added "doWobble","doRoll" (instantEffects)
			- added "startAnimDrop","startAnimSlide" and "startAnimCircle"
			- updated ManiacButton Class
			- added a Slider Class 
			
			
	Wishlist:
		 x Simple Button
		 x Textfield
		 x Slider
		 x Checkbox
		 x GalleryViewer
		DropDown
		RadioBox
		Docker
		Tabs
		
		
	Implemented Feature: GUI
		- Button
		- Textfield
		- Slider
		- GalleryViewer
#end 

Import maniacDebug


public
Const TEXTFIELD_STYLE_STD:Int 			= 0
Const TEXTFIELD_STYLE_WITHBUTTON:Int 	= 1

#Rem monkeydoc
	This Class is a Textfield Gui Element.
	Version 1.1
	
	Example:
	<pre>
		Global tf:ManiacSimpleTextfield = new ManiacSimpleTextfield(100,100,300,32)
		Function Main:Int()
			New Example							
			Return 0
		End Function 
	</pre>
#End
Class ManiacTextfield
	Private 
	Field maniacID:Int 
	Field ID:Int
	Field inputString:String = ""
	Field X:Int,Y:Int
	Field W:Int,H:int
	
	Field Style:Int  
	Field Focus:Int		'0 - Standard ohne gfx effects , 1 - 

	Field bEditing:Bool = False 
	
	
	Public 
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,istyle:Int = TEXTFIELD_STYLE_STD)
		If MANIAC_DEBUG = True
			Maniac_Debug.addStoredBools()
			Maniac_Debug.addStoredInts(8)
			maniacID = Maniac_Debug.getNumberOfRegisteredObjects()
			Maniac_Debug.addRegisteredObject()
		Endif 
		
		X 		= _X
		Y 		= _Y
		W 		= _Width
		H 		= _Height
		Style 	= istyle
	End Method 
	
		
	Public 
	Method Update:Int()
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
		Endif 
		'Maniac_Debug.addTotCalc(2)
		'Maniac_Debug.addTotDraws(2)
		'If bFull = True
			If TouchHit()
				If MOBox(X,Y,(W*0.15),(H*1.0))
					If bEditing = True
						bEditing = False
					Else
						bEditing = True
					Endif 
				Endif 
			Endif 
		'Endif 
		
		If bEditing = True 
			Repeat  
				Local char=GetChar()
		        If Not char Exit
		            		
		        If char>=32
		            inputString+=String.FromChar( char )
		        Endif
		           
		        If char = CHAR_ENTER
					DisableKeyboard()
					Return 99
				Endif
		           				
		        If char = CHAR_BACKSPACE
					Local txtlength:Int = inputString.Length()
					Local txtchars:Int[] = inputString.ToChars
					inputString = ""
					For Local l:Int = 0 To txtlength-2
						inputString += String.FromChar(txtchars[l])
					Next
				Endif
		                       	
			Forever
		Endif 
	End Method
	
	
	Public 
	Method Draw()
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
			Maniac_Debug.addTotDraws(3)
		Endif 
		SetAlpha 1
		SetColor 255,255,255
		DrawRect(X+W*0.15,Y,W-W*0.15,H)
		
		If bEditing = True
			SetColor 0,255,0
		Else
			SetColor 255,0,0
		Endif 
		
		DrawImage MANIAC_IMG_EDITICON,X,Y,0,(W*0.15)/MANIAC_IMG_EDITICON.Width(),(H*1.0)/MANIAC_IMG_EDITICON.Height()
		
		SetColor 0,0,0
		MANIAC_FONT.Wrap(inputString,X+W*0.15,Y+H/2-ManiacFont.getH()/2,W,H,inputString.Length())
		
		If bEditing = True
			SetColor 0,255,0
		Else	
			SetColor 255,0,0
		Endif 
		Drw_Rect(X,Y,W,H,3)
	End Method 
	
	Method drawFull()
		SetAlpha 1
		SetColor 255,255,255
		DrawRect(X+W*0.15,Y,W,H)
		
		If bEditing = True
			SetColor 0,255,0
		Else
			SetColor 255,0,0
		Endif 
		
		DrawImage DUKE_IMG_EDITICON,X,Y,0,(W*0.15)/DUKE_IMG_EDITICON.Width(),(H*1.0)/DUKE_IMG_EDITICON.Height()
		
		SetColor 0,0,0
		DUKE_FONT.Wrap(inputString,X+W*0.15,Y,W,H,Duke_MessageCount)
		
		If bEditing = True
			SetColor 0,255,0
		Else	
			SetColor 255,0,0
		Endif 
		Duke_Drw_Rect(X,Y,W,H,3)
	End Method 
	
	Method getText:String()
		Return inputString
	End Method 
	
	Method setText(itext:String)
		inputString = itext
	End Method 
End Class

Const ALIGNMENT_LEFT:Int = 1
Const ALIGNMENT_MIDDLE:Int = 2
Const ALIGNMENT_RIGHT:Int = 3

Const ANIM_DROP:Int 	= 1
Const ANIM_FADE:Int		= 2
Const ANIM_ROTATE:Int 	= 3
Const ANIM_ROLL:Int		= 4
Const ANIM_SLIDE:Int 	= 5
Const ANIM_CIRCLE:Int	= 6
Const ANIM_POPOUT:Int 	= 7


#Rem monkeydoc
	This Class is a Button Gui Element.
	Version 0.1
	Example:
	<pre>
		Global tB:ManiacButton = new ManiacButton(100,100,300,32)

		Function Main:Int()
			New Example							
			Return 0
		End Function  
	</pre>
#end
Class ManiacButton

	'Identificanitional Values
	Private 
	Field ID:Int 
	Field maniacID:Int
	Field MidX:Float,MidY:Float			'aktuelle Position des Buttons (Durch Animationen veränderbar
	Field oX:Float,oY:Float 		'Original X,Y << Das ist die Feste Position des Buttons
	Field Width:Float,Height:Float			'Breite und Höhe in Pxl
	
	'
	Field Caption:String		'Aufschrift
	Field CaptionColor:Int		'Color of the Caption
	Field Angle:Float 			'Winkel zur Horizontalen in °
	Field Alignment:Int			'ausrichtung des Textes (Left,Middle,Right)
	Field bTransparent:Bool = false 
	
	
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
	
	Field Color:Int 							'Integerwert einer Farbe aus der Maniac_Color Funktion
	
	'#### BUTTON MOUSEOVER STUFF #####
	Field bMO:Bool = False 
	Field bMOResize:Bool 		= false 
	Field bMOBrighter:Bool 		= false 
	Field bMOWobble:Bool		= false 
	Field AddWidthByMO:Int 		= 0
	Field AddHeightByMO:Int		= 0
	
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
			Maniac_Color(GlowColor)
			SetAlpha GlowAlpha
			DrawImage MANIAC_IMG_FRAME_BLUR, MidX,MidY,Angle,Width*GlowRangeRatioX/MANIAC_IMG_FRAME_BLUR.Width(),Height*GlowRangeRatioY/MANIAC_IMG_FRAME_BLUR.Height()
			Maniac_Debug.addTotDraws(1)
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
		DrawRect(MidX- (Width +AddWidthByMO/2)/2+2,MidY-(Height+AddHeightByMO/2)/2+2,Width+AddWidthByMO-4,Height+AddHeightByMO-4)
		Maniac_Debug.addTotDraws(1)
		'###### BUTTON FRAME ########
		If bFramed = True	
			Maniac_Color(FrameColor)
			DrawImage MANIAC_IMG_FRAME_RAW , MidX,MidY,Angle,(Width+AddWidthByMO)/MANIAC_IMG_FRAME_RAW.Width(),(Height+AddHeightByMO)/MANIAC_IMG_FRAME_RAW.Height()
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
			End Select 
			
			
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
	
	
	Method startAnimPopOut()
	
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
	
	Method setFrame(_isFramed:Bool = True,_FrameColor:Int = 0)
		bFramed = _isFramed
		FrameColor = _FrameColor
	End Method 
	
	Method setMouseOverEffects(_isResizing:Bool= True ,_isBrightening:Bool=False,_isWobbling:Bool = false )
		bMOResize		= _isResizing
		bMOBrighter		= _isBrightening
		bMOWobble		= _isWobbling
	End Method 
	
	Method setInactiveAnim()
	
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
	
	Method resetPosition()
		If MANIAC_DEBUG = True
			'Maniac_Debug.addCalc()
			Maniac_Debug.addCall()
		Endif
		MidX = oX
		MidY = oY
		Angle = 0
	End Method 
End Class 


#Rem monkeydoc
	This Class is a Slider Gui Element.
	Version 1.0 (a) Stable but unhandy
	Example:
	<pre>
		'This Example Shows how to use the Slider
		Global slider:ManiacSlider

		'... OnCreate
		slider =  new ManiacSlider(100,100,300,32,25,75)
		
		'... OnUpdate()
		slider.Update()
		local val:float = slider.getValue()
		
		'...OnRender()
		slider.Draw()
	</pre>
#End
Class ManiacSlider
	Private
	Field maniacID:Int 
	Field X:Float,Y:Float,Width:Float,Height:Float
	
	Field SliderX:Float
	
	Field Value:Float 
	Field ValueFrom:Float
	Field ValueTo:Float 
	Field ValueStep:Float 
	
	Field HoldPicker:Bool = True 
	
	Public 
	#Rem monkeydoc
		This is the Constructor for the Slider
		_X & _Y are topleft-Corner Koordinates in Pxl~n
		_Width & _Height are the rectangular size of the Slider in Pxl~n
		_ValueFrom - sets the lowest Return-Value
		_ValueTo	- sets the Maximum Return Value
	#End
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_ValueFrom:Float = 0,_ValueTo:Float = 100)
		Maniac_Debug.addStoredBools()
		Maniac_Debug.addStoredInts()
		Maniac_Debug.addStoredFloats(9)
		maniacID = Maniac_Debug.getNumberOfRegisteredObjects()
		Maniac_Debug.addRegisteredObject()
		
		X = _X
		Y = _Y
		Width = _Width
		Height= _Height
		ValueFrom = _ValueFrom
		ValueTo = _ValueTo
		SliderX = _X + _Width*0.5
	End Method 
	
	#Rem monkeydoc
		This Method returns the Current Value of Slider.
	#End
	Method getValue:Float()
		Maniac_Debug.addTotCall()
		Maniac_Debug.addTotCalc(2)
		'Maniac_Debug.addTotDraws()
		Local p:Float = (SliderX - X) / (X+Width-X)
		Local val:Float =  ValueFrom + (ValueTo-ValueFrom)*p
		
		Return val
	End Method 
	
	#Rem monkeydoc
		This Method Draws the whole Slider with Picker.
	#End
	Method Draw()
		Maniac_Debug.addTotCall()
		'Maniac_Debug.addTotCalc(2)
		Maniac_Debug.addTotDraws(2)
		SetAlpha 1
		SetColor 255,255,255
		DrawImage MANIAC_IMG_SLIDERLINE,X,Y,0,Width/MANIAC_IMG_SLIDERLINE.Width(),Height/MANIAC_IMG_SLIDERLINE.Height()
		
		If HoldPicker = True
			SetColor 0,255,0
			DrawText "Value: " + getValue(),X,Y+Height
		Endif 
		DrawImage MANIAC_IMG_SLIDERPICKER,SliderX,Y+Height*0.5,0,(Width*0.1)/MANIAC_IMG_SLIDERPICKER.Width(),(Height*1.2)/MANIAC_IMG_SLIDERPICKER.Height()
	End Method 
	
	#Rem monkeydoc
		This Method Updates the Slider. Especially the Picker and his X-Value.
		It checks for User-Slider for its own.
	#End
	Method Update()
		Maniac_Debug.addTotCall()
		HoldPicker = False 
		If TouchDown()
			If MOBox( SliderX-(Width*0.1)/2,  Y,  (Width*0.1), (Height*1.2))
				HoldPicker = True
				SliderX = MouseX()
				If SliderX >= X+Width
					SliderX = X+Width
				Endif
				If SliderX <= X
					SliderX = X
				Endif  
			Endif 
		Endif 
	End Method 
End Class

#Rem monkeydoc
	This Class is a GalleryViewer Gui Element.
	Version 0.1
	Example:
	<pre>
		Global tB:ManiacButton = new ManiacButton(100,100,300,32)

		Function Main:Int()
			New Example							
			Return 0
		End Function  
	</pre>
#End
Class ManiacGallery	Implements IOnLoadImageComplete
	Global loadedImages:Int =	0
	Global l:Int = 0
	
	Field arrImg:Image[500]
	Field maniacID:Int 
	Field X:Float,Y:Float,Width:Float,Height:Float
	Field ViewMode:Int = 1
	Field dist:Int = 10
	Field imgW:Float,imgH:Float 
	
	Field BtnRight:ManiacButton
	Field BtnLeft:ManiacButton
	Field BtnSwitchViewStyle:ManiacButton
	
	Field ScrolledImages:Int = 0
	
	Field tp:Int	= 0
	Field lastSwitch:Int 
	Field switchIntervall:Int = 500
	
	Field Alpha:float
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_loadPath:String = "GFX/")
		'arrImg[
		X = _X
		Y = _Y
		Width =_Width
		Height = _Height
		loadFromPath(_loadPath)
		Local bW:Float = DW*0.15
		Local bH:Float = DH*0.07
		imgW = ll_Width(_Width,3,dist)
		imgH = (_Height-bH)/2.5
		
		
		BtnLeft 			=  New ManiacButton(_X + bW/2 + _Width*0.02 ,_Y+_Height-bH/2, bW,	bH," << ",ALIGNMENT_MIDDLE,COLOR_BLUE,True,1.5)
		BtnRight 			=  New ManiacButton(_X + _Width - bW/2 - _Width*0.02 ,_Y+_Height-bH/2, bW,	bH," >> ",ALIGNMENT_MIDDLE,COLOR_BLUE,True,1.5)
		BtnSwitchViewStyle 	=  New ManiacButton(_X + _Width*0.5 ,_Y+_Height-bH/2, bW,	bH," Switch ",ALIGNMENT_MIDDLE,COLOR_BLUE,True,1.5)
		
		
	End Method 
	
	
	Method loadFromPath:Void(_Path:String="monkey://external/" )
		'Local stdPath:String
		#rem
		If _Path.Contains("monkey://external/")
			
		Elseif _Path.Contains("monkey://data/")
		Elseif _Path.Contains("monkey://internal/")
			stdPath = "monkey://internal/"
		Else 
			stdPath = "monkey://external/"+_Path
		Endif 
		#end
		Print "Get Folder"
		Local arrStr:String[] = GetFolderFiles(_Path)
		Print "Found: " + arrStr.Length() + " files"
		l = arrStr.Length()
		#rem
		If arrStr.Length() > 0
			For Local j:Int = 0 Until loadedImages'arrStr.Length()
				Print "Loading Image " + arrStr[j] + " to arrImg["+(j)+"]"
				arrImg[j] = LoadImage()
			Next 
		Endif
		#end 
		For Local ls:Int = 0 Until l
			Print "load " + ls
			LoadImageAsync(arrStr[ls], 1, 0, Self)
		Next
	End Method 
	
	Method Draw()
		Drw_Rect(X,Y,Width,Height,3)
		SetColor 255,255,255
		SetAlpha 1
		Select ViewMode
			Case 0	'3x2 overview
				Local i:Int = 0
				For Local x:Int = 0 To 2
					For Local y:Int = 0 To 1
						Drw_Rect(X+dist+x*(imgW+dist)  , Y+dist+y*(imgH+dist), imgW,imgH,2)
						'Print "i: " + i
						if arrImg[i+ScrolledImages] = Null 
							DrawText "No Image",X+dist+x*(imgW+dist)  , Y+dist+y*(imgH+dist)
						Else  
							DrawImage ( arrImg[i+ScrolledImages] , X+dist+x*(imgW+dist)  , Y+dist+y*(imgH+dist),0, imgW/arrImg[i+ScrolledImages].Width(), imgH/arrImg[i+ScrolledImages].Height() )
						Endif 
						i +=1
					Next
				Next 
				
			Case 1
				If arrImg[tp] <> Null
					SetAlpha 1
					DrawImage arrImg[tp], X,Y,0,Width*1/arrImg[tp].Width(),Height*0.87/arrImg[tp].Height()
				Endif 
				If arrImg[tp+1] <> Null
					SetAlpha Alpha
					DrawImage arrImg[tp+1], X,Y,0,Width*1/arrImg[tp+1].Width(),Height*0.87/arrImg[tp+1].Height()
				Endif 
		End Select 
		
		BtnLeft.Draw()
		BtnRight.Draw()
		BtnSwitchViewStyle.Draw()
		
		DrawText("Mode: " + ViewMode+ " | View: " + tp + "/"+loadedImages , X +Width*0.5,Y)
	End Method 
	
	Method Update:Int()
		
		
		If BtnLeft.Update() = 101 And gl_mousereleased
			if ScrolledImages <= 0
			
			Else
				ScrolledImages -= 1
			Endif
		Endif 
		
		If BtnRight.Update() = 101 And gl_mousereleased
			If (ScrolledImages + 6) >= loadedImages
			
			else
				ScrolledImages += 1
			Endif 
		Endif 
		
		If BtnSwitchViewStyle.Update() = 101 And gl_mousereleased
			If ViewMode = 0
				ViewMode = 1
			Else
				ViewMode = 0
			Endif 
		Endif 
		
		Select ViewMode
			Case 0
			Case 1
				If Millisecs() - lastSwitch >= switchIntervall
					If (tp + 1) >= loadedImages
						tp = 0
					else
						tp +=1
					Endif 
					Alpha = 0
					lastSwitch = Millisecs()
				Endif 
				
				Alpha += EqToFPS(1.0/(switchIntervall/1000.0))' 0.02
		End Select  
	End Method 
	
	Method OnLoadImageComplete:Void(_image:Image, path:String, source:IAsyncEventSource)
		If _image <> Null
			arrImg[loadedImages] = _image
			loadedImages += 1
		Else
			Print "no image : "+loadedImages
		Endif 
		
		#rem
		arrImg[loadedImages] = _image
		Print "Loaded Image id: " + loadedImages
		If arrImg[loadedImages] = Null
			Print "no image : "+loadedImages
		Else
			Maniac_Debug.addRegisteredGraphics()
		Endif 
		loadedImages += 1
		#end 
	End
	
	Method getNumberOfLoadedImages:Int()
	
	End Method
	
	Method getImageByID:Image(_ID:Int)
	
	End Method 
	
End class 


Class ManiacRadioGroup
	Field X:Int,Y:Int,Width:Int,Height:Int
	Field bFramed:Bool = true
	Field listElements:List<RadioElement>
	Field dist:Float = 8
	Field ActiveElementID:Int 
	Field Caption:String
	
	Method New(x:Int,y:Int,w:Int,h:Int,caption:String = "")
		X = x
		Y = y
		Width = w
		Height = h
		Caption = caption
		listElements = New List<RadioElement>
	End Method
	
	Method Draw()
    For Local oRE:RadioElement = Eachin listElements
      oRE.Draw()
    Next 
	End Method 
	
	Method addChoice(_Caption:String,_Value:Int)
		listElements.AddLast(New RadioElement(_Caption,_Value))
		reOrder()
	End Method 
	
	Private
	Method reOrder()
	
	End Method 
End Class 

Private 
Class RadioElement
	Field Caption:String
	Field Value:Int
	Field X:Float,Y:Float,Width:Float,Height:Float 
	
	Method New(_Caption:String,_Value:int)
		Caption =_Caption 
		Value =_Value
	End Method 
	
	Method Draw()
    'Drawing the Selectable Circle
    Drw_Ellipsis( X, Y, Width, Height)
	End Method 
End Class 
public

#Rem monkeydoc
	This Class is a GalleryViewer Gui Element.
	Version 0.1
	Example:
	<pre>
		Global tB:ManiacButton = new ManiacButton(100,100,300,32)

		Function Main:Int()
			New Example							
			Return 0
		End Function  
	</pre>
#End
Class ManiacCheckBox
	Field maniacID:Int 
	Field X:Float
	Field Y:Float
	Field Width:Float
	Field Height:Float
	Field bChecked:Bool 
	Field Caption:String
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Caption:String="")
		Maniac_Debug.addStoredBools(1)
		Maniac_Debug.addStoredInts(1)
		Maniac_Debug.addStoredFloats(4)
		maniacID 		= Maniac_Debug.getNumberOfRegisteredObjects()
		Maniac_Debug.addRegisteredObject()
		X 		= _X
		Y		= _Y
		Width 	= _Width
		Height 	= _Height
		Caption =	_Caption
	End Method 
	
	Method Draw()
		Drw_Rect(X,Y,Width,Height,2)
		
		If bChecked = True
			DrawImage MANIAC_IMG_CHECK ,X ,Y ,0 , Width/MANIAC_IMG_CHECK.Width() , Height/MANIAC_IMG_CHECK.Height()
		Endif 
	End Method
	
	Method Update()
		If TouchHit()
		If MOBox(X,Y, Width, Height)
			If bChecked = True
				bChecked = False
			Else
				bChecked = True
			Endif 
		Endif
		Endif  
	End Method
	
	Method getChecked:Bool()
		Return bChecked
	End Method 
End Class 

Class ManiacFileExplorer

End Class 

private
Class textElement
	Field Caption:String
	Field Line:Int 
	
	Method New(_Caption:String="")
		Caption =_Caption
	End Method 
	Method Draw(_X:Float,_Y:Float,_Width:Float,_Height:Float)
		MANIAC_FONT.Wrap(Caption,_X,_Y,_Width,_Height,Caption.Length())
	End Method 
End Class

public
#Rem monkeydoc
	This Class is a DropDown Gui Element.
	Version 0.1
	
	Example:
	<pre>
		Global tf:ManiacSimpleTextfield = new ManiacSimpleTextfield(100,100,300,32)
		Function Main:Int()
			New Example							
			Return 0
		End Function 
	</pre>
#End
Class ManiacDropDown
	Field maniacID:Int 
	Field X:Float
	Field Y:Float
	Field Width:Float
	Field Height:Float
	Field bOpened:Bool 
	Field Caption:String
	
	Field showOpenHeader:Int	= 1		'0 - Always Show Caption, 1 - Show MouseOver Elements , 2 - Show Selected Element
	Field showCloseHeader:Int 	= 2
	Field bCloseOnSelected:Bool = True 
	
	Field ShowLines:Int 	= 4
	Field ScrolledLines:Int = 0
	Field listTextElements:List<textElement>
	Field MOElement:Int 
	Field SelectedElement:Int = 0
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Caption:String="")
		Maniac_Debug.addStoredBools(1)
		Maniac_Debug.addStoredInts(1)
		Maniac_Debug.addStoredFloats(4)
		maniacID 		= Maniac_Debug.getNumberOfRegisteredObjects()
		Maniac_Debug.addRegisteredObject()
		X 		= _X
		Y		= _Y
		Width 	= _Width
		Height 	= _Height
		Caption =	_Caption
		listTextElements = New List<textElement>
	End Method 
	
	Method addLine(_Caption:String)
		Local oL:textElement = New textElement(_Caption)
		oL.Line = listTextElements.Count()
		
		listTextElements.AddLast(oL)
	
	End Method 
	
	Method DrawText()
		For Local oL:textElement = Eachin listTextElements
			oL.Draw(X+5,Y+Height+oL.Line*(27+5),200,100)	
		Next 
	End Method 
	
	Method Draw()
	
		If bOpened = True
			Drw_Rect(X,Y,Width,Height,2)
			Drw_Rect(X,Y+Height,Width,Height+ShowLines*(MANIAC_FONT.getH()+5),1)
			DrawText()
			
			Select showOpenHeader
				Case 0
					MANIAC_FONT.Wrap(Caption,X,Y,Width,Height,Caption.Length())
				Case 1
					MANIAC_FONT.Wrap(getTextByID(MOElement),X,Y,Width,Height,Caption.Length())
				Case 2
					MANIAC_FONT.Wrap(getTextByID(SelectedElement),X,Y,Width,Height,Caption.Length())
			End Select 
			
			DrawImage MANIAC_IMG_DROPDOWN , X+Width*0.9,Y, 0 , (Width*0.1)/MANIAC_IMG_DROPDOWN.Width(),Height/MANIAC_IMG_DROPDOWN.Height()
		Else
			Drw_Rect(X,Y,Width,Height,2)
			
			Select showCloseHeader
				Case 0
					MANIAC_FONT.Wrap(Caption,X,Y,Width,Height,Caption.Length())
				Case 1
					MANIAC_FONT.Wrap(getTextByID(MOElement),X,Y,Width,Height,Caption.Length())
				Case 2
					MANIAC_FONT.Wrap(getTextByID(SelectedElement),X,Y,Width,Height,Caption.Length())
			End Select
			
			DrawImage MANIAC_IMG_DROPDOWN , X+Width*0.9,Y, 0 , (Width*0.1)/MANIAC_IMG_DROPDOWN.Width(),Height/MANIAC_IMG_DROPDOWN.Height() 
		Endif 
	End Method
	
	Method Update()
		If TouchHit()
		If MOBox(X+Width*0.9,Y, Width*0.1, Height)
			If bOpened = True
				bOpened = False
			Else
				bOpened = True
			Endif 
		Endif
		Endif 
		MOElement = -1
		If bOpened
			For Local i:Int = 0 Until ShowLines
				If MOBox(X,Y+Height+i*(27+5),Width,27)
					MOElement = i
					If TouchHit()
						SelectedElement = i
						If bCloseOnSelected = True
							bOpened = False 
						Endif 
					Endif 
				Endif 
			Next 
		Endif 
	End Method
	
	Method getTextByID:String(_ID:Int)
		Local i:Int = 0
		For Local oL:textElement = Eachin listTextElements
			If i = _ID
				Return oL.Caption
			Endif 
			i +=1
		Next
	End Method 
	
	Method getSelectedText:String()
		Local i:Int = 0
		For Local oL:textElement = Eachin listTextElements
			If i = SelectedElement
				Return oL.Caption
			Endif 
			i +=1
		Next
	End Method 
	
End Class

#Rem monkeydoc
	This Class is a ListView Gui Element.
	You can Add Lines of Strings and Scroll them within this View.
	Version 0.1
	
	Example:
	<pre>
		Global tf:ManiacSimpleTextfield = new ManiacSimpleTextfield(100,100,300,32)
		Function Main:Int()
			New Example							
			Return 0
		End Function 
	</pre>
#End
Class ManiacListView
	Field maniacID:Int
	Field X:Float,Y:Float,Width:Float,Height:Float
	Field listText:List<textElement>
	
	Field nrLines:Int 
	Field ScrolledLine:Int = 0
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float)
		nrLines = _Height/32
		X = _X
		Y = _Y
		Width =_Width
		Height = _Height
		listText = New List<textElement>
	End Method
	
	Method Draw()
		Drw_Rect(X,Y,Width,Height,2)
		
		For Local i:Int = 0 Until nrLines
			MANIAC_FONT.Wrap(getText(i+ScrolledLine),X+5,Y+5+i*(27+5),Width,Height,40)
		Next 
		
		SetAlpha 1
		DrawImage MANIAC_IMG_ARROWDOWN,X,Y+Height+5,0,Width/MANIAC_IMG_ARROWDOWN.Width(),48.0/MANIAC_IMG_ARROWDOWN.Height()
	End Method
	
	Method Update()
		If TouchHit()
			If MOBox(X,Y+Height+5,Width,48)
				ScrolledLine +=1
			Endif 
		Endif 
	End Method 
	
	Method addLine(_Line:String)
		Local oL:textElement = New textElement(_Line)
		listText.AddLast(oL)
	End Method 
	
	Private 
	Method getText:String(_ID:Int)
		Local i:Int = 0
		For Local oL:textElement = Eachin listText
			If i = _ID
				Return oL.Caption
			Endif 
			i +=1
		Next 
	End Method 
End Class 



Class ManiacDialog
	Field X:Float,Y:Float,Width:Float,Height:Float
	Field Question:String
	Field Alpha:Float = 0.8
	Field bVisible:Bool = True 
	
	Field Btn_Ja:ManiacButton
	Field Btn_Nein:ManiacButton
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Question:String ="")
		X = _X
		Y = _Y
		Width =_Width
		Height = _Height
		Question = _Question 
		
		Btn_Ja = New ManiacButton(X+_Width*0.75,Y+_Height*0.8,_Width*0.4,	_Height*0.25,"Ja",ALIGNMENT_MIDDLE,COLOR_BLUE,True,0.2)
		Btn_Nein = New ManiacButton(X+_Width*0.25,Y+_Height*0.8,_Width*0.4,	_Height*0.25,"Nein",ALIGNMENT_MIDDLE,COLOR_BLUE,True,0.2)
	End Method 
	
	Method Draw()
		If bVisible = True 
			SetColor 0,0,0
			SetAlpha Alpha
			DrawRect(X,Y,Width,Height)
			
			SetAlpha 1
			SetColor 255,255,255
			MANIAC_FONT.Wrap(Question,X+Width*0.05,Y+15,Width*0.9,Height,350)
			
			Btn_Ja.Draw()
			Btn_Nein.Draw()
		Endif 
	End Method
	
	Method Update:Int()
		If Btn_Ja.Update() = 101
			Return 2
		Elseif Btn_Nein.Update() = 101
			Return 1
		Else
			Return 0
		Endif 
	End Method
	
	Method setVisible(_bVisible:Bool = True)
		bVisible = _bVisible
	End Method 
End Class 

private
Class ManiacAnimRect
	'Identificanitional Values
	Field ID:Int 
	Field maniacID:Int 
	Field MidX:Float,MidY:Float			'aktuelle Position des Buttons (Durch Animationen veränderbar
	Field oX:Float,oY:Float 		'Original X,Y << Das ist die Feste Position des Buttons
	Field Width:Float,Height:Float			'Breite und Höhe in Pxl
	
	'
	Field Caption:String		'Aufschrift
	Field Angle:Float 			'Winkel zur Horizontalen in °
	Field Alignment:Int			'ausrichtung des Textes (Left,Middle,Right)
	
	
	Method setPosition(_X:float,_Y:float)
		MidX = _X
		MidY = _Y
	End Method 
	
	Method setSize(_Width:Float,_Height:Float)
		Width = _Width
		Height =_Height
	End Method 
	
	
End Class 
Class ManiacSimpleTextfield
	Private 
	Field ID:Int
	Field inputString:String = ""
	Field X:Int,Y:Int
	Field W:Int,H:int
	
	Field Style:Int  
	Field Focus:Int		'0 - Standard ohne gfx effects , 1 - 

	Field bEditing:Bool = False 
	
	
	Public 
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,istyle:Int = TEXTFIELD_STYLE_STD)
		ID 		= Maniac_Debug.getNumberOfRegisteredObjects()
		X 		= _X
		Y 		= _Y
		W 		= _Width
		H 		= _Height
		Style 	= istyle
		Maniac_Debug.addRegisteredObject()
	End Method 
		
	Public 
	Method update:Int()
		If bFull = True
			If TouchHit()
				If MOBox(X,Y,(W*0.15),(H*1.0))
					If bEditing = True
						bEditing = False
					Else
						bEditing = True
					Endif 
				Endif 
			Endif 
		Endif 
		
		If bEditing = True 
			Repeat  
				Local char=GetChar()
		        If Not char Exit
		            		
		        If char>=32
		            inputString+=String.FromChar( char )
		        Endif
		           
		        If char = CHAR_ENTER
					DisableKeyboard()
					Return 99
				Endif
		           				
		        If char = CHAR_BACKSPACE
					Local txtlength:Int = inputString.Length()
					Local txtchars:Int[] = inputString.ToChars
					inputString = ""
					For Local l:Int = 0 To txtlength-2
						inputString += String.FromChar(txtchars[l])
					Next
				Endif
		                       	
			Forever
		Endif 
	End Method
	
	
	Public 
	Method draw()
		DrawText inputString,X,Y
	End Method 
	
		
	Method getText:String()
		Return inputString
	End Method 
	
	Method setText(itext:String)
		inputString = itext
	End Method 
End Class
