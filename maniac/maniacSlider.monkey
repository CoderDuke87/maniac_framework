'http://de.wikipedia.org/wiki/Steuerelement
Import maniac
#Rem monkeydoc
	This Class is a Slider Gui Element.
	Version 1.0 (a) Stable but unhandy
	
	ToDo: Vertical/Horizontal Align
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

Const SLIDER_STYLE_FLATLINE:Int 	= 0
Const SLIDER_STYLE_RECT:Int			= 1

Class ManiacSlider
	Private
	Field maniacID:Int 
	Field X:Float,Y:Float,Width:Float,Height:Float
	
	Field SliderX:Float
	Field SliderY:Float 
	Field Align:Int = 0		'0 - Hoirontal, 1- Vertical
	
	Field SliderStyle:Int = 0
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
		If MANIAC_DEBUG = True
			Maniac_Debug.addStoredBools(1)
			Maniac_Debug.addStoredInts(2)
			Maniac_Debug.addStoredFloats(9)
			'Maniac_Debug.addStoredStrings()
			maniacID = Maniac_Debug.getNumberOfRegisteredObjects()
			Maniac_Debug.addRegisteredObject()
		Endif
		
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
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
			Maniac_Debug.addTotCalc(2)
			'Maniac_Debug.addTotDraws()
		Endif 
		Local p:Float = (SliderX - X) / (X+Width-X)
		Local val:Float =  ValueFrom + (ValueTo-ValueFrom)*p
		
		Return val
	End Method 
	
	#Rem monkeydoc
		This Method Draws the whole Slider with Picker.
	#End
	Method Draw()
	
		If SliderStyle = 0
			If MANIAC_DEBUG = True
				Maniac_Debug.addTotCall()
				'Maniac_Debug.addTotCalc(2)
				Maniac_Debug.addTotDraws(2)
			Endif 
			SetAlpha 1
			SetColor 255,255,255
			DrawImage ManiacImg[IMG_SLIDER_FLATLINE],X,Y,0,Width/ManiacImg[IMG_SLIDER_FLATLINE].Width(),Height/ManiacImg[IMG_SLIDER_FLATLINE].Height()
			
			If HoldPicker = True
				SetColor 0,255,0
				DrawText "Value: " + getValue(),X,Y+Height
			Endif 
			DrawImage ManiacImg[IMG_SLIDER_PICKER],SliderX,Y+Height*0.5,0,(Width*0.1)/ManiacImg[IMG_SLIDER_PICKER].Width(),(Height*1.2)/ManiacImg[IMG_SLIDER_PICKER].Height()
			
			
		Elseif SliderStyle = SLIDER_STYLE_RECT
			SetAlpha 1
			SetColor 75,75,75
			Drw_Rect(X,Y,Width,Height,1)
			
			DrawRect(SliderX,Y,Width*0.1,Height)
		Endif 
	End Method 
	
	#Rem monkeydoc
		This Method Updates the Slider. Especially the Picker and his X-Value.
		It checks for User-Slider for its own.
	#End
	Method Update()
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
		Endif 
		HoldPicker = False 
		If TouchDown()
		
			If SliderStyle = 0
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
			Elseif SliderStyle = 1
				If MOBox( SliderX-10,  Y,  (Width*0.1+20), (Height))
					HoldPicker = True
					SliderX = MouseX()-Width*0.05
					If SliderX >= X+Width
						SliderX = X+Width*0.9
					Endif
					If SliderX <= X
						SliderX = X
					Endif
				Endif 
			 
			Endif 
		Endif 
	End Method 
	
	
	Method setStyle:Void(_Style:Int = 0)
		SliderStyle = _Style
	End Method 
	
	Method setAlign:Void(_Align:Int = 0)
		Align = _Align
	End Method 
	
	
	Method setValueFrom:Void(_Value:Float)
		ValueFrom = _Value
	End Method
	
	Method setValueTo:Void(_Value:Float)
		ValueTo = _Value
	End Method 
	
	Method setBarWidth:Void(_Pixel:Float)
		Select SliderStyle
			Case SLIDER_STYLE_FLATLINE
			case SLIDER_STYLE_RECT
		End Select 
	End Method
	
	
	#rem
		Set the Width of the Bar with Predefined Settings.
		Params: "SLIM","MIDDLE","FAT"
	#end 
	Method setBarWidth:Void(_String:String)
		Select SliderStyle
			Case SLIDER_STYLE_FLATLINE
				Select _String
					Case "SLIM"
					Case "MIDDLE"
					Case "FAT"
				End Select
			Case SLIDER_STYLE_RECT
				Select _String
					Case "SLIM"
						If Align = 0		'HORIZONTAL
							Height = 15
						Elseif Align = 1
						
						Endif 
					Case "MIDDLE"
						If Align = 0		'HORIZONTAL
							Height = 25
						Elseif Align = 1
						
						Endif
					Case "FAT"
						If Align = 0		'HORIZONTAL
							Height = 35
						Elseif Align = 1
						
						Endif
				End Select
		End Select
	End Method 
	
	Method getPosX:Float()
		Return X
	End Method
	
	Method getPosY:Float()
		Return Y
	End Method 
	
End Class