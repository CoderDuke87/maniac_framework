
Import maniac
Class ManiacDropDown
	Field maniacID:Int 
	Field X:Float
	Field Y:Float
	Field Width:Float
	Field Height:Float
	Field bOpened:Bool '= True 
	Field Caption:String
	
	Field listTextElements:List<textElement>
	
	Field showOpenHeader:Int	= 1		'0 - Always Show Caption, 1 - Show MouseOver Elements , 2 - Show Selected Element
	Field showCloseHeader:Int 	= 2
	Field bCloseOnSelected:Bool = True 
	Field bWrapToLines:Bool 
	Field ShowLines:Int 	= 0
	Field ScrolledLines:Int = 0
	
	Field MOElement:Int 
	Field SelectedElement:Int = 0
	
	Field bSound:Bool = True 
	
	Field tweenY:Tween
	
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Caption:String="")


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
		ShowLines +=1
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
	Method Draw()
		SetColor 255,255,0
		SetAlpha 1
		Drw_Rect(X,Y,Width,Height,2)
		If bOpened = True
			Drw_Rect(X,Y,Width,Height,2)
			
			If bWrapToLines = True
				Drw_Rect(X,Y+Height,Width,Height+(listTextElements.Count()-1)*(MANIAC_FONT.getH()+2),1)
			Else 
				Drw_Rect(X,Y+Height,Width,Height+ShowLines*(MANIAC_FONT.getH()+5),1)
				
			Endif 
			DrawLines()
			
			Select showOpenHeader
				Case 0
					MANIAC_FONT.Wrap(Caption,X,Y,Width,Height,50)
				Case 1
					MANIAC_FONT.Wrap(getTextByID(MOElement),X,Y,Width,Height,50)
				Case 2
					MANIAC_FONT.Wrap(getTextByID(SelectedElement),X,Y,Width,Height,50)
			End Select 
			
			'DrawImage MANIAC_IMG_DROPDOWN , X+Width*0.9,Y, 0 , (Width*0.1)/MANIAC_IMG_DROPDOWN.Width(),Height/MANIAC_IMG_DROPDOWN.Height()
		Else
			Drw_Rect(X,Y,Width,Height,2)
			
			Select showCloseHeader
				Case 0
					MANIAC_FONT.Wrap(Caption,X,Y,Width,Height,50)
				Case 1
					MANIAC_FONT.Wrap(getTextByID(MOElement),X,Y,Width,Height,50)
				Case 2
					MANIAC_FONT.Wrap(getTextByID(SelectedElement),X,Y,Width,Height,50)
			End Select
			
			'DrawImage MANIAC_IMG_DROPDOWN , X+Width*0.9,Y, 0 , (Width*0.1)/MANIAC_IMG_DROPDOWN.Width(),Height/MANIAC_IMG_DROPDOWN.Height() 
		Endif 
		
		SetColor 255,255,255
		SetAlpha 1
	End Method
	Method DrawLines()
		For Local oL:textElement = Eachin listTextElements
			oL.Draw(X+5,Y+Height+oL.Line*(27+2),200,100)	
		Next 
	End Method
	
	Method Update()
		If TouchHit()
			If MOBox(X+Width*0.9,Y, Width*0.1, Height)
				If bOpened = True
					bOpened = False
				Else
					bOpened = True
					If GLOBAL_SOUNDON = True And bSound = True 
						'PlaySound(MANIAC_SND_SLIDE3)
					Endif 
				Endif 
			Endif
		Endif 
		MOElement = -1
		If bOpened
			For Local i:Int = 0 Until ShowLines
				If MOBox(X,Y+Height+i*(27+2),Width,27)
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
	
End Class 


Class textElement
	Field Caption:String
	Field Line:Int 
	
	Method New(_Caption:String="")
		Caption =_Caption
	End Method 
	Method Draw(_X:Float,_Y:Float,_Width:Float,_Height:Float)
		MANIAC_FONT.Wrap(Caption,_X,_Y,_Width,_Height,50)
	End Method 
End Class