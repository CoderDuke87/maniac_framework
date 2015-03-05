
Import maniac


Class ManiacTabLane

	Field Align:Int = 0	'0-Top,1-Left,2-Bottom,3-Right
	Field disposal:Int 	= 0		'0 - from (resp. top) corner , with maxWidth and distance ; 1 - middle ,Buttons will be Wraped, 2 - middle, Button keep maxWidth , 3 - Right / Bottom 
	Field listTabs:List<ManiacButton>
	
	Field Width:Float
	Field Height:Float 
	Field X:Float,oX:Float
	Field Y:Float,oY:Float 
	Field bOpen:Bool = True 	'true - it will be Shown ; 'false it shows only a hint to open or Something ...
	
	'Tweener for position Stuff
	Field tweenY:Tween
	Field tweenX:Tween
	Field tweenAngle:Tween
	'##### ANIMATION STUFF #####
	Field AnimEffect:Int
	Field bRunningAnimation:Bool 	= False 
	Field AnimStartTime:int		
	Field AnimTime:int
	Field bBack:Bool = True 
	
	Method New(_Align:Int = 0 )
		listTabs = New List<ManiacButton>
		Select _Align
			Case 0		'## TOP ##
				Width = DW
				Height = DH*0.08
				X = 0
				oX = 0
				Y = 0
				oY = 0
			Case 1		'## LEFT ##
				Width = DW*0.08
				Height = DH
				X = 0
				Y = 0
				
			Case 2	'## BOTTOM ##
				Width = DW
				Height = DH*0.08
				X = 0
				Y = DH*0.92
				
			Case 3	'## Right ##
				Width = DW*0.08
				Height = DH
				X = DW*0.92
				Y = 0
		End Select
		
	End Method 
	
	Method addTab(_Caption:String)
		Local nX:Float
		Local nY:Float
		Local w:Float
		Local h:Float 
		
		Local oB:ManiacButton = New ManiacButton(0,	0,  DW*0.1,	DH*0.07,_Caption,  ALIGNMENT_MIDDLE,COLOR_BLUE,True,1)
		oB.setGlow(False)
		oB.ID = listTabs.Count()
		listTabs.AddLast(oB)
		
		reOrder()
	End Method 
	
	Method Draw:Void()
		If bOpen = True 
			SetAlpha 0.5
			SetColor 89,30,240
			DrawRect(X,Y,Width,Height)
			
			For Local oB:ManiacButton = Eachin listTabs
				oB.Draw()
			Next 
			
			If bBack = True
				'DrawImage MANIAC_IMG_ICO_BACK , DW*0.9,Height*0.1,0,DW*0.1/MANIAC_IMG_ICO_BACK.Width(),(Height*0.8)/MANIAC_IMG_ICO_BACK.Height()
			Endif 
		Else
		
		Endif 
	End Method
	
	Method Update:Int()
		For Local oB:ManiacButton = Eachin listTabs
			If oB.Update() = 101
				If gl_mousereleased = True
					Return oB.ID
				Endif 
			Endif 
		Next 
		'### Animation Effects ###
		If bRunningAnimation = True
		
			'Check if AnimationTime is Over
			If Millisecs() - AnimStartTime > AnimTime
				bRunningAnimation = False   
			Endif
			
			
			'If not, calculate the next Position Stuff
			Select AnimEffect
				Case ANIM_DROP
					tweenY.Update()
					Y = tweenY.Value()
					 
				Case ANIM_FADE
				Case ANIM_ROTATE
				Case ANIM_ROLL
					tweenX.Update()
					tweenAngle.Update()
					'Angle = tweenAngle.Value()
					X = tweenX.Value()
				Case ANIM_SLIDE
					tweenX.Update()
					X = tweenX.Value()
					
				Case ANIM_CIRCLE
					tweenY.Update()
					tweenX.Update()
					
					X = tweenX.Value()
					Y = tweenY.Value()
					
				Case ANIM_POPOUT
					tweenX.Update()
					tweenY.Update()
					'setSize(tweenX.Value(),tweenY.Value())
					
			End Select 
			
			
		Endif
		Return -1
	End Method 
	
	Method reOrder()
		Select Align
			Case 0
				Select disposal
					Case 0
						Local maxW:Float = DW * 0.2
						Local x:Float = maxW/2
						Local dist:Int = 15
						Local h:Float = DH*0.05
						Local y:Float = DH*0.08/2
						Local i:Int = 0
						For Local oB:ManiacButton = Eachin listTabs
							oB.setOrigPosition( (x+dist)+i*(maxW+dist),y )
							oB.setPosition( (x+dist)+i*(maxW+dist) , y )
							oB.setSize(maxW,h)
							oB.setOrigSize(maxW,h)
							i += 1
						Next 
					Case 1
					Case 2
					Case 3
				
				End Select
			Case 1
			Case 2
			Case 3
		End Select
	End Method 
	
	Method startAnimDrop(_fromY:Float,_AnimTime:Int = 1500,_Style:String = "Bounce",_Ease:String = "Out")
	
		tweenY = ll_Tween(_Style,_Ease,_fromY,oY,_AnimTime )
		tweenY.Start()
		bRunningAnimation = True 
		AnimStartTime = Millisecs()
		AnimTime = _AnimTime
		AnimEffect = ANIM_DROP
		For Local oB:ManiacButton = Eachin listTabs
			oB.startAnimDrop(_fromY,_AnimTime,_Style,_Ease)
		Next
		
	End Method
	Method startAnimIntro()
	
	End Method 
	
	Method getHeight:Float()
		Return Height
	End Method 
End Class 