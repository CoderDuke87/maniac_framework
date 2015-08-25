#Rem monkeydoc Module maniac.maniacLowLevel
	Gui TabLane Modue-Version 1.0  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	
	This is the Maniac LowLevel Module.~n
	Functions in here should only be called by the Maniac Higher Level Functions.~n
	So the user shouldn't worry about the following Classes and Functions, unless he needs some special lowlevel Functions~n
	~n
	VERSION HISTORY: ~n
	1.0.0	@ 29.05.2015~n
		completed Documentation~n
		changed: extends now cGuiBase
	~n

	
	Implemented Feature: LowLevel
		
#End

Import maniac

Const ANIMTIME_LONG:Int = 1500
Const ANIMTIME_MIDDLE:Int	= 1000
Const ANIMTIME_SHORT:Int	= 500
'Const DISPOSE_NORTH:Int 	= 1	'## TOP ##
'Const DISPOSE_WEST:Int 	= 2		'## LEFT ##
'Const DISPOSE_SOUTH:Int 	= 3	'## BOTTOM ##
'Const DISPOSE_EAST:Int 	= 4	'## Right ##

Const DISPOSE_INDIVIDUAL_HORIZONTAL:Int = 5
Const DISPOSE_INDIVIDUAL_VERTICAL:Int = 6

#rem
Const ALIGNMENT_LEFT:Int 		= 1
Const ALIGNMENT_MIDDLE:Int 		= 2
Const ALIGNMENT_RIGHT:Int 		= 3
Const ALIGNMENT_TOP:Int 		= 4
Const ALIGNMENT_MIDDLEY:int 	= 5
Const ALIGNMENT_BOTTOM:Int 		= 6
#end 
Class ManiacTabLane Extends cGuiBase

	Field listTabs:List<ManiacButton>
	Field TabScheme:Int = 22'MANIAC_COLORSCHEME_LIGHTPASTEL
	Field Dispose:Int		'Noth,South,East,West
	Field Align:Int 		'Left,Middle,Right ; Top,Middle,Bottom

	Field BtnStyle:Int 
	Field currActive:Int 
	
	Field bWithAnim:Bool 	= False 
	
	Field tabHeight:Float
	'Private 
	 
	#rem monkeydoc
		This Function Creates a predefined Standard-Tab.
		Params: _Dispose:int << You can choose weather it shall be on Top,Left,Right, or Bottom of Screen.
				DISPOSE_NORTH,DISPOSE_WEST,DISPOSE_EAST,DISPOSE_SOUTH
	#end 
	Function CreateManiacTab_Standard:ManiacTabLane(_Dispose:int)
		Local nT:ManiacTabLane = New ManiacTabLane(_Dispose)
		nT.Align = ALIGNMENT_MIDDLE
		nT.BtnStyle = MANIAC_BUTTONSTYLE_TAB
		'nT.setStyle(MANIAC_GUIBASE_STYLE_PLAIN)
'		nT.setOnClickAction(False,False )
'		nT.setScheme(BtnStyle)MANIAC_COLORSCHEME_LIGHTPASTEL )
		nT.setOnClickAction(False,False )
		Return nT
	End Function 
	
	Function CreateManiacTab_Flat:ManiacTabLane(_Dispose:Int)
		Local nT:ManiacTabLane = New ManiacTabLane(_Dispose,0,0,DW,DH*0.05)
		nT.tabHeight = DH*0.05
		nT.Align = ALIGNMENT_MIDDLE
		nT.BtnStyle = MANIAC_BUTTONSTYLE_TAB

		nT.setOnClickAction(False,False )
		Return nT
	End Function 
	
	Method New(_Dispose:Int = DISPOSE_NORTH,_X:Float=0.0,_Y:Float=0.0,_Width:Float=DW*1,_Height:Float =DH*0.1)
		listTabs = New List<ManiacButton>
		Dispose = _Dispose
		'Align = ALIGNMENT_MIDDLE
		'disposal= TAB_DISPOSAL_MIDDLE
		'TabScheme = MANIAC_COLORSCHEME_LIGHTPASTEL
		'setScheme(MANIAC_COLORSCHEME_LIGHTPASTEL )
		'setOnClickAction(False,False )
		'setVisible(False)
		Select _Dispose
			Case DISPOSE_NORTH		'## TOP ##
				setGeo(DW*0.5,_Height*0.5+2,_Width,_Height)
				
			Case DISPOSE_WEST		'## LEFT ##
			#rem
				Width = DW*0.08
				Height = DH
				X = 0
				Y = 0
				'sHeight = DH*0.6
				'sWidth = DW*0.08
				#end 
				setGeo(0,DH*0.5+2,DW*0.08,DH)
			Case DISPOSE_SOUTH	'## BOTTOM ##
			#rem
				Width = DW
				Height = DH*0.08
				X = 0
				Y = DH*0.92
				#end 
			Case DISPOSE_EAST	'## Right ##
			#rem
				Width = DW*0.08
				Height = DH
				X = DW*0.92
				Y = 0
				#end
			Case DISPOSE_INDIVIDUAL_HORIZONTAL
			#rem
				Width = _Width
				Height = _Height
				X = _X
				Y = _Y
				oX = _X
				oY = _Y
				#end 
			Case DISPOSE_INDIVIDUAL_VERTICAL
			#rem
				Width = _Width
				Height = _Height
				X = _X
				Y = _Y
			 #end
		End Select
	End Method 
	
	Method Update:Int()
		updateBase()
		
		
		For Local oB:ManiacButton = Eachin listTabs
			Local ev:Int = oB.Update() 
		Next
		
		If TouchHit()
			low_CheckForMouseOver()
			
			'Print "Set Active ID to: " + currActive
		End If 
		
		
		
		
	End Method
	
	Method Draw:Int()
		drawBase()
		SetAlpha 1
			'
			'If ManiacColorScheme > 0
			'	Maniac_Color(colorBackground)
			'Else
				SetColor 89,30,240
			'Endif 
			DrawRect(getX()-getWidth()/2,getY()-getHeight()/2,getWidth(),getHeight())
			
			For Local oB:ManiacButton = Eachin listTabs
				oB.Draw()
			Next
	End Method 
	
	#rem
		Adds a new Tab to the TabLine.
		It is recommended to set a specified ID, if not, the Tabs will get the ID's by the order of adding, beginning from 0.
	#end
	Method addTab(_Caption:String,_ID:Int = -1)
		Local nX:Float
		Local nY:Float
		Local w:Float
		Local h:Float 
		
		Local oB:ManiacButton
		
		
		
		Select TabScheme
			Case MANIAC_COLORSCHEME_LIGHTPASTEL
				oB = New ManiacButton(0,	0,  DW*0.1,	DH*0.07,_Caption,BtnStyle)
				'oB.setScheme(MANIAC_COLORSCHEME_LIGHTPASTEL)
				oB.setStyle(MANIAC_STYLE_MODERN2)
				
				Print "Created Tab_TabScheme"
				'oB.setGlow(False)
				'oB.setMouseOverEffects(True  )
				'oB.setMouseOnClickAnim(True, False ,False,True)
				
			Default 
				Print "Created Tab default /BtnStyle: " + BtnStyle
				oB = New ManiacButton(0,	0,  DW*0.1,	tabHeight*0.9,_Caption,MANIAC_BUTTONSTYLE_TAB)
				'oB.setText(_Caption)
				'oB.setGlow(False)
			'	oB.setMouseOverEffects(True  )
				'oB.setMouseOnClickAnim(True, False ,False,True)
		End Select 

		If _ID = -1
			oB.setID(listTabs.Count())
		Else
			oB.setID(_ID)
		Endif 
		listTabs.AddLast(oB)
		
		reOrder()
	End Method 
	
	
	Method reOrder()
		Select Dispose
			#rem
			Case TAB_ALIGN_INDIVIDUALHORIZONTAL
				Print "align indihoriz"
				Select disposal
					Case TAB_DISPOSAL_MIDDLE
						Local nrTabs:Int = listTabs.Count()
						Local maxW:Float = (DW*0.8-nrTabs*15+15)/(nrTabs) 'DW * 0.2
						Local x:Float = X+maxW/2-7+DW*0.1
						Local dist:Int = 15
						Local h:Float = DH*0.065
						Local y:Float = Y+Height/2
						Print "y = " + y +"  || Y:"+Y +" and height/2 :" + (Height/2)
						Local i:Int = 0
						For Local oB:ManiacButton = Eachin listTabs
							oB.setOrigPosition( (x+dist)+i*(maxW+dist),y )
							oB.setPosition( (x+dist)+i*(maxW+dist) , y )
							oB.setSize(maxW,Height*0.8)
							oB.setOrigSize(maxW,Height*0.8)
							i += 1
						Next 
					Case TAB_DISPOSAL_LEFT
					Case TAB_DISPOSAL_RIGHT
				
				End Select
				#end 
			Case DISPOSE_NORTH		'TOP
				Select Align
					Case ALIGNMENT_LEFT

					Case ALIGNMENT_MIDDLE
						Local nrTabs:Int = listTabs.Count()
						Local maxW:Float = (DW*0.8-nrTabs*15+15)/(nrTabs) 'DW * 0.2
						Local x:Float = maxW/2-7+DW*0.1
						Local dist:Int = 15
						Local h:Float = tabHeight*0.8
						Local y:Float = tabHeight/2+2
						Local i:Int = 0
						For Local oB:ManiacButton = Eachin listTabs
							oB.setOrigPosition( (x+dist)+i*(maxW+dist),y )
							oB.setPosition( (x+dist)+i*(maxW+dist) , y )
							oB.setSize(maxW,h)
							oB.setOrigSize(maxW,h)
							
							i += 1
						Next 
					
					Case ALIGNMENT_RIGHT
				
				End Select
				
			Case DISPOSE_WEST		'LEFT
				Select Align
					Case ALIGNMENT_MIDDLE		'All Tabs will be placed in the middle
					#rem
						'Local tWidth:Float = sWidth
						If sHeight > DH
							sHeight = DH
						Endif 
						Local tHeight:Float = ll_Width(sHeight,listTabs.Count(),5)
						Local x:Float = tWidth/2 + 3
						Local y:Float = (DH-sHeight)/2 + tHeight/2
						Local i:Int = 0
						For Local oB:ManiacButton = Eachin listTabs
							oB.setOrigPosition( x,y+i*(tHeight+5) )
							oB.setPosition( x, y+i*(tHeight+5) )
							oB.setSize(tWidth,tHeight)
							oB.setOrigSize(tWidth,tHeight)
							i += 1
						Next
						#end
					Case TAB_DISPOSAL_ALL			'Tabs will use the whole Length/Width
					#rem
						Local tWidth:Float = sWidth
						Local tHeight:Float = ll_Width(DH,listTabs.Count(),5)
						Local x:Float = tWidth/2 + 3
						Local y:Float = 0 + tHeight/2
						Local i:Int = 0
						For Local oB:ManiacButton = Eachin listTabs
							oB.setOrigPosition( x,y+i*(tHeight+5) )
							oB.setPosition( x, y+i*(tHeight+5) )
							oB.setSize(tWidth,tHeight)
							oB.setOrigSize(tWidth,tHeight)
							i += 1
						Next 
						#end 
					Case ALIGNMENT_TOP
					#rem
						Local tWidth:Float = sWidth
						Local tHeight:Float = ll_Width(sHeight,listTabs.Count(),5)
						Local x:Float = tWidth/2 + 3
						Local y:Float = 0 + tHeight/2
						Local i:Int = 0
						For Local oB:ManiacButton = Eachin listTabs
							oB.setOrigPosition( x,y+i*(tHeight+5) )
							oB.setPosition( x, y+i*(tHeight+5) )
							oB.setSize(tWidth,tHeight)
							oB.setOrigSize(tWidth,tHeight)
							i += 1
						Next 
						#end 
					Case ALIGNMENT_BOTTOM
					#rem
						Local tWidth:Float = sWidth
						Local tHeight:Float = ll_Width(sHeight,listTabs.Count(),5)
						Local x:Float = tWidth/2 +3
						Local y:Float = 0 + tHeight/2
						Local i:Int = 0
						For Local oB:ManiacButton = Eachin listTabs
							oB.setOrigPosition( x,y+i*(tHeight+5) )
							oB.setPosition( x, y+i*(tHeight+5) )
							oB.setSize(tWidth,tHeight)
							oB.setOrigSize(tWidth,tHeight)
							i += 1
						Next
						#end 
				End Select 
			Case DISPOSE_EAST	'RIGHT
				
			Case DISPOSE_SOUTH	'Bottom
				Select Align
					Case ALIGNMENT_MIDDLE
						Local maxW:Float = DW * 0.2
						Local x:Float = maxW/2
						Local dist:Int = 15
						Local h:Float = DH*0.05
						Local y:Float = DH-DH*0.08/2
						Local i:Int = 0
						For Local oB:ManiacButton = Eachin listTabs
							oB.setOrigPosition( (x+dist)+i*(maxW+dist),y )
							oB.setPosition( (x+dist)+i*(maxW+dist) , y )
							oB.setSize(maxW,h)
							oB.setOrigSize(maxW,h)
							i += 1
						Next 
						Print "Bottom"
					Case ALIGNMENT_LEFT
					Case ALIGNMENT_RIGHT
				
				End Select
		End Select
	End Method 
	
	#rem
		Starts an 'Wave-In' Animation automatically sticked to it's Align.
	#end 
	Method startAnimWaveIn:Void()
		Select Align
			Case TAB_ALIGN_TOP 'TOP
				Local i:Int = 0
				For Local oB:ManiacButton = Eachin listTabs
					oB.startAnimDrop(-DH*0.2,AnimTime+200*i,"Back","Out")
					i+=1
				Next
			Case TAB_ALIGN_LEFT 'Left
				Local i:Int = 0
				For Local oB:ManiacButton = Eachin listTabs
					oB.startAnimSlide(-DW*0.5,AnimTime+200*i,"Back","Out")'startAnimDrop(_fromY,_AnimTime,_Style,_Ease)
					i+=1
				Next
			Case TAB_ALIGN_RIGHT
				Local i:Int = 0
				For Local oB:ManiacButton = Eachin listTabs
					oB.startAnimSlide(DW*1.5,AnimTime+200*i,"Back","Out")'startAnimDrop(_fromY,_AnimTime,_Style,_Ease)
					i+=1
				Next
			Case TAB_ALIGN_BOTTOM
				Local i:Int = 0
				For Local oB:ManiacButton = Eachin listTabs
					oB.startAnimDrop(DH*1.2,AnimTime+200*i,"Back","Out")
					i+=1
				Next
		End Select 
	End Method 
	
	
	Method getCurrActiveID:Int()
		Return currActive
	End Method 
	
	Method getCurrMouseOver:Int()
		Return currActive
	End Method 
	
	Method mPrintTabs:Void()
		For Local oB:ManiacButton = Eachin listTabs
			Print "Button: " + oB.getID + " | " + oB.getText()
		Next 
	End Method 
	
	
	
	Method low_CheckForMouseOver:int()
		For Local oB:ManiacButton = Eachin listTabs 
			If oB.isMO()
				currActive = oB.getID()
				Return currActive
			Endif 
		Next
		
		currActive = -1
	End Method 
End Class


#rem

	If oB.getbMO()
				If TouchHit()
					Print "Touched BtnID: " + oB.ID
				Endif 
				
				If gl_mousereleased
					Print "Released BtnID: " + oB.ID
				Endif 
			Endif 
			If  ev = GUIBASE_MOUSESTATE_MOUSEOVER
				If gl_mousereleased = True
					Print oB.ID
					If bWithAnim = True 
						
					Else
						currActive = oB.ID
						Print currActive
						Return oB.ID
					Endif 
					Return -1
				Endif 
				Return -1
			Endif 
			If ev = GUIBASE_ANIMUPDATE_STATE_END
				'Print "return ID: " + oB.ID
				currActive = oB.ID
				Return oB.ID
			Endif
#end 