
Import maniac
#Rem monkeydoc
	This Class is a GalleryViewer Gui Element.
	Version 0.1
	Example:
	<pre>
		Global tB:ManiacButton = new ManiacButton(100,100,300,32)

		Function Main:Int()
			New Example							
			Return 0
		End Function  
	</pre>
#End
Class ManiacGallery	Implements IOnLoadImageComplete
	Global loadedImages:Int =	0
	Global l:Int = 0
	
	Field arrImg:Image[500]
	Field maniacID:Int 
	Field X:Float,Y:Float,Width:Float,Height:Float
	Field ViewMode:Int = 1
	Field dist:Int = 10
	Field imgW:Float,imgH:Float 
	
	Field BtnRight:ManiacButton
	Field BtnLeft:ManiacButton
	Field BtnSwitchViewStyle:ManiacButton
	
	Field ScrolledImages:Int = 0
	
	Field tp:Int	= 0
	Field lastSwitch:Int 
	Field switchIntervall:Int = 500
	
	Field Alpha:float
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_loadPath:String = "GFX/")
		
		If MANIAC_DEBUG = True
			'Maniac_Debug.addStoredBools(1)
			Maniac_Debug.addStoredInts(9)
			Maniac_Debug.addStoredFloats(6)
			'Maniac_Debug.addStoredStrings()
			maniacID = Maniac_Debug.getNumberOfRegisteredObjects()
			Maniac_Debug.addRegisteredObject()
		Endif
		'arrImg[
		X = _X
		Y = _Y
		Width =_Width
		Height = _Height
		loadFromPath(_loadPath)
		Local bW:Float = DW*0.15
		Local bH:Float = DH*0.07
		imgW = ll_Width(_Width,3,dist)
		imgH = (_Height-bH)/2.5
		
		
		BtnLeft 			=  New ManiacButton(_X + bW/2 + _Width*0.02 ,_Y+_Height-bH/2, bW,	bH," << ",ALIGNMENT_MIDDLE,COLOR_BLUE,True,1.5)
		BtnRight 			=  New ManiacButton(_X + _Width - bW/2 - _Width*0.02 ,_Y+_Height-bH/2, bW,	bH," >> ",ALIGNMENT_MIDDLE,COLOR_BLUE,True,1.5)
		BtnSwitchViewStyle 	=  New ManiacButton(_X + _Width*0.5 ,_Y+_Height-bH/2, bW,	bH," Switch ",ALIGNMENT_MIDDLE,COLOR_BLUE,True,1.5)
		
		
	End Method 
	
	
	Method loadFromPath:Void(_Path:String="monkey://external/" )

		Print "Get Folder"
		Local arrStr:String[] = GetFolderFiles(_Path)
		Print "Found: " + arrStr.Length() + " files"
		l = arrStr.Length()
		#rem
		If arrStr.Length() > 0
			For Local j:Int = 0 Until loadedImages'arrStr.Length()
				Print "Loading Image " + arrStr[j] + " to arrImg["+(j)+"]"
				arrImg[j] = LoadImage()
			Next 
		Endif
		#end 
		For Local ls:Int = 0 Until l
			Print "load " + ls
			LoadImageAsync(arrStr[ls], 1, 0, Self)
		Next
	End Method 
	
	Method Draw()
		Drw_Rect(X,Y,Width,Height,3)
		SetColor 255,255,255
		SetAlpha 1
		Select ViewMode
			Case 0	'3x2 overview
				Local i:Int = 0
				For Local x:Int = 0 To 2
					For Local y:Int = 0 To 1
						Drw_Rect(X+dist+x*(imgW+dist)  , Y+dist+y*(imgH+dist), imgW,imgH,2)
						'Print "i: " + i
						if arrImg[i+ScrolledImages] = Null 
							DrawText "No Image",X+dist+x*(imgW+dist)  , Y+dist+y*(imgH+dist)
						Else  
							DrawImage ( arrImg[i+ScrolledImages] , X+dist+x*(imgW+dist)  , Y+dist+y*(imgH+dist),0, imgW/arrImg[i+ScrolledImages].Width(), imgH/arrImg[i+ScrolledImages].Height() )
						Endif 
						i +=1
					Next
				Next 
				
			Case 1
				If arrImg[tp] <> Null
					SetAlpha 1
					DrawImage arrImg[tp], X,Y,0,Width*1/arrImg[tp].Width(),Height*0.87/arrImg[tp].Height()
				Endif 
				If arrImg[tp+1] <> Null
					SetAlpha Alpha
					DrawImage arrImg[tp+1], X,Y,0,Width*1/arrImg[tp+1].Width(),Height*0.87/arrImg[tp+1].Height()
				Endif 
		End Select 
		
		BtnLeft.Draw()
		BtnRight.Draw()
		BtnSwitchViewStyle.Draw()
		
		DrawText("Mode: " + ViewMode+ " | View: " + tp + "/"+loadedImages , X +Width*0.5,Y)
	End Method 
	
	Method Update:Int()
		
		
		If BtnLeft.Update() = 101 And gl_mousereleased
			if ScrolledImages <= 0
			
			Else
				ScrolledImages -= 1
			Endif
		Endif 
		
		If BtnRight.Update() = 101 And gl_mousereleased
			If (ScrolledImages + 6) >= loadedImages
			
			else
				ScrolledImages += 1
			Endif 
		Endif 
		
		If BtnSwitchViewStyle.Update() = 101 And gl_mousereleased
			If ViewMode = 0
				ViewMode = 1
			Else
				ViewMode = 0
			Endif 
		Endif 
		
		Select ViewMode
			Case 0
			Case 1
				If Millisecs() - lastSwitch >= switchIntervall
					If (tp + 1) >= loadedImages
						tp = 0
					else
						tp +=1
					Endif 
					Alpha = 0
					lastSwitch = Millisecs()
				Endif 
				
				Alpha += EqToFPS(1.0/(switchIntervall/1000.0))' 0.02
		End Select  
	End Method 
	
	Method OnLoadImageComplete:Void(_image:Image, path:String, source:IAsyncEventSource)
		If _image <> Null
			arrImg[loadedImages] = _image
			loadedImages += 1
			
			If MANIAC_DEBUG = True
			'Maniac_Debug.addStoredBools(1)
			'Maniac_Debug.addStoredInts(9)
			'Maniac_Debug.addStoredFloats(6)
			'Maniac_Debug.addStoredStrings()
				Maniac_Debug.addStoredImages(1)
			'maniacID = Maniac_Debug.getNumberOfRegisteredObjects()
			'Maniac_Debug.addRegisteredObject()
			Endif
		Else
			Print "no image : "+loadedImages
		Endif 
		
		#rem
		arrImg[loadedImages] = _image
		Print "Loaded Image id: " + loadedImages
		If arrImg[loadedImages] = Null
			Print "no image : "+loadedImages
		Else
			Maniac_Debug.addRegisteredGraphics()
		Endif 
		loadedImages += 1
		#end 
	End
	
	Method getNumberOfLoadedImages:Int()
	
	End Method
	
	Method getImageByID:Image(_ID:Int)
	
	End Method 
	
End class 