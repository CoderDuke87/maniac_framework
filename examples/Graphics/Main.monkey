#rem
	Copyright (C) 2015  Stephan Duckerschein~n
	This Example shows how to use the Graphic Effects of Maniac.
	Just run this code and watch,
#end 

import mojo
import maniac


Function Main:Int()
	New Example
End Function 


Class Example Extends App

	Method OnCreate:Int()
		SetUpdateRate( 60 )
		
		#rem
			Initialises the Framework ; THIS IS IMPORT FOR EVERY MANIAC-Powerd Project
		#end
		initManiac()
	End Method 
	
	Method OnUpdate()
		#rem
			This Method Updates some important stuff of the Maniac Frameworkd 
		#end
		maniacUpdate()
	End Method
	
	Method OnRender:Int()
		Cls
		#rem
			Drawing a Rect.
			X,Y,Width,Height,Thickness all in Pxl
		#end 
		SetColor 255,0,0
		Drw_Rect(DW*0.1,DH*0.1,DW*0.2,DH*0.2,5)
		
		#rem
			Drawing a Circle
		#end
		SetColor 255,255,255
		Drw_Ellipsis(DW*0.41,DH*0.2,DW*0.2,DH*0.2)
		
		#rem
			Drawing a 5x7 Grid
		#end
		SetColor 0,255,0
		Drw_Grid(DW*0.1,DH*0.35,DW*0.4,DH*0.4,5,7)
		
		#rem
			Draw some Lights
		#end
		Drw_Lightning(DW*0.6,DH*0.0,DW*0.63,DH*0.3,2)
		
		#rem
			Draw some Star.
		#end
		Drw_Stars(DW*0.55,DH*0.4,DW*0.4,DH*0.05,5,3)
	End Method 
End Class 
