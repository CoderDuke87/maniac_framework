
Class ManiacImage

	Field imgFrame:Image
	Field imgPic:Image
	Field bFramed:Bool = False 
	
	Field midX:Float,midY:Float,Width:Float,Height:Float
	Field angle:Float 
	Field scalePic:Float
	Field scaleFrame:Float
	Field alphaPic:Float 
	Field alphaFrame:Float 
	
	Field ColorPic:Int
	Field ColorFrame:Int 
	
	Field sclFrameWidth:Float
	Field sclFrameHeight:Float 
	Field sclPicWidth:Float
	Field sclPicHeight:Float
	
	Field bframeAlphaBlinking:Bool 
	Field bFrameBlinkDirection:Bool 
	Field frameMaxAlpha:Float
	Field frameMinAlpha:Float
	Field frameAlphaBlinkSpeed:Float 
	
	Method New(_imgPath:String,_imgFrame:String)
		imgPic = LoadImage(_imgPath,1,Image.MidHandle)
		imgFrame = LoadImage(_imgFrame:String,1,Image.MidHandle)
		bFramed = True 
	End Method 
	
	Method New(_imgPath:String)
		imgPic = LoadImage(_imgPath,1,Image.MidHandle)
	End Method 

	Method setGeo:Void(_X:Float,_Y:Float,_Width:Float,_Height:Float)
		midX = _X
		midY = _y
		Width = _Width
		Height = _Height
		sclPicWidth 	= _Width/imgPic.Width() 
		sclPicHeight	= _Height/imgPic.Height()
		If bFramed = True
			sclFrameWidth 	= _Width/imgFrame.Width() 
			sclFrameHeight	= _Height/imgFrame.Height()
		Endif 
	End Method 
	
	Method setFrameAlphaBlink:Void(_Bool:Bool = False )
		bframeAlphaBlinking = _Bool
	End Method 
	Method setFrameAlphaBlink:Void(_FromAlpha:Float,_ToAlpha:Float,_Hertz:Float)
		bframeAlphaBlinking = True
		frameMaxAlpha 			= _ToAlpha
		frameMinAlpha			= _FromAlpha
		frameAlphaBlinkSpeed	= _Hertz
		
	End Method 
	
	Method Draw:Void()
		If bFramed = True 
			doDrawFrame()
		Endif 
		doDrawPic()
	End Method 
	
	
	Private 
	Method doDrawFrame:Void()
		Maniac_Color(ColorPic)
		SetAlpha alphaFrame
		
		DrawImage imgFrame,midX,midY,angle,sclFrameWidth,sclFrameHeight
	End Method 
	
	Method doDrawPic:Void()
		Maniac_Color(ColorPic)
		SetAlpha alphaFrame
		
		DrawImage imgPic,midX,midY,angle,sclPicWidth,sclPicHeight
	end method
	
End Class 