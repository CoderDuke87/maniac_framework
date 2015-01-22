#rem
	Copyright (C) 2015  Stephan Duckerschein~n
	This Example shows how to use the simple GUI Elements.
	Just run this code and watch,
#end 

import mojo
import maniac


Function Main:Int()
	New Example
End Function 


Class Example Extends App


	Field Tab_ShowButton:ManiacButton
	Field Tab_ShowGalleryViewer:ManiacButton
	Field Btn_Example1:ManiacButton

	Method OnCreate:Int()
		SetUpdateRate( 60 )
		
		#rem
			Initialises the Framework ; THIS IS IMPORT FOR EVERY MANIAC-Powerd Project
		#end
		initManiac()
		
		#rem
			That's how you create a Button
			Attention, the X & Y Koordinates are Midhandled 
		#end
		Btn_Example1 = New ManiacButton(DW*0.5,DH*0.3,DW*0.3,DH*0.07,"Example Button",ALIGNMENT_MIDDLE,COLOR_BLUE,False)
		
	End Method 
	
	Method OnUpdate()
		#rem
			This Method Updates some important stuff of the Maniac Frameworkd 
		#end
		maniacUpdate()
		
		#rem
			Here you can see how to catch some Button-Events.
			Update() returns 101 if MouseOver or 99 if clicked
		#end
		If Btn_Example1.Update() = 99
			
		Endif  
	End Method
	
	Method OnRender:Int()
		Cls
		#rem
			This is the Way you Draw your Button (or any Maniac Object)
		#end
		Btn_Example1.Draw()
	End Method 
End Class 
