Import mojo
Import maniac

#GLFW_USE_MINGW=True

#GLFW_WINDOW_TITLE="GalleryViewer Example"
#GLFW_WINDOW_WIDTH=600
#GLFW_WINDOW_HEIGHT=800
#GLFW_WINDOW_SAMPLES=0
#GLFW_WINDOW_DECORATED=False 
#GLFW_WINDOW_RESIZABLE=False
#GLFW_WINDOW_FULLSCREEN=false  

#GLFW_SWAP_INTERVAL=-1

#OPENGL_GLES20_ENABLED=false
#OPENGL_DEPTH_BUFFER_ENABLED=false

#MOJO_AUTO_SUSPEND_ENABLED=True
#MOJO_IMAGE_FILTERING_ENABLED=True

#TEXT_FILES="*.txt|*.xml|*.json"
#IMAGE_FILES="*.png|*.jpg"
#SOUND_FILES="*.wav|*.ogg"
#MUSIC_FILES="*.wav|*.ogg"
#BINARY_FILES="*.bin|*.dat"


 

Function Main:Int()
	New Example							
	Return 0
End


Class Example Extends App
	Field bEnter:Bool = True
	Field bLeave:Bool = False 
	
	Field TabTest:ManiacTabLane 
	Field BtnTest:ManiacButton
	Field BtnStandard:ManiacButton
	Field BtnModern:ManiacButton
	Field BtnCircle:ManiacButton
	
	Method OnCreate:Int()
		SetUpdateRate( 60 )
		maniacInit()
		BtnStandard = New ManiacButton(DW*0.5,DH*0.2,DW*0.3,DH*0.1,"Standard")
		BtnStandard.setStyle(BUTTON_STYLE_STD)
		BtnStandard.setMouseOnClickAnim(True, false , false,true)
		BtnModern = New ManiacButton(DW*0.5,DH*0.4,DW*0.3,DH*0.1,"Modern")
		BtnModern.setStyle(BUTTON_STYLE_MODERN)
		BtnModern.setAlignment(ALIGNMENT_LEFT)
		BtnModern.setMouseOverEffects(True )',_isBrightening:Bool=False,_isWobbling:Bool = False )
		BtnTest = New ManiacButton(DW*0.5,DH*0.6,DW*0.3,DH*0.1,"Rounded")
		BtnTest.setStyle(BUTTON_STYLE_ROUND)
		BtnTest.setAlignment(ALIGNMENT_RIGHT)
		BtnTest.setMouseOnClickAnim(True, false , True,false)
		BtnCircle = New ManiacButton(DW*0.5,DH*0.8,DW*0.15,DW*0.15,"Circle")
		BtnCircle.setStyle(BUTTON_STYLE_CIRCLE)
		
		TabTest = New ManiacTabLane
		TabTest.addTab("Buttons")
		TabTest.addTab("Inputs")
		
	End Method
	
	Method OnUpdate:Int()
		If maniacUpdate() = True
		
		Else
			If bEnter = True
				BtnStandard.startAnimDrop(-DH*0.2,1500,"Back","Out")
				BtnModern.startAnimPopOut(1500,"Back","Out")
				BtnTest.startAnimRoll(-DW*0.3,1800,6,"Back","Out")
				TabTest.startAnimDrop(-DH*0.4,2500,"Back","Out")
				bEnter = False 
			Endif 
			
			If bLeave = True
				'BtnStandard.endAnimDrop(-DH*0.3,1500,"Back","InOut")'startAnimDrop(-DH*0.2,1500,"Back","Out")
				'BtnModern.endAnimPopOut(1500,"Back","InOut")
				'BtnTest.endAnimRoll(-DW*0.3,2000,-3,"Back","InOut")
				'TabTest.startAnimDrop(-DH*0.4,2500,"Back","Out")
				bLeave = False 
			Endif 
			If BtnStandard.Update() = 101 And gl_mousereleased
				bLeave = True 
			Endif 
			BtnModern.Update()
			BtnTest.Update()
			BtnCircle.Update()
			Local ev:Int = TabTest.Update()
			If ev = 0
				bEnter = true
			Endif
			
			If ev = 1
				bEnter = True 
			Endif 
		Endif 
	End Method
	
	Method OnRender:Int()
		Cls
		If mInit = True
		
		Else
			BtnTest.Draw()
			BtnStandard.Draw()
			BtnModern.Draw()
			BtnCircle.Draw()
			TabTest.Draw()
		Endif 
		
		maniacDraw()
	End Method 

End Class 