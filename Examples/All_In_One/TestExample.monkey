Import mojo
Import maniac

#GLFW_USE_MINGW=True

#GLFW_WINDOW_TITLE="Benchmark Example"
#GLFW_WINDOW_WIDTH=1800
#GLFW_WINDOW_HEIGHT=950
#GLFW_WINDOW_SAMPLES=0
#GLFW_WINDOW_DECORATED=False 
#GLFW_WINDOW_RESIZABLE=False
#GLFW_WINDOW_FULLSCREEN=false  

#GLFW_SWAP_INTERVAL=-1

#OPENGL_GLES20_ENABLED=false
#OPENGL_DEPTH_BUFFER_ENABLED=false

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
	
	
	Field TabGUI:ManiacButton
	Field TabGraphics:ManiacButton
	Field TabMap:ManiacButton
	Field TabBenchmark:ManiacButton
	
	Field BtnTest:ManiacButton
	Field BtnTest2:ManiacButton
	Field BtnTest3:ManiacButton
	Field BtnTest4:ManiacButton
	
	
	Field Slider:ManiacSlider
	Field TfdTest:ManiacTextfield
	Field CheckBox:ManiacCheckBox 
	Field DropDown:ManiacDropDown
	Field DP_Animations:ManiacDropDown
	Field ListView:ManiacListView
	
	Field RG_RadioGroup:ManiacRadioGroup
	
	Field BtnChangeImgMode:ManiacButton
	Field BtnChangeImgAnimation:ManiacButton
	Field BtnTakeScreenShot:ManiacButton
	Field mImg:ManiacImage
	Field gallery:ManiacGallery
	
	Field ExampleState:Int 		= 0
	
	Field ico:ManiacImageCheckBox
	Field MAP:maniac_Map
	
	'Field text:ManiacFont
	Field arr:Int[][][]
	
	Field angle:Float = 0
	Method OnCreate:Int()
		'ShowMouse()
		'DW = DeviceWidth()
		'DH = DeviceHeight()
		SetUpdateRate( 60 )
		initManiac(true)
		
		TabGUI			= New ManiacButton(DW*0.125/2+DW*0.02,			DH*0.051,DW*0.125,	DH*0.07,"Show GUI",ALIGNMENT_MIDDLE,COLOR_BLUE,True,1)
		TabGraphics		= New ManiacButton(DW*0.25,DH*0.051,DW*0.125,	DH*0.07,"Graphics",ALIGNMENT_MIDDLE,COLOR_BLUE,True,1)
		TabMap			= New ManiacButton(DW*0.4,DH*0.051,DW*0.125,	DH*0.07,"Map",ALIGNMENT_MIDDLE,COLOR_BLUE,True,1)
		TabBenchmark	= New ManiacButton(DW*0.55,DH*0.051,DW*0.125,	DH*0.07,"Benching",ALIGNMENT_MIDDLE,COLOR_BLUE,True,1)
		
		
		'#### GUI Examples
		GetFolderFiles2("monkey://data/GFXN/")
		CheckBox = New ManiacCheckBox(DW*0.1,DH*0.62,DW*0.05,DH*0.05)
		DropDown = New ManiacDropDown(DW*0.6,DH*0.1,DW*0.2,DH*0.04,"MENUE")
		DropDown.addLine("Line 1")
		DropDown.addLine("Line 2")
		DropDown.addLine("Line 3")
		ListView = New ManiacListView(DW*0.6,DH*0.3,DW*0.2,DH*0.4)
		For Local i:Int = 0 To 20
			ListView.addLine("Line "+i)
		Next 
		RG_RadioGroup = New ManiacRadioGroup(DW*0.1,DH*0.8,DW*0.4,DH*0.1,"RadioGroup")
		RG_RadioGroup.addChoice("Choice 1", 1)
		RG_RadioGroup.addChoice("Choice 2", 22)
		RG_RadioGroup.addChoice("Choice 3", 34)
		RG_RadioGroup.addChoice("Choice 4", 34)
		RG_RadioGroup.addChoice("Choice 5", 34)
		BtnTest = New ManiacButton(DW*0.2,DH*0.3,DW*0.25,	DH*0.1,"Start Anim",ALIGNMENT_MIDDLE,COLOR_BLUE,True,0.2)
		BtnTest.setMouseOverEffects(False ,False, false )
		DP_Animations = New ManiacDropDown(DW*0.35,DH*0.25,DW*0.2,DH*0.04,"Animations")
		DP_Animations.addLine("Drop")
		DP_Animations.addLine("Slide")
		DP_Animations.addLine("Roll")
		DP_Animations.addLine("Fade")
		DP_Animations.addLine("PopOut")
		
		ico = New ManiacImageCheckBox(DW*0.2,DH*0.2,DW*0.05,DH*0.05)
		
		Slider = New ManiacSlider(DW*0.05,DH*0.47,DW*0.4,DH*0.06,22,300)
		Slider.setStyle(1)
		TfdTest = New ManiacTextfield(DW*0.1,DH*0.1,DW*0.2,DH*0.05)
		
		'Menue for Graphics
		mImg = New ManiacImage(DW*0.12,DH*0.25,DW*0.2,DH*0.2,"lib/logo.png","Showing ManiacImage FX")',_Caption:String="",_Align:Int = 0,_Hertz:Float = 1.0 )
		BtnChangeImgMode =  New ManiacButton(DW*0.12,DH*0.43,DW*0.15,	DH*0.07,"Next Mode",ALIGNMENT_MIDDLE,COLOR_BLUE,True,1.5)
		BtnChangeImgAnimation =  New ManiacButton(DW*0.12,DH*0.51,DW*0.15,	DH*0.07,"Next Animation",ALIGNMENT_MIDDLE,COLOR_BLUE,True,1.5)
		
		gallery = New ManiacGallery(DW*0.35,DH*0.15,DW*0.5,DH*0.5,"monkey://data/GFXN/")
		'
		'BtnTest3 = New ManiacButton(DW*0.25,DH*0.30,DW*0.25,	DH*0.1,"tstl",ALIGNMENT_MIDDLE,COLOR_BROWN,True,0.5)
'		arr = Array3D(5,5,3)

		MAP = New maniac_Map(DW*0.02,DH*0.23,DW*0.95,DH*0.70,10,10)
		Return 0
	End
	
	
	Method OnUpdate:Int()
		Local t:Int = Millisecs()
		
		maniacUpdate()
		
		If KeyHit(KEY_D)
			'maniacSetDebug(False)
			maniacSwitchDebug()
		Endif 
		If TabGUI.Update() = 101 And gl_mousereleased
			ExampleState = 0
			TabGUI.setGlow(True ,COLOR_BLUE ,0.8,0.7,1.0,1)
		Endif 
		If TabGraphics.Update() = 101 And gl_mousereleased
			ExampleState = 1
			TabGraphics.setGlow(True ,COLOR_BLUE+4 ,1.0,0.5,1.0,0)
		Endif 
		If TabMap.Update() = 101 And gl_mousereleased
			ExampleState = 2
			TabMap.setGlow(True ,COLOR_BLUE+4 ,0.7,0.7,1.0,0)
		Endif 
		If TabBenchmark.Update()	= 101 And gl_mousereleased
			ExampleState = 3
			TabBenchmark.setGlow(True ,COLOR_BLUE+4 ,0.5,0.7,1.0,0)
		Endif 
		
		Select ExampleState
			Case 0
				If BtnTest.Update() = 101 And gl_mousereleased = True 	'Mouse Over Button + Released Key
					Local str:String = DP_Animations.getSelectedText()
					Select str
						Case "Drop"
							BtnTest.startAnimDrop(-DH*0.1,2500)
						Case "Slide"
							BtnTest.startAnimSlide(-DW*0.2,1500,"Bounce", "Out")
						Case "Roll"
							Print "Starting ROLL"
							BtnTest.startAnimRoll(-DW*0.2,3000,3,"Back","Out")
						Case "Fade"
						
						Case "PopOut"
							BtnTest.startAnimPopOut(1500,"Back","Out")
					End Select 
					'BtnTest2.startAnimCircle(0,0,2000)
				Endif 
				
				TfdTest.Update()
				Slider.Update()
				CheckBox.Update()
				DropDown.Update()
				ListView.Update()
				DP_Animations.Update()
				RG_RadioGroup.Update()
				
				If KeyHit(KEY_1)
					BtnTest.setStyle(0)
					PlaySound(MANIAC_SND_SLIDE2)
				Endif 
				If KeyHit(KEY_2)
					BtnTest.setStyle(1)
				Endif
				If KeyHit(KEY_3)
					BtnTest.setStyle(2)
				Endif
				If KeyHit(KEY_4)
					BtnTest.setStyle(3)
				Endif
				If KeyHit(KEY_5)
					BtnTest.setStyle(4)
				Endif
			Case 1
				If BtnChangeImgMode.Update() = 101 And gl_mousereleased = True
					mImg.setMode(mImg.getMode()+1)
				Endif 
				If BtnChangeImgAnimation.Update() = 101 And gl_mousereleased = True
				
				Endif 
				gallery.Update()
				
			Case 2
			Case 3
		End Select 
		If KeyHit(KEY_ESCAPE)
			Error ""
		Endif 
		Local t2:Int = Millisecs()
		Maniac_Debug.addUpdateTime(t2-t) 
		Return 0
		  
	End
	
	
	' Assumes 640 x 480 device size
	Method OnRender:Int()		
		Cls
		Local t:Int = Millisecs()
		TabGUI.Draw()
		TabGraphics.Draw()
		TabMap.Draw()
		TabBenchmark.Draw()
		'MANIAC_FONT.Wrap("Kursiver Text Text. Mal sehen was passiert, wenn dieser Text ueber mehrere Zeilen lang ist.",100,100,400,300,250,true)
		'ResetMatrix()
		Select ExampleState
			Case 0		'GUI TESTFIELD
				BtnTest.Draw()
				TfdTest.Draw()
				Slider.Draw()
				CheckBox.Draw()
				DropDown.Draw()
				ListView.Draw()
				DP_Animations.Draw()
				RG_RadioGroup.Draw()
				
			Case 1		'SHOWING SOME GRAPHIC EFFECTS
			
				'Drw_Lightning(DW*0.2,DH*0.1,DW*0.2,DH*0.4)
				
				mImg.Draw()
				BtnChangeImgMode.Draw()
				BtnChangeImgAnimation.Draw()
				
				gallery.Draw()
				'Drw_Lightning(DW,DH,DW*0.5,DH*0.5)
				'Drw_Lightning(DW,0,DW*0.5,DH*0.5)
				
			Case 2		'MAP TESTFIELD
				'MAP.Draw()
				ico.Draw()
				
			Case 3
				Drw_Lightning(DW,DH,DW*0.5,DH*0.5)
				Drw_Lightning(0,DH,DW*0.5,DH*0.5)
				'Drw_Lightning(DW,0,DW*0.5,DH*0.5)
				
				Drw_Rect(DW*0.21,DH*0.3,DW*0.07,DW*0.07,Rnd(1,5))
		End Select 
		'Drw_Lightning(0,20,DW,20)
		#rem
		
		For Local i:Int = 0 To 900
			SetAlpha Rnd(0.1,0.9)
			Drw_Rect(Rnd(20,400),Rnd(20,400),Rnd(5,30),Rnd(5,10),1)
		Next 
		#end 
		Local t2:Int = Millisecs()
		Maniac_Debug.addRenderTime(t2-t)
		
		If MANIAC_DEBUG = True 
			MANIAC_FPSGRAPH.Draw()
		Endif 
		
		
		Return 0
	End
End Class 