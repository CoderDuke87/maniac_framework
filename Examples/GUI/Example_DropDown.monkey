#rem
	Copyright (C) 20.1.2015  Stephan Duckerschein
	
	This Example Shows how to Use the DropdownMenu!
	
	
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
	
	
	#rem
		This Method will be called, when Your App starts.
	#end 
	Method OnCreate:Int()
		SetUpdateRate( 60 )
		initManiac(False)		'IMPORTANT: ALWAYS CALL THIS FUNCTION IF YOU WANT TO USE THE MANIAC FRAMEWORK ; PARAM: TRUE - DEBUG ON ; FALSE: DEBUG OFF
		

	End Method 
	
	Method OnUpdate:Int()
		maniacUpdate()			'IMPORTANT: MAKE SURE TO CALL THIS FUNCTION ONCE PER UPDATE !!!
		If KeyHit(KEY_ESCAPE)
			Error ""
		Endif 
		
	End Method
	
	Method OnRender:Int()
		Cls
		
		'### Background ###
		SetColor 135,206,250
		DrawImage MANIAC_IMG_BACKGROUND ,0,0 ,0 ,DW/MANIAC_IMG_BACKGROUND.Width(),DH/MANIAC_IMG_BACKGROUND.Height()
		
		
		
	End Method 

End Class 