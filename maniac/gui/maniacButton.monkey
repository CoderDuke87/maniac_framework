#Rem monkeydoc Module maniac.maniacButton
This Class is a Button Gui Element.~n
Version: 1.0 alpha
ToDo: Sounds , GlowEffect~n
	Featurelist:~n
		- Introanimations, MouseOverEffects, OnClickAnimations, 4 Different Styles (BUTTON_STYLE_STD,BUTTON_STYLE_MODERN, BUTTON_STYLE_ROUND, BUTTON_STYLE_CIRCLE) ~n
		- Blinking,
		
Example:
<pre>

Function Main:Int()
	New Example							
	Return 0
End Function  
		
Class Example extends App

	field BtnTest:ManiacButton		'define a Button
	field BtnTest2:ManiacButton		'define another Button
	
	Method OnCreate:Int()
		SetUpdateRate( 60 )
		maniacInit()			' THIS INITS THE MANIAC FRAMEWORK! THIS NEED TO BE DONE BEFORE USING IT!!!!!
		
		
		BtnTest = New ManiacButton(DW*0.5,DH*0.6,DW*0.3,DH*0.1,"Rounded")	'Initialize the Button (constructor call "new")
		BtnTest.setStyle(BUTTON_STYLE_ROUND)								'Sets the Style; can be one of: BUTTON_STYLE_ROUND,BUTTON_STYLE_STD, BUTTON_STYLE_STDGLOW, BUTTON_STYLE_MODERN, BUTTON_STYLE_ROUND, BUTTON_STYLE_CIRCLE
		BtnTest.setAlignment(ALIGNMENT_RIGHT)
		BtnTest.setMouseOnClickAnim(True, false , True,false)
		
		BtnTest2 = New ManiacButton(DW*0.5,DH*0.6,DW*0.3,DH*0.1,"Rounded")
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
public



#rem ClassScheme
	Explain , Aufgabe,zweck etc.
	Params type,zweck,was passiert wenn falscher
	Return
	
	Author
	Datum
	Example
#end#

Const MANIAC_BUTTONSTYLE_PLAIN:Int 		= 1
Const MANIAC_BUTTONSTYLE_STANDARD:Int	= 2
Const MANIAC_BUTTONSTYLE_GAME:Int		= 3
Const MANIAC_BUTTONSTYLE_TAB:Int		= 4
Const MANIAC_BUTTONSTYLE_MENUE:Int		= 5
#rem monkeydoc

#end 
Class ManiacButton Extends cGuiBase

	Field BtnState:Int 	= -1
	
	Field ManiacButtonStyle:Int 
	Field ID:Int
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Text:String,_Style:Int = MANIAC_BUTTONSTYLE_STANDARD)  
		setGeo(_X,_Y,_Width,_Height)
		setText(_Text)
		Select _Style
			Case MANIAC_BUTTONSTYLE_PLAIN
			
			Case MANIAC_BUTTONSTYLE_STANDARD
				showFrame()
				setStyle(MANIAC_STYLE_STD)
				setText(_Text,ALIGNMENT_MIDDLE,ALIGNMENT_MIDDLEY )
				setColor_Text(COLOR_WHITE,COLOR_WHITE)
				setColor_BG(COLOR_BLUE,COLOR_GREEN,COLOR_RED)
				setColor_Frame(COLOR_YELLOW,COLOR_ORANGE,COLOR_BLACK)
			Case MANIAC_BUTTONSTYLE_GAME
			
			Case MANIAC_BUTTONSTYLE_TAB
			Print "Create TabStyle Button"
				setStyle(MANIAC_GUIBASE_STYLE_PLAIN)
				setText(_Text,ALIGNMENT_MIDDLE,ALIGNMENT_MIDDLEY )
				setColor_Text(COLOR_WHITE,COLOR_WHITE)
				setColor_BG(COLOR_BLUE,COLOR_GREEN,COLOR_RED)
				setColor_Frame(COLOR_YELLOW,COLOR_ORANGE,COLOR_BLACK)
				
				
			Case MANIAC_BUTTONSTYLE_MENUE
				showFrame()
				'setStyle(MANIAC_STYLE_STD)
				setOnClickAction(True, True )
				setText(_Text,ALIGNMENT_MIDDLE,ALIGNMENT_MIDDLEY )
				setColor_Text(COLOR_SCHEME_LPASTEL_BLUE_VERYDARK,COLOR_SCHEME_LPASTEL_BLUE_VERYDARK)
				setColor_BG(COLOR_SCHEME_LPASTEL_BLUE_BACKGROUND,COLOR_SCHEME_LPASTEL_BLUE_VERYBRIGHT,COLOR_BLUE)
				setColor_Frame(COLOR_SCHEME_LPASTEL_BLUE_DARK,COLOR_SCHEME_LPASTEL_BLUE_DARK,COLOR_SCHEME_LPASTEL_BLUE_DARK)
				

			Default
		End Select 
		
	End Method 
	
	
	Method Draw:int()
		drawBase()
	End Method 
	
	
	Method Update:Int()
		BtnState = -1
		Local ev:Int = updateBase()
		If isMO() = True
		
		Endif 
		If ev = GUIBASE_ANIMUPDATE_STATE_END
			BtnState = GUIBASE_ANIMUPDATE_STATE_END
			Return GUIBASE_ANIMUPDATE_STATE_END
		Endif 
	End Method 


	Method isAnimEnd:Bool()
		If BtnState = GUIBASE_ANIMUPDATE_STATE_END
			Return True 
		Else 
			Return false
		Endif 
	End Method 
	
	
	#rem monkeydoc
		This Method set's the ButtonStyle.
		A Style is a setting of behaviours, Colors and shape,Frame, OnClickanimation and so on...
		MANIAC_BTN_STYLE_STANDARD
	#end
	Method setButtonStyle:Void(_ManiacBtnStyle:Int)
		Select _ManiacBtnStyle
			Case MANIAC_BUTTONSTYLE_PLAIN
			case MANIAC_BUTTONSTYLE_STANDARD
			Case MANIAC_BUTTONSTYLE_GAME
			case MANIAC_BUTTONSTYLE_TAB
			Default
		End Select 
	
	End Method 
	
	
	Method isMO:Bool()
		Return getbMO()
	End Method 
End Class 