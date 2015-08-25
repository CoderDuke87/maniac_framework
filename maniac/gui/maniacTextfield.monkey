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

Class ManiacTextfield
	Private 
	Field maniacID:Int 
	Field ID:Int
	Field inputString:String = ""
	Field Caption:String = ""
	Field X:Int,Y:Int
	Field W:Int,H:int
	
	Field Style:Int  
	Field bHide:Bool = False 
	
	Field bShowButton:Bool 	= False 
	Field bShowCaption:Bool
	Field bWrapHeight:Bool = False 
	public
	Field bEditing:Bool = False 
	private
	Field bEndOnEnter:Bool = True 
	
	Field Angle:Float = 0.0
	Field Alpha:Float 	= 1.0'Main Alpha Value.
	Field Focus:Int		'0 - Standard ohne gfx effects , 1 - 

	Field ColorBackground:Int = 8'COLOR_WHITE
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
		Caption = _Caption
		Alpha = 1.0
		AlignmentCaption = ALIGNMENT_MIDDLE
	End Method 
	
		
	Public 
	Method Update:Int()
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
		Endif 

		'### Check for Wrapping ###
		If bWrapHeight = True
			H = 30
		Endif 
		
		'### Check for Click 
		If bShowButton = True 
			If TouchHit()
				If MOBox(X,Y,(W*0.15),(H*1.0))
					If bEditing = True
						bEditing = False
						Return 99
					Else
						bEditing = True
						#If TARGET="android"
							EnableKeyboard()
						#Endif 
					Endif 
				Endif 
			Endif
			
		Else 
			If TouchHit()
				If MOBox(X,Y,(W),(H))
					If bEditing = True
						bEditing = False
					Else
						bEditing = True
						#If TARGET="android"
							EnableKeyboard()
						#Endif 
						
					Endif 
				Endif 
			Endif
		Endif 
		
		If bEditing = True 
			'### Updating the Cursor Alpha
			If (Millisecs() - TimeLastCursorChange ) > TimeCursorChange
				TimeLastCursorChange = Millisecs()
				If AlphaCursor > 0.8
					AlphaCursor = 0.05
				Else
					AlphaCursor = 1.0
				Endif 
			
			Endif 
			'### Updating the KeyboardInput
			Repeat  
				Local char=GetChar()
		        If Not char Exit
		            		
		        If char>=32
		            inputString+=String.FromChar( char )
		        Endif
		           
		        If char = CHAR_ENTER
		        	#If TARGET="android"
						DisableKeyboard()
					#Endif 
					If bEndOnEnter = True
						bEditing = False
					Endif 
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
		
		'### Rotate The Matrix at the MidX/MidY Position around Angle
		If Angle <> 0.0
			RotateAt(X+W/2,Y+H/2, Angle)
		Endif 
	
		'### Drawing Background ###
		SetAlpha Alpha
		Maniac_Color(ColorBackground)
		'SetColor 255,255,255
		DrawRect(X,Y,W,H)
		
		'### Drawing an Explaining Text to the Textfield ...
		'ToDo: - Alignment (Top,Bottom), Color
		SetColor 255,255,255
		'MANIAC_FONT.Wrap(Caption,X,Y-(ManiacFont.getH()+5),W,H,Caption.Length())
		Drw_ManiacText(Caption,X,Y-(ManiacFont.getH()+5),W,H,ALIGNMENT_MIDDLE,ALIGNMENT_MIDDLEY,1.0)		
		'### Drawing an "Fertig"-Button ... if pressed, its same like "I'm Done with text, it will disable the Keyboard (for Android)
		If bShowButton = True 
			'DrawImage MANIAC_IMG_EDITICON,X,Y,0,(W*0.15)/MANIAC_IMG_EDITICON.Width(),(H*1.0)/MANIAC_IMG_EDITICON.Height()
		Endif 
		
		'### Drawing the Input Text String ###
		SetColor 0,0,0
		Local cursorPos:Float 
		If bShowButton = True 
		
			MANIAC_FONT.Wrap(inputString,X+W*0.15,Y+H/2-ManiacFont.getH()/2,W,H,inputString.Length())
		Else
			'MANIAC_FONT.Wrap(inputString,X,Y+H/2-ManiacFont.getH()/2,W,H,inputString.Length())
			cursorPos = Drw_ManiacText(inputString,X,Y,W,H,AlignmentCaption)
		Endif 
		
		'### Drawing the Cursor ###
		If bEditing = True 
			Local iw:Int = MANIAC_FONT.getW(inputString)
			SetAlpha AlphaCursor
			MANIAC_FONT.Wrap("|",cursorPos,Y+H/2-ManiacFont.getH()/2,W,H,2)
		Endif 
		
		'### Draw the Frame around the Textfield
		SetAlpha Alpha 
		If bEditing = True
			SetColor 0,255,0
		Else	
			SetColor 75,75,75
		Endif 
		Drw_Rect(X,Y,W,H,1)
		
		'### Reset The MAtrix
		If Angle <> 0.0
			ResetMatrix()
		Endif 
	End Method 
	
	
	#rem
		This Method is deprecatded.
		It will be deleted in ver 1.0
	#end
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
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
		Endif
		Return inputString
	End Method 
	
	Method setText(itext:String)
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
		Endif
		inputString = itext
	End Method 
	
	Method setAlpha(_Value:Float)
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
		Endif
		Alpha = _Value
	End Method 
	
	Method setWrapHeight(_Bool:Bool = True)
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
		Endif
		bWrapHeight = _Bool
	End Method 
	
	Method setBackgroundColor:Void(_Color:Int)
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
		Endif
		ColorBackground = _Color
	End Method 
	
	Method setCaption(_Text:String)
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotCall()
		Endif
		Caption = _Text
	End Method 
	
	Method setHide(_Bool:Bool)
	
	End Method 
End Class