Import maniac
#Rem monkeydoc
	This Class is a CheckBox Gui Element.
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

Const MANIAC_CHECKBOX_CHECKED:Int = 25
Const MANIAC_CHECKBOX_UNCHECKED:Int = 35

Class ManiacCheckBox
	Field maniacID:Int 
	Field X:Float
	Field Y:Float
	Field Width:Float
	Field Height:Float
	Field bChecked:Bool 
	Field Caption:String
	Field bCaption:Bool = True
	Field AlignText:Int 
	
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
		Width 	= _Width
		Height 	= _Height
		Caption =	_Caption
		AlignText = ALIGNMENT_RIGHT
	End Method 
	
	Method Draw()
		Drw_Rect(X,Y,Width,Height,2)
		
		If bChecked = True
			DrawImage ManiacImg[IMG_ICON_CHECKEDARROW] ,X+Width/2 ,Y+Height/2 ,0 , Width/ManiacImg[IMG_ICON_CHECKEDARROW].Width() , Height/ManiacImg[IMG_ICON_CHECKEDARROW].Height()
		Endif 

		If bCaption = True
			Select AlignText
				Case ALIGNMENT_LEFT
				Case ALIGNMENT_RIGHT
					Drw_ManiacText(Caption,X+Width+5,Y,DW*0.3,800,ALIGNMENT_LEFT,ALIGNMENT_TOP,1.1)
				Case ALIGNMENT_TOP
				Case ALIGNMENT_BOTTOM
			End Select 
			
		Endif 
	End Method
	
	Method Update:int()
		If TouchHit()
			If MOBox(X,Y, Width, Height)
				If bChecked = True
					bChecked = False
					Return MANIAC_CHECKBOX_UNCHECKED
				Else
					bChecked = True
					Return MANIAC_CHECKBOX_CHECKED
				Endif 
			Endif
		Endif  
		
		Return -1
	End Method
	
	Method getChecked:Bool()
		Return bChecked
	End Method 
	
	Method setAlignText:Void(_AlignText:Int)
		AlignText = _AlignText
	End Method 
End Class 