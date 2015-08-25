#Rem monkeydoc Module maniac.maniacRadioGroup
	GUI - NumberSelector Module - Version 1.0 (alpha)  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	
	
		
		
#End
Import maniac

Const RADIOGROUP_STYLE_ELLIPSE:Int	= 1
Const RADIOGROUP_STYLE_RECT:Int 	= 2
Const RADIOBUTTON_STYLE_RECT:Int 	= 2 

Const RADIOGROUP_VERTICAL:Int		= 1
Const RADIOGROUP_HORIZONTAL:Int 	= 2

Class ManiacRadioGroup Extends cGuiBase
	Field maniacID:Int
	#rem
		TODO:
			- Wrap to Radios as a Modyfier. (means, that each Radio has a predefined Height/Width and the RadioGroup's Size will change with the number of Radios.
	#end
	Field listElements:List<RadioElement>
	Field dist:Float = 8
	Field ActiveElementID:Int 
	Field AlignRadio:Int = RADIOGROUP_HORIZONTAL 	'0-Horizontal ; 1-Vertical		// 1 should be Standard at the Moment! will be fixed to Version 1.1
	Field RadioStyle:Int = RADIOGROUP_STYLE_RECT
	
	Field Color_CaptionBG:Int = COLOR_BLACK
	Field Color_CaptionText:Int = COLOR_WHITE
	
	Field bShowSelected:Bool = False
	
	Field bActive:Bool 			= True  
	'Field bFramed:Bool = True 
	
	
	Function CreateHorizontalGroup:ManiacRadioGroup(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Caption:String = "")
		Local rg:ManiacRadioGroup = New ManiacRadioGroup(_X,_Y,_Width,_Height,_Caption)
		
		rg.setTitle(_Caption)
		rg.showFrame()
		rg.setColor_Title(COLOR_WHITE)
		rg.setStyle(MANIAC_GUIBASE_STYLE_STANDARD)
		rg.setColor_Frame(COLOR_WHITE,COLOR_RED,COLOR_GREEN)
		AlignRadio = RADIOGROUP_HORIZONTAL
		
	End Function 
	
	Function CreateVerticalGroup:ManiacRadioGroup(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Caption:String = "")
		Local rg:ManiacRadioGroup = New ManiacRadioGroup(_X+_Width/2,_Y+_Height*0.5,_Width,_Height,_Caption)
		
		rg.setTitle(_Caption)
		rg.showFrame()
		rg.setColor_Title(COLOR_WHITE)
		rg.setStyle(MANIAC_GUIBASE_STYLE_STANDARD)
		rg.setColor_Frame(COLOR_WHITE,COLOR_RED,COLOR_GREEN)
		rg.AlignRadio = RADIOGROUP_VERTICAL
		'rg.listElements = New List<RadioElement>
		
		Return rg
	End Function
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Caption:String = "") 
		If MANIAC_DEBUG = True
			'Maniac_Debug.addStoredBools(1)
			Maniac_Debug.addStoredInts(4)
			Maniac_Debug.addStoredFloats(4)
			Maniac_Debug.addStoredStrings(1)
			maniacID = Maniac_Debug.getNumberOfRegisteredObjects()
			Maniac_Debug.addRegisteredObject()
		Endif
		setGeo(_X,_Y,_Width,_Height)
		
		#rem
		setTitle(_Caption)
		showFrame()
		setColor_Title(COLOR_WHITE)
		setStyle(MANIAC_GUIBASE_STYLE_STANDARD)
		setColor_Frame(COLOR_WHITE,COLOR_RED,COLOR_GREEN)
		AlignRadio = RADIOGROUP_HORIZONTAL
		Title = _Caption
		#end 
		listElements = New List<RadioElement>
	End Method
	
	Method Draw()
		drawBase()
		#rem
			### Drawing the Radio Elements ###
		#end
    	For Local oRE:RadioElement = Eachin listElements
     		oRE.Draw()
    	Next 

    	
    	If bShowSelected = True 
    		Local str:String = "selected Value: " + getActiveElementValue()
    		Drw_ManiacText(str,getX(),getY()+getHeight(),getWidth(),35,ALIGNMENT_MIDDLE)
    	Endif 

    	If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
			Maniac_Debug.addRenderedObject()
			Maniac_Debug.addTotDraws(3)
		Endif
	End Method 
	
	
	Method Update:Int()
	
		Local ev:Int = updateBase()
	    Local newClickID:Int = 0
	    'Check for Clicking on a RadioElement
	    For Local oRE:RadioElement = Eachin listElements
	    	Local nID:Int = oRE.Update()
	      	If nID <> -1
	        	setActiveElement(oRE.ID)
	        	'Print "setActElement: " + oRE.ID 
	        	If gl_mousereleased = True
	        		'Print "RadioGroup returning: " + oRE.Value
	        		Return oRE.ID
	        	Endif 
	      	Endif 
	    Next 
	    
	    Return -1
	End Method 



	Method addChoice(_Caption:String,_Value:Int)
		
   		Local oRE:RadioElement = New RadioElement(_Caption,_Value)
    	oRE.ID = listElements.Count()
    	oRE.setColor_Text(COLOR_WHITE,COLOR_BLUE,COLOR_GREEN)
    	oRE.setColor_Frame(COLOR_WHITE,COLOR_WHITE,COLOR_BLUE)
    	oRE.setColor_BG(COLOR_BLACK,COLOR_MAGENTA,COLOR_BLUE)
    	oRE.showFrame()
		listElements.AddLast(oRE)
		reOrder()
	End Method 
	
	Method addChoice(_Caption:String,_Value:Int,_BG_Color:Int)
		Local nChoices:Int = listElements.Count()
   		Local oRE:RadioElement = New RadioElement("("+nChoices+")"+_Caption,_Value)
    	oRE.ID = listElements.Count()
    	oRE.setColor_Text(COLOR_WHITE,COLOR_BLUE,COLOR_GREEN)
    	oRE.setColor_Frame(COLOR_WHITE,COLOR_WHITE,COLOR_BLUE)
    	oRE.setColor_BG(_BG_Color,COLOR_MAGENTA,COLOR_BLUE)
    	oRE.showFrame()
		listElements.AddLast(oRE)
		reOrder()
	End Method
	
	Method addChoice(_Caption:String,_Value:Int,_Text:String)
		Local oRE:RadioElement = New RadioElement(_Caption,_Value)
    	oRE.ID = listElements.Count()
    	oRE.setColor_Text(COLOR_WHITE,COLOR_BLUE,COLOR_GREEN)
    	oRE.setColor_Frame(COLOR_WHITE,COLOR_WHITE,COLOR_BLUE)
    	oRE.setColor_BG(COLOR_BLACK,COLOR_MAGENTA,COLOR_BLUE)
    	oRE.showFrame()
    	oRE.setREText(_Text)
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
	Method getElementValue:Int(_id:int)
		For Local oRE:RadioElement = Eachin listElements
	      If oRE.ID = _id
	        Return oRE.Value
	      Endif  
	    Next
	End Method 
	Method getActiveElementString:String()
		 For Local oRE:RadioElement = Eachin listElements
	      If oRE.isActive()
	        Return oRE.Text
	      Endif 
	    Next 
	End Method 
	
	Method getActiveElementREText:String()
		 For Local oRE:RadioElement = Eachin listElements
	      If oRE.isActive()
	        Return oRE.getREText()
	      Endif 
	    Next 
	End Method 
	
	Method getActiveElementID:Int()
	Local i:Int = 0
	    For Local oRE:RadioElement = Eachin listElements
	      If oRE.isActive()
	        	Return i
	      Endif 
	      i+=1
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
	
	Method setGroupStyle:Void(_RadioStyle:Int)
		RadioStyle = _RadioStyle
	End Method
	Method setRadioButtonStyle:Void(_RadioStyle:Int)
		RadioStyle = _RadioStyle
	End Method
	
	
	Method setRadioButtonAlign:Void(_Align:Int )
		AlignRadio = _Align
		If _Align =RADIOGROUP_HORIZONTAL
			RadioStyle = RADIOGROUP_STYLE_RECT
		Else
		
		Endif
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
	
	Method getCurrMO:Int()
	
	
		Return -1
	End Method 
	
	
	Private
	Method reOrder()
		If AlignRadio = RADIOGROUP_HORIZONTAL
			Select RadioStyle
				Case RADIOGROUP_STYLE_ELLIPSE
					Local eW:Float = ll_Width(getWidth(),listElements.Count(),10)
			
		   	 		Local i:Int = 0
		    		For Local oRE:RadioElement = Eachin listElements
		    			oRE.setGeo(getX() + 10 + i*eW/2.0-getWidth()/2, getY() , eW/2,eW/2)
		    			i +=1
		   			 Next
				Case RADIOGROUP_STYLE_RECT
					Local eW:Float = ll_Width(getWidth(),listElements.Count(),10)
					Local i:Int = 0
					For Local oRE:RadioElement = Eachin listElements
		    			oRE.setGeo(getX() + 10 + i*(eW+10) - getWidth()/2, getY()-getHeight()/2 , eW,getHeight())
		    			i +=1
		   			 Next
			End Select 
			 
		    
		Elseif AlignRadio = RADIOGROUP_VERTICAL
			Local eH:Float = ll_Width(getHeight(),listElements.Count(),3)
		  	Local i:Int = 0
		    For Local oRE:RadioElement = Eachin listElements
		    	'oRE.setGeo(getX()+4  , getY() + i*eH - getWidth()*1, getWidth()-8,eH-2)
		    	oRE.setGeo(getX() + 4 , getY() + i*eH + eH*0.5-getHeight()*0.5, getWidth()-8,eH-2)
		    	i +=1
		    Next
		Endif 
	End Method 
	
	public
	Method startAnimSlideIn:Void()
		startAnimSlide(-DW*0.5,1500,"Back", "Out")
		For Local oRE:RadioElement = Eachin listElements
		    oRE.startAnimPopOut(1000,"Back","Out")'(X - Width/2 , Y + i*eH -Height/2, Width,eH-2)
		   ' i +=1
		  Next
	End Method 
	
	Method resetList:Void()
		listElements = New List<RadioElement>
	End Method 
	
	Method printList()
		For Local oRE:RadioElement = Eachin listElements
		   Print "ID: " + oRE.ID+ " | Caption: " + oRE.Caption + " | Text: " + oRE.getREText() + " | Value: " + oRE.Value
		  Next
	End Method 
End Class 

Class RadioElement Extends cGuiBase
	Field maniacID:Int 
  	Field ID:Int 
	Field Caption:String
	Field Value:Int
	Field bActive:Bool 
	Field Text:String 
	Field AlignRadio:Int = 0
	
	Field Color_BG:Int = 7
	Field InternalText:String 
	
	
	Method New(_Caption:String,_Value:Int,_Align:Int = RADIOGROUP_HORIZONTAL)
		If MANIAC_DEBUG = True
			Maniac_Debug.addStoredBools(1)
			Maniac_Debug.addStoredInts(5)
			Maniac_Debug.addStoredFloats(4)
			Maniac_Debug.addStoredStrings(1)
			maniacID = Maniac_Debug.getNumberOfRegisteredObjects()
			Maniac_Debug.addRegisteredObject()
		Endif
		'Caption =_Caption 
		Value =_Value
		AlignRadio = _Align
		
		setText(_Caption)
	End Method 
	
	Method Draw()
		drawBase()
		
		#rem
		Local draws:Int = 0
		
    	'Drawing the Selectable Circle
    	If AlignRadio = RADIOGROUP_HORIZONTAL
    		Select Style
    			'Case RADIOGROUP_STYLE_ELLIPSE
    			Case RADIOGROUP_STYLE_RECT
    				If bActive = True
    					Maniac_Color(COLOR_WHITE)
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
    	#end 
    	If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
			Maniac_Debug.addRenderedObject()
			'Maniac_Debug.addTotDraws(draws)
		Endif
	End Method 
	
 
	
	Method Update:Int()
		updateBase()
    	If MOBox(getX()-getWidth()*0.5,getY()-getHeight()*0.5,getWidth(),getHeight())
     		If gl_mousereleased
     			Print "RedioElement ("+ID+") | Value: " + Value
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
	
	Method setREText(_Text:String)
		InternalText = _Text
	End Method 
	Method getREText:String()
		Return InternalText' = _Text
	End Method
End Class 