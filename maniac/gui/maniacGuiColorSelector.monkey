#Rem monkeydoc Module maniac.maniacTextfield
	This Class is a Textfield Gui Element.~n
	Version: 0.9 

	You can use it for inputting some Stuff like Player_Name etc.
Example:
<pre>

Function Main:Int()
	New Example							
	Return 0
End Function  
		
Class Example extends App

	field TxtName:ManiacTextfield
	
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

Class ManiacColorSelector
	Private 
	Field maniacID:Int 
	Field ID:Int
	Field Caption:String = ""
	Field X:Int,Y:Int
	Field W:Int,H:int
	
	Field Style:Int  
	Field bHide:Bool = False 
	
	Field bShowButton:Bool 	= False 
	Field bShowCaption:Bool
	Field bWrapHeight:Bool = False 
	Field bEditing:Bool = False 
	Field bEndOnEnter:Bool = True 
	
	Field Angle:Float = 0.0
	Field Alpha:Float 	= 1.0'Main Alpha Value.
	Field Focus:Int		'0 - Standard ohne gfx effects , 1 - 

	Field ColorBackground:Int = 0'COLOR_WHITE
	Field AlphaCursor:Float 
	Field TimeLastCursorChange:Int
	Field TimeCursorChange:Int = 510
	Field PosCursor:Float
	
	Field AlignmentCaption:Int 
	
	Public 
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Caption:String = "",_Style:Int = 0)
		If MANIAC_DEBUG = True
			Maniac_Debug.addStoredBools(5)
			Maniac_Debug.addStoredInts(12)
			Maniac_Debug.addStoredFloats(1)
			Maniac_Debug.addStoredStrings(2)
			maniacID = Maniac_Debug.getNumberOfRegisteredObjects()
			Maniac_Debug.addRegisteredObject()
		Endif 
		
		X 		= _X
		Y 		= _Y
		W 		= _Width
		H 		= _Height
		Style 	= _Style
		Alpha = 1.0
		AlignmentCaption = ALIGNMENT_MIDDLE
	End Method 
	
		
	Public 
	Method Update:Int()
		If MOBox(X,Y,W,H) And TouchHit()
			ColorBackground += 1
		Endif 
	End Method
	
	
	Public 
	Method Draw()	
		'### Drawing Background ###
		SetAlpha Alpha
		Maniac_Color(ColorBackground)
		'SetColor 255,255,255
		DrawRect(X,Y,W,H)
		
		
		SetColor 125,125,125
		Drw_Rect(X,Y,W,H)
		
	End Method 
	
		
	Method setBackgroundColor:Void(_Color:Int)
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
		Endif
		ColorBackground = _Color
	End Method 
	
	Method getColor:Int()
		Return ColorBackground
	End Method

End Class