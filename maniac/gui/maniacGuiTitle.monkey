#Rem monkeydoc Module maniac.gui.maniacGuiTitle
	Gui-Title Module - Version 1.0 (rv1)  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	~n
	All Gui_Objects will be extended by GuiBase~n
	It brings with some Anim,ColorScheme & stuff feature.~n
	
	
#End
Import maniac


#Rem monkeydoc
	This Class is a Title Gui Element.~n
	User specific Title with Coloured Characters
	~n
	Featurelist:~n
		- Scaleable, Underline (On/Off)~n
		
	Example:
	<pre>
		Global tB:ManiacButton = new ManiacButton(100,100,300,32)

		Function Main:Int()
			New Example							
			Return 0
		End Function  
	</pre>
#end
Class ManiacTitle 
	Field X:Float,Y:Float 
	Field Scale:Float = 2.4
	Field strArray:String[]
	Field strArrayColor:Int[]
	Field NrChars:Int 
	
	Field bLined:Bool = false 
	
	Method New(_X:Float,_Y:Float)
		X =_X
		Y =_Y
		strArray = New String[30]
		strArrayColor = New Int[30]
	End Method 
	
	Method Draw()
		ScaleAt(X, Y, Scale, Scale)
		Local pos:Float = 0
		For Local i:Int = 0 Until NrChars
			Maniac_Color(strArrayColor[i])
			MANIAC_FONT.Wrap(strArray[i],X + pos,Y,100,100,1)
			pos += MANIAC_FONT.getW(strArray[i])
		Next 
		
		ResetMatrix()
		
		If bLined = True
			DrawLine(X,Y+getHeight()-5,X+getWidth(),Y+getHeight()-5)
		Endif 
	End Method
	
	Method addChar:Void(_Character:String,_Color:int)
		strArray[NrChars] = _Character
		strArrayColor[NrChars] = _Color
		NrChars +=1
	End Method 
	
	Method setScale(_Scale:Float)
		Scale = _Scale
	End Method 
	
	Method getWidth:Float()
		Local pos:Float = 0
		For Local i:Int = 0 Until NrChars
			'Maniac_Color(strArrayColor[i])
			'MANIAC_FONT.Wrap(strArray[i],X + pos,Y,100,100,1)
			pos += MANIAC_FONT.getW(strArray[i])*Scale
		Next
		Return pos
	End Method 
	
	Method getHeight:Float()
		Return MANIAC_FONT.getH()*Scale
	End Method
End Class 

#Rem monkeydoc
	This Class is a Title Gui Element.~n
	User specific Title with Coloured Characters
	~n
	Featurelist:~n
	~n
		
	Example:
	<pre>
		Global tB:ManiacButton = new ManiacButton(100,100,300,32)

		Function Main:Int()
			New Example							
			Return 0
		End Function  
	</pre>
#end
Class ManiacTitle2 Extends cGuiBase
	Field listCharacter:List<ManiacLetter>
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float)  
		setGeo(_X,_Y,_Width,_Height)
		setVisible(false)
		listCharacter = New List<ManiacLetter>
	End Method 
	
	
	Method Draw:Void()
		drawBase()
		
		For Local oC:ManiacLetter = Eachin listCharacter
			oC.Draw()
			'oC.doDrawText()
		Next 
	End Method
	
	Method Update:Int()
		updateBase()
		
		For Local oC:ManiacLetter = Eachin listCharacter
			oC.Update()
		Next
	End Method 
	
	
	Method addCaharcter(_Char:String)
		Local oB:ManiacLetter = New ManiacLetter(_Char)
		
		listCharacter.AddLast(oB)
		reOrder()
	End Method 
	
	
	Method reOrder:Void()
		Local nrTabs:Int = listCharacter.Count()
		Local maxW:Float = ll_Width(getWidth(),nrTabs,3)'(oWidth-nrTabs*15+15)/(nrTabs) 'DW * 0.2
		Local x:Float = getX()+maxW/2-7+DW*0.1
		Local dist:Int = 3
		Local h:Float = getHeight()
		Local y:Float = getY()+getHeight()/2
		'Print "y = " + y +"  || Y:"+Y +" and height/2 :" + (Height/2)
		Local i:Int = 0
		For Local oB:ManiacLetter = Eachin listCharacter
			oB.setOrigPosition( (x+dist)+i*(maxW+dist),y )
			oB.setPosition( (x+dist)+i*(maxW+dist) , y )
			oB.setSize(maxW,getHeight()*0.8)
			oB.setOrigSize(maxW,getHeight()*0.8)
			i += 1
		Next
	End Method 
	
	
	Method startAnimWaveInPopOut()
		Local i:Int = 0
		For Local oB:ManiacLetter = Eachin listCharacter
			oB.startAnimPopOut(3000+200*i,"Back","Out")'startAnimDrop(-DH*0.2,AnimTime+200*i,"Back","Out")
			i+=1
		Next
	End Method 

End Class 

Private 
Class ManiacLetter Extends cGuiBase

	Method New(_Char:String)  
		setColor_Text(COLOR_BROWN,COLOR_BROWN,COLOR_BROWN)
		setText(_Char)
		setAlpha(0.0)	
		setVisible(True)
		setWrapTextToSize(True)
	End Method 
	
	Method Draw:Void()
		drawBase()
	End Method 
	
	Method Update:Int()
		updateBase()
	End Method 

End Class 