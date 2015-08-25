#Rem monkeydoc Module maniac.gui.maniacGuiLogo
	Gui-Logo Module - Version 1.0 (rv1)  ~n
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
	
		
	Example:
	<pre>
		Global tB:ManiacGuiLogo = new ManiacGuiLogo(400,400,300,300)

		Function Main:Int()
			New Example							
			Return 0
		End Function  
	</pre>
#end
Class ManiacGuiLogo Extends cGuiBase

	Field listLayer:List<ManiacGuiLogoLayer>
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float)  
		setGeo(_X,_Y,_Width,_Height)
		setVisible(False)
		listLayer = New List<ManiacGuiLogoLayer>
	End Method 

	Method Draw:Void()
		drawBase()
		For Local oll:ManiacGuiLogoLayer = Eachin listLayer
			oll.Draw()
		Next 
	End Method
	
	Method Update:Int()
		updateBase()
		For Local oll:ManiacGuiLogoLayer = Eachin listLayer
			oll.Update()
		Next
	End Method 
	
	Method addLayer:Void(_ImgPath:String)
		Local ll:ManiacGuiLogoLayer = New ManiacGuiLogoLayer(getX(),getY(),getWidth(),getHeight(),_ImgPath)
		'll.
		listLayer.AddLast(ll)
	End Method 
	
	Method getLayer:ManiacGuiLogoLayer(_ID:Int)
		Local i:Int = 0
		For Local ll:ManiacGuiLogoLayer = Eachin listLayer
			If i = _ID
				Return ll
			Endif 
			i +=1
		Next 
	End Method 
End Class 


public
Class ManiacGuiLogoLayer Extends cGuiBase

	Field Img:Image 
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_ImgPath:String)  
		setGeo(_X,_Y,_Width,_Height)
		setVisible(False)
		Img = LoadImage(_ImgPath,1,Image.MidHandle)
		
	End Method 
	
	Method Draw()
		drawBase()
		If getAngle() <> 0.0
			RotateAt(getoX(),getoY(), getAngle())
		Endif
		SetColor 255,255,255
		SetAlpha 1
		DrawImage Img,getX(),getY(),getAngle(),getWidth()/Img.Width(),getHeight()/Img.Height()
		
		
		ResetMatrix()
		
	End Method
	
	Method Update:Int()
		updateBase()
		
	End Method 
	
End Class 