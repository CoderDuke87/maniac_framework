#rem
	Copyright (C) 29.1.2015  Stephan Duckerschein
	
	This Example Shows how to Use the Tabs!
	
	
#end 


Import mojo
Import maniac

#GLFW_USE_MINGW=True
#GLFW_WINDOW_TITLE="Example DropDown"
#GLFW_WINDOW_WIDTH=600
#GLFW_WINDOW_HEIGHT=800
#GLFW_WINDOW_SAMPLES=0
#GLFW_WINDOW_DECORATED=true 
#GLFW_WINDOW_RESIZABLE=False
#GLFW_WINDOW_FULLSCREEN=false  
#GLFW_SWAP_INTERVAL=-1

#OPENGL_GLES20_ENABLED=false
#OPENGL_DEPTH_BUFFEFalseBLED=false

#MOJO_AUTO_SUSPEND_ENABLED=True
#MOJO_IMAGE_FILTERING_ENABLED=false

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
	
	Field tabs:ManiacTabLane
	
	Field RG_RadioGroup:ManiacRadioGroup
	
	Field Btn_initTab:ManiacButton
	Field State:Int 
	
	#rem
		This Method will be called, when Your App starts.
	#end 
	Method OnCreate:Int()
		SetUpdateRate( 60 )
		initManiac(true)		'IMPORTANT: ALWAYS CALL THIS FUNCTION IF YOU WANT TO USE THE MANIAC FRAMEWORK ; PARAM: TRUE - DEBUG ON ; FALSE: DEBUG OFF
		
		tabs = New ManiacTabLane(0)
		tabs.addTab("Tab 1")
		tabs.addTab("Tab 2")
		
		RG_RadioGroup = New ManiacRadioGroup(DW*0.1,DH*0.3,DW*0.4,DH*0.4,"RadioGroup")
		RG_RadioGroup.addChoice("Choice 1", 1)
		RG_RadioGroup.addChoice("Choice 2", 22)
		RG_RadioGroup.addChoice("Choice 3", 34)
		RG_RadioGroup.addChoice("Choice 4", 34)
		RG_RadioGroup.addChoice("Choice 5", 34)
		
		Btn_initTab = New ManiacButton(DW*0.25,DH*0.18,DW*0.15,DH*0.05,"Init Tab",ALIGNMENT_MIDDLE,COLOR_BLUE,false)
		Btn_initTab.setBackground(True,5)
	End Method 
	
	Method OnUpdate:Int()
		maniacUpdate()			'IMPORTANT: MAKE SURE TO CALL THIS FUNCTION ONCE PER UPDATE !!!
		
		'tabState << if one of the Button is Released it returns it ID
		Local tabState:Int = tabs.Update()
		
		If tabState <> -1
			State = tabState
		Endif 
			
		Select State
			Case 0
				RG_RadioGroup.Update()
				Btn_initTab.Update()
			Case 1
		End Select
		
		If KeyHit(KEY_ESCAPE)
			Error ""
		Endif 
		
	End Method
	
	Method OnRender:Int()
		Cls
		
		'### Background ###
		SetColor 135,206,250
		DrawImage MANIAC_IMG_BACKGROUND ,0,0 ,0 ,DW/MANIAC_IMG_BACKGROUND.Width(),DH/MANIAC_IMG_BACKGROUND.Height()
		
		tabs.Draw()
		
		Select State
			Case 0
				RG_RadioGroup.Draw()
				Btn_initTab.Draw()
			Case 1
		End Select 
		
		DrawText "State: " + State,DW*0.5,DH*0.5
		
		If MANIAC_DEBUG = True 
			MANIAC_FPSGRAPH.Draw()
		Endif
	End Method 

End Class 