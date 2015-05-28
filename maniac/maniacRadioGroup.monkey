#Rem monkeydoc Module maniac.maniacRadioGroup
	GUI - NumberSelector Module - Version 1.0 (alpha)  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	
	Here You can find some "ad-Hoc" Graphic-Elements to use for your App.
	They have to be managed by the Programmer.
	
		

	
		
		
#End
Import maniac

Const RADIOGROUP_STYLE_ELLIPSE:Int	= 1
Const RADIOGROUP_STYLE_RECT:Int 	= 2

Const RADIOGROUP_VERTICAL:Int		= 1
Const RADIOGROUP_HORIZONTAL:Int 	= 2

Class ManiacRadioGroup
	Field maniacID:Int
	#rem
		TODO:
			- Wrap to Radios as a Modyfier. (means, that each Radio has a predefined Height/Width and the RadioGroup's Size will change with the number of Radios.
	#end
	Field X:Float,Y:Float,Width:Float,Height:Float 
	Field bFramed:Bool = true
	Field listElements:List<RadioElement>
	Field dist:Float = 8
	Field ActiveElementID:Int 
	Field Caption:String
	Field AlignRadio:Int = RADIOGROUP_HORIZONTAL 	'0-Horizontal ; 1-Vertical		// 1 should be Standard at the Moment! will be fixed to Version 1.1
	Field RadioStyle:Int = RADIOGROUP_STYLE_RECT
	
	Field Color_CaptionBG:Int = COLOR_BLACK
	Field Color_CaptionText:Int = COLOR_WHITE
	
	Field bShowSelected:Bool = False
	
	Field bActive:Bool 			= True  
	'Field bFramed:Bool = True 
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Caption:String = "") 
		If MANIAC_DEBUG = True
			'Maniac_Debug.addStoredBools(1)
			Maniac_Debug.addStoredInts(4)
			Maniac_Debug.addStoredFloats(4)
			Maniac_Debug.addStoredStrings(1)
			maniacID = Maniac_Debug.getNumberOfRegisteredObjects()
			Maniac_Debug.addRegisteredObject()
		Endif
		X = _X
		Y = _Y
		Width = _Width
		Height = _Height
		Caption = _Caption
		
		AlignRadio = RADIOGROUP_HORIZONTAL
		listElements = New List<RadioElement>
	End Method
	
	Method Draw()
	
		#rem
			### Drawing the Radio Elements ###
		#end
    	For Local oRE:RadioElement = Eachin listElements
     		oRE.Draw()
    	Next 
    	
    	#rem
    		Drawing the Caption
    	#end
    	Maniac_Color(Color_CaptionBG)
    	DrawRect(X,Y-35,Width,35)
    	
    	Maniac_Color(Color_CaptionText)
    	SetAlpha 1
    	Drw_ManiacText(Caption,X,Y-35,Width,35,ALIGNMENT_MIDDLE)
    	
    	If bShowSelected = True 
    		Local str:String = "selected Value: " + getActiveElementValue()
    		Drw_ManiacText(str,X,Y+Height,Width,35,ALIGNMENT_MIDDLE)
    	Endif 
    	
    	If bFramed = True
    		Drw_Rect(X,Y,Width,Height,2)
    	Endif 
    	If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
			Maniac_Debug.addRenderedObject()
			Maniac_Debug.addTotDraws(3)
		Endif
	End Method 
	
	Method addChoice(_Caption:String,_Value:Int)
   		Local oRE:RadioElement = New RadioElement(_Caption,_Value)
    	oRE.ID = listElements.Count()
		listElements.AddLast(oRE)
		reOrder()
	End Method 
	
	Method getActiveElementValue:Int()
	    For Local oRE:RadioElement = Eachin listElements
	      If oRE.isActive()
	        Return oRE.Value
	      Endif 
	    Next 
	End Method 
	
	
	Method Update:Void()
	    Local newClickID:Int = 0
	    'Check for Clicking on a RadioElement
	    For Local oRE:RadioElement = Eachin listElements
	      If oRE.Update() <> -1
	        setActiveElement(oRE.ID)
	      Endif 
	    Next 
	End Method 
	
	
	Method setActiveElement:Void(_ID:Int)
	    For Local oRE:RadioElement = Eachin listElements
	      If oRE.ID = _ID
	        oRE.setActive(True)
	      Else
	        oRE.setActive(False)
	      Endif  
	    Next 
	End Method 
	
	Method setStyle:Void(_RadioStyle:Int)
		RadioStyle = _RadioStyle
	End Method
	
	Method setAlign:Void(_Align:Int)
		AlignRadio = _Align
		
		If _Align =RADIOGROUP_HORIZONTAL
		
		Else
		
		Endif 
	End Method
	
	Method showSelected:Void(_Bool:Bool)
		bShowSelected = _Bool
	End Method
	
	Private
	Method reOrder()
		If AlignRadio = RADIOGROUP_HORIZONTAL
			Select RadioStyle
				Case RADIOGROUP_STYLE_ELLIPSE
					Local eW:Float = ll_Width(Width,listElements.Count(),10)
			
		   	 		Local i:Int = 0
		    		For Local oRE:RadioElement = Eachin listElements
		    			oRE.setPosition(X + 10 + i*eW/2.0, Y + Height*0.5, eW/2,eW/2)
		    			i +=1
		   			 Next
				Case RADIOGROUP_STYLE_RECT
					Local eW:Float = ll_Width(Width,listElements.Count(),10)
					Local i:Int = 0
					For Local oRE:RadioElement = Eachin listElements
		    			oRE.setPosition(X + 10 + i*(eW+10), Y , eW,Height)
		    			i +=1
		   			 Next
			End Select 
			 
		    
		Elseif AlignRadio = RADIOGROUP_VERTICAL
			Local eH:Float = ll_Width(Height,listElements.Count(),3)
		  	Local i:Int = 0
		    For Local oRE:RadioElement = Eachin listElements
		    	oRE.setPosition(X , Y + i*eH , Width,eH-2)
		    	i +=1
		    Next
		Endif 
	End Method 
End Class 

Class RadioElement
	Field maniacID:Int 
  	Field ID:Int 
	Field Caption:String
	Field Value:Int
	Field X:Float,Y:Float,Width:Float,Height:Float 
	Field bActive:Bool 
	
	Field AlignRadio:Int = 0
	
	Field Color_BG:Int = 7
	Field Style:Int = RADIOGROUP_STYLE_RECT
	
	Field bFramed:Bool = True 
	
	
	Method New(_Caption:String,_Value:Int,_Align:Int = RADIOGROUP_HORIZONTAL)
		If MANIAC_DEBUG = True
			Maniac_Debug.addStoredBools(1)
			Maniac_Debug.addStoredInts(5)
			Maniac_Debug.addStoredFloats(4)
			Maniac_Debug.addStoredStrings(1)
			maniacID = Maniac_Debug.getNumberOfRegisteredObjects()
			Maniac_Debug.addRegisteredObject()
		Endif
		Caption =_Caption 
		Value =_Value
		AlignRadio = _Align
	End Method 
	
	Method Draw()
	
		Local draws:Int = 0
		
    	'Drawing the Selectable Circle
    	If AlignRadio = RADIOGROUP_HORIZONTAL
    		Select Style
    			'Case RADIOGROUP_STYLE_ELLIPSE
    			Case RADIOGROUP_STYLE_RECT
    				If bActive = True
    					Maniac_Color(Color_BG)
    					DrawRect(X,Y,Width,Height)
    				Endif 
    				
    				'Maniac_Color(COLOR_WHITE)
    				SetColor 255,255,255
    				Drw_ManiacText(Caption,X,Y,Width,Height, ALIGNMENT_MIDDLE,ALIGNMENT_MIDDLEY,1.0)
    				
    				
    				If bFramed = True
    					Drw_Rect(X+2,Y+2,Width-4,Height-4)
    				Endif 
    		End Select 
    		'Drw_Ellipsis( X, Y, Width, Height)
    		draws +=1
    		
    		
    		
    	Elseif AlignRadio = RADIOGROUP_STYLE_ELLIPSE	'Vertical (Android SelectorStyle ...)
    	
    		#rem
				Drawing the Background
			#end
			Maniac_Color(Color_BG)
			'DrawImage MANIAC_IMG_BACKGROUND ,X,Y ,0 ,Width/MANIAC_IMG_BACKGROUND.Width(),Height/MANIAC_IMG_BACKGROUND.Height()
		
			Maniac_Color(5)
    		Drw_Rect(X,Y,Width,Height,1)
    		
    		
    		Drw_Circle(X+Width-Height/2-2,Y+Height/2,Height*0.9)
    		
    		If bActive = True
    			SetColor 0,0,0
    			DrawCircle(X+Width-Height/2-2,Y+Height/2,Height*0.23)
    			draws +=1
    		Endif 
    		SetColor 0,255,0
    		Drw_ManiacText(Caption,X,Y,Width-Height*0.9,Height,ALIGNMENT_MIDDLE)
    		draws +=4
    	Endif 
    	
    	If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
			Maniac_Debug.addRenderedObject()
			Maniac_Debug.addTotDraws(draws)
		Endif
	End Method 
	
	Method setPosition(_X:Float, _Y:Float, _Width:Float,_Height:Float)
	    X = _X
	    Y = _Y
	    Width  = _Width
	    Height = _Height
	End Method 
	
	Method Update:Int()
    	If MOBox(X,Y,Width,Height)
     		If gl_mousereleased
        		Return ID
     		Endif 
    	Endif 
    	Return -1
	End Method 
	
	Method setActive(_isActive:Bool = True)
   		bActive = _isActive
	End Method 
	
	Method isActive:Bool()
		Return bActive
	End Method 
	
	Method setStyle:Void(_Style)
		Style = _Style
	End Method 
End Class 