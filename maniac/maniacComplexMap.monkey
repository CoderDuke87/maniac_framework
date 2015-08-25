Import maniac

Class ManiacCMap

	Field Name:String
	
	Field X:Float,Y:Float,Width:Float,Height:Float
	Field mapX:Int
	Field mapY:Int 

	Field viewX:Int
	Field viewY:Int
	Field currFW:Float		'Field Width in Pixel
	Field currFH:Float		'Field Height in Pxl
	Field scrolledX:Int
	Field scrolledY:Int 

	Field currCursorPositionX:Int
	Field currCursorPositionY:Int 
	Field ListLayer:List<Layer>
	
	Method New(_Name:String,_X:Float,_Y:Float,_Width:Float,_Height:Float,_mapX:Int,_mapY:Int )
		Name = _Name
		X= _X
		Y =_Y
		Width = _Width
		Height = _Height
		mapX = _mapX
		mapY = _mapY
		currFW = Width/_mapX
		currFH = Height/_mapY
		viewX = _mapX
		viewY = _mapY
		ListLayer = New List<Layer>
		
		
	End Method 
	
	Method saveToFile:Void(_FilePath:String)
		Local file:FileStream = FileStream.Open(_FilePath,"w")
		file.WriteInt(Name.Length())
		file.WriteString(Name)
		file.WriteInt(mapX)
		file.WriteInt(mapY)
		file.WriteInt(ListLayer.Count())
		
		
		For Local oL:Layer = Eachin ListLayer
			oL.saveToFile(file)
		Next 
		file.Close()
	End Method 
	
	Function LoadBerlin:ManiacCMap()
		Local oMap:ManiacCMap = New ManiacCMap("Berlin",0,DH*0.1,DW*0.79,DH*0.89,80,80)
		Local oL:Layer = New Layer(0,"Bezirke",80,80)
		oL.setValueDescription(0,"Pankow",10)
		oL.setValueDescription(1,"Weissensee",20)
		oL.setValueDescription(2,"Hohenschoenhausen",30)
		oL.setValueDescription(3,"Marzahn",40)
		oL.setValueDescription(4,"Koepenick",50)
		oL.setValueDescription(5,"Treptow",60)
		oL.setValueDescription(6,"Neukoelln",70)
		oL.setValueDescription(7,"Tempelhof",80)
		oL.setValueDescription(8,"Zehlendorf",14)
		oL.setValueDescription(9,"Spandau",24)
		oL.setValueDescription(10,"Reinickndorf",34)
		oL.setValueDescription(11,"Prenzlauer Berg",44)
		oL.setValueDescription(12,"Lichtenberg",54)
		oL.setValueDescription(13,"Friedrichshain",64)
		oL.setValueDescription(14,"Mitte",74)
		oL.setValueDescription(15,"Kreuzberg",84)
		oL.setValueDescription(16,"Schoeneberg",18)
		oL.setValueDescription(17,"Charlottenburg",28)
		oL.setValueDescription(18,"Tiergarten",38)
		oL.setValueDescription(19,"Wedding",48)
		oMap.ListLayer.AddLast(oL)
		
		Local file:FileStream = FileStream.Open("Berlin","r")
		Local lS:Int = file.ReadInt()'file.WriteInt(oMap.Name.Length())
		oMap.Name =  file.ReadString(lS)'file.WriteString(oMap.Name)
		oMap.mapX =  file.ReadInt()'file.WriteInt(oMap.mapX)
		oMap.mapY = file.ReadInt()
		Local nrLayer:Int = file.ReadInt()
		
		For Local i:Int = 0 Until nrLayer'
			oL.readFromFile(file)
		Next 
		file.Close()
		'oMap.
		Return oMap
	End Function 
	
	
	
	Function CreateBerlin:ManiacCMap(_Name:String,_X:Float,_Y:Float,_Width:Float,_Height:Float,_mapX:Int,_mapY:Int )
	
		Local oMap:ManiacCMap = New ManiacCMap(_Name,_X,_Y,_Width,_Height,_mapX,_mapY)
		Local oL:Layer = New Layer(0,"Bezirke",_mapX,_mapY)
		oL.setValueDescription(0,"Pankow",10)
		oL.setValueDescription(1,"Weissensee",20)
		oL.setValueDescription(2,"Hohenschoenhausen",30)
		oL.setValueDescription(3,"Marzahn",40)
		oL.setValueDescription(4,"Koepenick",50)
		oL.setValueDescription(5,"Treptow",60)
		oL.setValueDescription(6,"Neukoelln",70)
		oL.setValueDescription(7,"Tempelhof",80)
		oL.setValueDescription(8,"Zehlendorf",10)
		oL.setValueDescription(9,"Spandau",20)
		oL.setValueDescription(10,"Reinickndorf",31)
		oL.setValueDescription(11,"Prenzlauer Berg",41)
		oL.setValueDescription(12,"Lichtenberg",51)
		oL.setValueDescription(13,"Friedrichshain",61)
		oL.setValueDescription(14,"Mitte",71)
		oL.setValueDescription(15,"Kreuzberg",81)
		oL.setValueDescription(16,"Schoeneberg",12)
		oL.setValueDescription(17,"Charlottenburg",22)
		oL.setValueDescription(18,"Tiergarten",32)
		oL.setValueDescription(19,"Wedding",42)
		oMap.ListLayer.AddLast(oL)
		
		Return oMap
	End function
#rem
	Method addValueToLayer:Void(_LayerID:Int,_Name:String,_Value:Int,)
	
	End Method 
	#end 
	Method Draw:Void()
		SetAlpha 0.2
		'Drw_Rect(X,Y,Width,Height,mapX,mapY)
		Drw_Grid(X,Y,Width,Height,viewX,viewY)
		
		
		'# Layer Management
		For Local oL:Layer = Eachin ListLayer
			oL.Draw(X,Y,scrolledX,scrolledY,viewX,viewY,currFW,currFH)
		Next 
		
		SetColor 255,0,0
		SetAlpha 1
		If (currCursorPositionX >= 0) And (currCursorPositionX <= viewX)
			Drw_Rect( X + currCursorPositionX*currFW , Y + currCursorPositionY*currFH,currFW,currFH,2)
		Endif 
	End Method 
	
	Method Update:Void()
		currCursorPositionX = ll_GridX(currFW, X)
		currCursorPositionY = ll_GridY(currFH, Y)
	End Method 
	
	
	Method setViewSize:Void(_viewX:Int,_viewY:Int) 
		viewX = _viewX
		viewY = _viewY
		currFW = Width/_viewX
		currFH = Height/_viewY
	End Method 
	
	Method ScrollRight:Void(_Step:Int = 1)
		scrolledX += _Step
	End Method 
	Method ScrollLeft:Void(_Step:Int = 1)
		scrolledX -= _Step
	End Method 
	Method ScrollUp:Void(_Step:Int = 1)
		scrolledY -= _Step
	End Method 
	Method ScrollDown:Void(_Step:Int = 1)
		scrolledY += _Step
	End Method 
	
	Method getCursorX:Int()
		Return currCursorPositionX
	End Method
	
	Method getCursorY:Int()
		Return currCursorPositionY
	End Method 
	
	Method setLayerValue(_LayerID:Int,_Value:Int,_X:Int,_Y:Int,_Color:Int = COLOR_WHITE)
		For Local oL:Layer = Eachin ListLayer
			If oL.getID() = _LayerID
				oL.setValue(_X,_Y,_Value)
				
			Endif 'oL.Draw(X,Y,scrolledX,scrolledY,viewX,viewY,currFW,currFH)
		Next
	End Method 
	
	Method setLayerValueDescription(_LayerID:Int,_Value:Int,_Text:String,_Color:Int)
		For Local oL:Layer = Eachin ListLayer
			If oL.getID() = _LayerID
				oL.setValueDescription(_Value,_Text,_Color)
			Endif 
		Next 
	End Method 
End Class 

Class Layer
	Field ID:Int 
	Field Name:String
	Field arrValue:Int[][]
	Field arrValueDescription:String[]
	Field arrValueColor:Int[]
	Field mapX:Int
	Field mapY:Int
	Field nrValues:int
	Field bVisible:Bool 				= True 
	
	Method New(_ID:Int,_Name:String,_mapX:Int,_mapY:Int)
		mapX = _mapX
		mapY = _mapY
		arrValue = Array2D(_mapX,_mapY,-1)
		arrValueDescription = New String[50]
		arrValueColor = New Int[50]
			
		ID = _ID
	End Method 
	
	Method setValue(_X:Int,_Y:Int,_Value:Int )
		arrValue[_X][_Y] = _Value
	End Method
	
	Method setValueDescription(_Value:Int,_Text:String,_Color:int)
		arrValueDescription[_Value] = _Text
		arrValueColor[_Value] = _Color
	End Method 

	Method Draw(_offX:Float,_offY:Float,_fromX:Int,_fromY:Int,_viewX:Int,_viewY:Int,_fW:Float,_fH:float)
		If bVisible =True
			For Local x:Int = 0 Until _viewX
				For Local y:Int = 0 Until _viewY
					Local val:Int = arrValue[x+_fromX][y+_fromY]
					If val >-1
						SetAlpha 0.3
						Maniac_Color(arrValueColor[val])
						DrawRect _offX + x*_fW,_offY + y*_fH,_fW,_fH
					Endif 
				Next
			Next
			
		Endif 
	End Method 
	
	Method getID:Int()
		Return ID
	End Method 
	
	Method saveToFile(file:FileStream)
		file.WriteInt(ID)
		file.WriteInt(Name.Length())
		file.WriteString(Name)
		file.WriteInt(mapX)
		file.WriteInt(mapY)
		For Local x:Int = 0 Until mapX
			For Local y:Int = 0 Until mapY
				file.WriteInt(arrValue[x][y])
			Next
		Next 
		
	End Method 
	
	Method readFromFile(file:FileStream)
		ID = file.ReadInt()
		Local nL:Int = file.ReadInt()
		Name = file.ReadString(nL)
		mapX = file.ReadInt()
		mapY = file.ReadInt()
		For Local x:Int = 0 Until mapX
			For Local y:Int = 0 Until mapY
				arrValue[x][y] = file.ReadInt()
			Next
		Next
	End Method 
End Class 



Class ManiacMapField
	'global
End Class 

Class MapFieldData

	Field Value:Int
	Field Text:String
End Class 