#Rem monkeydoc Module maniac.maniacTileMap
	ManiacTileMap Module - Version 1.0 (alpha)  ~n
	Copyright (C) 08.08.2015  Stephan Duckerschein~n
	~n
	Inlcuding: ManiacTileMap & ManiacTileField Classes~n
	This is a first attempt to kind of a 'proprietary TileMap'-Engine~n
	
	
#End

Import maniac


#rem monkeydoc
	### CLASS ManiacTileMap ###~n
	Version: 0.9.6
	
#end 
Class ManiacTileMap


#rem
	#### FROM HERE ALL DEPRECATDED ####
#end

	Field Name:String
	Field ManiacID:Int

'	Field NrColors:Int 		= 5
	Field currCursorPositionX:Int
	Field currCursorPositionY:Int 
	
	


#rem
	#### FROM HERE NEW VARIABLE NAMES !!! #####
#end
	Field gMapName:String
	Field gManiacID:Int
	Field X:Float,Y:Float,Width:Float,Height:Float	
	Field MapX:Int
	Field MapY:Int
	Field currFW:Float		'Field Width in Pixel
	Field currFH:Float		'Field Height in Pxl
	Field cursorX:Int
	Field cursorY:int
	
	
	'Meta-Data for the TileData
	Field arrNameFieldID:String[]
	Field arrColorFieldID:Int[]
	
	'Stored Tile-Data
	Field MapArray:ManiacTileField[][]
	
	Private
	Field nrOfValues:Int 			= 0
	Field bGrid:Bool 				= False 
	Field bShowBorder:Bool 			= False 
	
	Field bZoom:Bool 
	Field MapZoomX:Int
	Field MapZoomY:Int 
	Field ScrollX:Int
	Field ScrollY:Int 
	Public
	
	Method scrollMapX:Void(_tiles:Int )
	
	End Method
	
	Method scrollMapY:Void(_tiles:Int )
	
	End Method 
	
	Method setZoom:Void(_tilesX:Int,_tilesY:int)
	
	End Method 
	Method getNrOfValues:Int()
		Return nrOfValues
	End Method 
	
	Method addChoice:Void(_Name:String,_Color:Int)
		arrNameFieldID[nrOfValues] = _Name
		arrColorFieldID[nrOfValues] = _Color
		nrOfValues +=1
	End Method 
	Method addValueName:Void(_Name:String)
		arrNameFieldID[nrOfValues] = _Name
		nrOfValues +=1
	End Method 
	
	Method setValueName:Void(_ValueID:Int,_Name:String)
		arrNameFieldID[_ValueID] = _Name
	End Method 
	
	Method getValueName:String(_ValueID:Int)
		Return arrNameFieldID[_ValueID]
	End Method 
	Method addValueColor:Void(_Color:Int )
		arrColorFieldID[nrOfValues] = _Color
	End Method 
	
	Method getValueColor:Int(_ID:Int)
		Return arrColorFieldID[_ID]
	End Method 
	
	#rem monkeydoc
		'This Function creates a whole new TileMap of File->_Name:String
	#end 
	Function CreateMapFromFile:ManiacTileMap(_Name:String,_X:Float = 0,_Y:Float = 0,_Width:Float = DW,_Height:Float = DH)
		Local nMap:ManiacTileMap = New ManiacTileMap(_X,_Y,_Width,_Height)		
		nMap.arrNameFieldID = New String[100]						'Creating an Reference to the new Map Object !
		Local file:FileStream = FileStream.Open(_Name,"r")			'Opening the FileStream to the MapDataFile where to load Data From.
		
		If file <> Null
			Print "FOUND FILE "
		Endif 
		
		nMap.loadFromFile(file)

		Return nMap
	End Function 
	
	
	
	#rem monkeydoc
		This Constructor-Method creates an empty TileMap with ViewSize to _X,_Y,_Width,_Height ~n
		with _ix * _iy Fields.
	#end 
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_ix:Int,_iy:Int)
		MapArray = Array2Dmtf(_X,_Y,_Width,_Height,_ix, _iy)
		
		Print "Map Array: " 
		For Local x:Int = 0 Until _ix
			For Local y:Int = 0 Until _iy
				'Print "[" +x+"]["+y+"]"'+MapArray[x][y].getX()
			Next 
		Next 
		MapX = _ix
		MapY = _iy
		Width = _Width
		Height = _Height
		X = _X
		Y = _Y
		currFW = Width/_ix
		currFH = Height/_iy
		arrNameFieldID = New String[100]
		arrColorFieldID = New Int[100]
		setAllVisible(False)
		setAllAlpha(1)
		Print "-- Created new MAP object --"
	End Method
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float)
		
		Width = _Width
		Height = _Height
		X = _X
		Y = _Y
		'currFW = Width/_ix
		'currFH = Height/_iy
		arrNameFieldID = New String[100]
		arrColorFieldID = New Int[100]
		setAllVisible(False)
		setAllAlpha(1)
		Print "-- Created new MAP object --"
	End Method
	
	
	#rem monkeydoc
		Draws the whole TileMap Object.
	#end 
	Method Draw:Void()
	
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				If MapArray[x][y] <> Null 
					MapArray[x][y].Draw()
				Endif 
			Next
		Next 
		
		#rem
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				If MapArray[x][y] <> Null 
					MapArray[x][y].DrawID()
				Endif 
			Next
		Next
		#end 
		SetColor 255,255,255
		Drw_Rect(X,Y,Width,Height,2)
		
		'DrawText "map: " + currCursorPositionX+"/"+currCursorPositionY,DW*0.5,DH*0.6
		
		If bGrid = True
			SetColor 255,255,255
			Drw_Grid(X,Y,Width,Height,MapX,MapY)
		Endif 
		
		
	End Method
	
	Method Update:Int()
		currCursorPositionX = ll_GridX(currFW, X)
		currCursorPositionY = ll_GridY(currFH, Y)
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				MapArray[x][y].Update()
			Next
		Next 
	End Method
	
	
	Method setAllVisible(_bVisible:Bool = False)
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				MapArray[x][y].setVisible(_bVisible) 
			Next 
		Next
	End Method 
	Method setAllAlpha:Void(_Alpha:Float)
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				MapArray[x][y].setAlpha(_Alpha) 
			Next 
		Next
	End Method 
	
	Method setBlinkColor:Void(_Color:Int )
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				If MapArray[x][y].getColor() = _Color
					MapArray[x][y].setBlink(True)
					MapArray[x][y].setBlinkRange(0.15,1.0)
					MapArray[x][y].setBlinkHertz(1.0) 
				Else
					MapArray[x][y].setBlink(false) 
				Endif 
			Next 
		Next
	End Method 
	
	
	Method setBlinkByID:Void(_ID:Int )
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				If MapArray[x][y].getValueID() = _ID
					MapArray[x][y].setBlink(True)
					MapArray[x][y].setBlinkRange(0.15,1.0)
					MapArray[x][y].setBlinkHertz(1.0) 
				Else
					MapArray[x][y].setBlink(false) 
				Endif 
			Next 
		Next
	End Method 
	
	Method setBlinkByIDMulti(_ID:Int)
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				If MapArray[x][y].getValueID() = _ID
					MapArray[x][y].setBlink(True)
					MapArray[x][y].setBlinkRange(0.15,1.0)
					MapArray[x][y].setBlinkHertz(1.0) 
				Else
					'MapArray[x][y].setBlink(false) 
				Endif 
			Next 
		Next
	End Method 
	
	Method setBlinkByID(_arrID:Int[])
		
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				'For Local i:Int = 0 Until _arrID.Length()
				Local currID:Int = MapArray[x][y].getValueID()
				If ArrayContains(_arrID,currID)
					'If MapArray[x][y].getValueID() = ArrayContains:Bool(_iarr:Int[],_value:Int)_arrID[i]
					MapArray[x][y].setBlink(True)
					MapArray[x][y].setBlinkRange(0.15,1.0)
					MapArray[x][y].setBlinkHertz(1.0) 
				Else
					MapArray[x][y].setBlink(false) 
				Endif 
				'Next 
			Next
		Next 
	End Method 
	
	Method setBlinkOff()
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				MapArray[x][y].setBlink(false) 
			Next 
				'Next 
		Next
		 
	End Method 
	#rem monkeydoc
		sets the ViewSize of Map. (Resizes automatically the Map fields.)
	#end
	Method setMapView(_X:Float,_Y:Float,_Width:Float,_Height:Float)
		Width = _Width
		Height = _Height
		X = _X
		Y = _Y
	End Method 
	
	
	Method getNrColors:Int()
		Return NrColors
	End Method
	
	Method getNrColorsByColor:Int(_Color:Int)
		Local nr:Int = 0
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				If MapArray[x][y].getColor() = _Color
					nr +=1
				Endif 
			Next 
		Next 
		
		Return nr
	End Method 
	
	
	Method getLeftFields:Int()
		Local left:Int = 0
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				If MapArray[x][y].getColor() < COLOR_PLAYER1
					left += 1
				Endif 
			Next
		Next 	
		Return left
	End Method 
	
	Method randomColor:Void(_NrColors = NrColors)
		NrColors = _NrColors
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
			Local z:Int = Rnd(1,_NrColors+1)
				MapArray[x][y].setColor_BG(z*10,z*10,COLOR_GREEN)
			Next
		next
	End Method 
	
	
	
	Method IntroAnim()
		Local i:Int = 0
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				i+=1
				MapArray[x][y].startAnimDrop(-DH*0.2+i*0.1,5500,"Back","Out")
			Next
		Next 
	End Method 
	
	Method IntroAnim2()
		Local i:Int = 0
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				i+=1
				MapArray[x][y].startAnimRoll(-DW*0.3+i*0.1,5500,2,"Back","Out")
			Next
		Next 
	End Method 
	
	Method IntroAnimPopOut(_ID:Int = -1)
		Local i:Int = 0
		
		If _ID = -1
			For Local x:Int = 0 Until MapX
				i+=1
				For Local y:Int = 0 Until MapY
					MapArray[x][y].startAnimPopOut(100+i*200,"Back","Out") 'startAnimRoll(-DW*0.3+i*30,5500,2,"Back","Out")
				Next
			Next
		Else
			For Local x:Int = 0 Until MapX
				i+=1
				For Local y:Int = 0 Until MapY
					If MapArray[x][y].getColor() = _ID
						MapArray[x][y].startAnimPopOut(100+i*200,"Back","Out") 'startAnimRoll(-DW*0.3+i*30,5500,2,"Back","Out")
					Endif 
				Next
			Next
		Endif 
			
	End Method 

	Method SetColorField(ix:Int,iy:Int,_Color:Int)
		'Print ix + " | " + iy
		MapArray[ix][iy].setColor_BG(_Color,_Color,_Color)
	End Method 
	
	Method getField:ManiacTileField(_X:Int,_Y:Int)
		If _X > -1 And _X < MapX And _Y > -1 And _Y < MapY
			Return MapArray[_X][_Y]
		Endif 
	End Method 
	
	Method setColorActive(_Color:Int)
		For Local x:Int = 0 Until _IX
			For Local y:Int = 0 Until _IY
				If MapArray[x][y].getColor() = _Color
				
				Endif 
			Next
		Next
	End Method 
	
	Method CheckForBorder:Void()
		For Local i:Int = 0 Until nrOfValues
			CheckBorderForColor(arrColorFieldID[i])
		Next 
	End Method 
	
	Method ResetBorder:Void()
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				MapArray[x][y].hideBorder()
			Next
		Next 
	End Method 
	
	Method CheckBorderForColor(_Color:Int)
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				If MapArray[x][y].getColor() = _Color
					'Print x+"|"+y+" : " + iid
					Local thickness:Int = 1
					If x < MapX-1 And y < MapY-1 And x > 0 And y > 0
					
						'Print "nach Rechts"
						'kontrolle nach rechts
						If MapArray[x+1][y] <> Null 
							If MapArray[x][y].getColor() <> MapArray[x+1][y].getColor() 
								MapArray[x][y].bRight = True 
							Endif
						Endif 
						
						
						'Print "nach Unten"						
						'kontrolle nach unten
						If MapArray[x][y+1] <> Null 
							If MapArray[x][y].getColor() <> MapArray[x][y+1].getColor() 
								MapArray[x][y].bDown = true
							Endif
						Endif 							
						'nach links
						
						'Print "nach Links"
						If MapArray[x-1][y] <> Null 
							If MapArray[x][y].getColor() <> MapArray[x-1][y].getColor()
								MapArray[x][y].bLeft = true
							Endif
						Endif 
						
												
						'nach oben
						'Print "nach oben"
						If MapArray[x][y-1] <> Null 
							If MapArray[x][y].getColor() <> MapArray[x][y-1].getColor() 
								MapArray[x][y].bUp = true
							Endif
						Endif 
						 
					Endif
				Endif 
			Next
		Next
	End Method 
	Method DrawBorderAll()
		For Local i:Int = 0 Until nrOfValues
			DrawBorderForColor(arrColorFieldID[i])
		Next 
	End Method 
	Method DrawBorderForColor(iid:Int)
		'Local MapX = _IX
		'Local MapY = _IY
		
		'Print "Draw Border for: " + iid
		SetColor 255,255,255
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				If MapArray[x][y].getColor() = iid
					'Print x+"|"+y+" : " + iid
					Local thickness:Int = 1
					If x < MapX-1 And y < MapY-1 And x > 0 And y > 0
					
						'Print "nach Rechts"
						'kontrolle nach rechts
						If MapArray[x+1][y] <> Null 
							If MapArray[x][y].getColor() <> MapArray[x+1][y].getColor() 
								MapArray[x][y].DrawBorderRight()
							Endif
						Endif 
						
						
						'Print "nach Unten"						
						'kontrolle nach unten
						If MapArray[x][y+1] <> Null 
							If MapArray[x][y].getColor() <> MapArray[x][y+1].getColor() 
								MapArray[x][y].DrawBorderDown()
							Endif
						Endif 							
						'nach links
						
						'Print "nach Links"
						If MapArray[x-1][y] <> Null 
							If MapArray[x][y].getColor() <> MapArray[x-1][y].getColor()
								MapArray[x][y].DrawBorderLeft()
							Endif
						Endif 
						
												
						'nach oben
						'Print "nach oben"
						If MapArray[x][y-1] <> Null 
							If MapArray[x][y].getColor() <> MapArray[x][y-1].getColor() 
								MapArray[x][y].DrawBorderUp()
							Endif
						Endif 
						 
					Endif
				Endif 
			Next
		Next 
	End Method
	
	
	Method Assimilate(icolor:Int,iplayer:Int,ideep:Int=4,itype:Int = 1)
	'icolor: - int value of color for assimilating
	'iplayer: - PlayerID who is attacking
	'ideep: number of fields that can be attacked in one direction
	'itype: 1 - attacking horizontal/vertical ; 2- attacking Diagonal
		'Local MapX = _IX
		'Local MapY = _IY
		'Print "Assimilate: " + icolor +" "+iplayer+" "+ ideep
		For Local x:Int = 0 To MapX-1
			For Local y:Int = 0 To MapY-1	 
				If MapArray[x][y].getColor() = iplayer	'Wenn Player Feld gefunden
					Attack(x,y,icolor,iplayer,ideep)
				Endif
			Next
		Next 
		
	End Method
	
	
	Method Attack(ix:Int,iy:Int,icolor:Int,iplayer:Int,ideep:Int)
		Local MapX = _IX
		Local MapY = _IY
		Local deep:Int = ideep - 1
		If deep < 1
			Return 
		Else 
			'Rechts
			If ix+1 <= MapX-1
				If MapArray[ix+1][iy].getColor() = icolor 
					MapArray[ix+1][iy].SetColorField(iplayer)' = iplayer = iplayer
					MapArray[ix+1][iy].startAnimPopOut(1000,"Back","Out")
					Attack(ix+1,iy,icolor,iplayer,deep)
				Endif 
				
				#rem
				If ColorArray[ix+1][iy] = 25
					'Left -= 1
					ColorArray[ix+1][iy] = iplayer
					Attack(ix+1,iy,icolor,iplayer,deep)
				Endif 
				#end 
			Endif 
			
			'Links
			If ix-1 >= 0
				If MapArray[ix-1][iy].getColor() = icolor
					MapArray[ix-1][iy].SetColorField(iplayer)' = iplayer
					MapArray[ix-1][iy].startAnimPopOut(1000,"Back","Out")
					Attack(ix-1,iy,icolor,iplayer,deep)
				Endif
				#rem 
				If ColorArray[ix-1][iy] = 25
					'Left -= 1
					ColorArray[ix-1][iy] = iplayer
					Attack(ix-1,iy,icolor,iplayer,deep)
				Endif 
				#end
			Endif 
			
			'Runter
			If iy+1 <= MapY-1
				If MapArray[ix][iy+1].getColor() = icolor
					MapArray[ix][iy+1].SetColorField(iplayer)' = iplayer
					MapArray[ix][iy+1].startAnimPopOut(1000,"Back","Out")
					Attack(ix,iy+1,icolor,iplayer,deep)
				Endif 
				#rem	
				If ColorArray[ix][iy+1] = 25
					'Left -= 1
					ColorArray[ix][iy+1] = iplayer
					Attack(ix,iy+1,icolor,iplayer,deep)
				Endif
				#end 
			Endif 
			
			'Hoch	
			If iy-1 >= 0			
				If MapArray[ix][iy-1].getColor() = icolor
					MapArray[ix][iy-1].SetColorField(iplayer)' = iplayer = iplayer
					MapArray[ix][iy-1].startAnimPopOut(1000,"Back","Out")
					Attack(ix,iy-1,icolor,iplayer,deep)
				Endif
				#rem
				If ColorArray[ix][iy-1] = 25
					'Left -= 1
					ColorArray[ix][iy-1] = iplayer
					Attack(ix,iy-1,icolor,iplayer,deep)
				Endif
				#end 
			Endif 
		Endif  
	End Method
	
	Method getNeighborNrColorsOfPlayerID:Int(_ID:Int,icolor:Int)
	
		Local MapX = _IX
		Local MapY = _IY
		Local nr:Int =0
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
			If MapArray[x][y].getColor() = _ID
				If x < MapX-1 ' And y < 29
					If MapArray[x+1][y].getColor() = icolor 
						nr +=1
					Endif 
				Endif 
				If x > 0
					if MapArray[x-1][y].getColor() = icolor
						nr +=1
					Endif 
				Endif 
				
				If y < MapY-2
					If MapArray[x][y+1].getColor() = icolor 
						nr +=1
					Endif
				Endif 
			
				If y > 0
					If MapArray[x][y-1].getColor() = icolor
						nr +=1
					Endif 
				Endif 
				'Endif 
			Endif 
			Next 
		Next 
	Return nr
	End Method
	
	Method getFieldX_Left:Float(_X:Int)
		Return (MapArray[_X][1].getX() - MapArray[_X][1].getWidth()/2)
	End Method 
	
	Method getFieldX_Right:Float(_X:Int)
		Return (MapArray[_X][1].getX() + MapArray[_X][1].getWidth()/2)
	End Method
	
	Method getFieldY_Top:Float(_Y:Int)
		Return (MapArray[1][_Y].getY() - MapArray[1][_Y].getHeight()/2)
	End Method 
	Method getFieldY_Bottom:Float(_Y:Int)
		Return (MapArray[1][_Y].getY() + MapArray[1][_Y].getHeight()/2)
	End Method 
	
	Method getFieldWidth:Float()
		Return MapArray[1][1].getWidth()
	End Method
	
	Method getFieldHeight:Float()
		Return MapArray[1][1].getHeight()
	End Method 
	
	Method getNrFields:Int()
		Return MapX*MapY
	End Method 
	
	Method getCursorX:Int()
		Return currCursorPositionX
	End Method
	
	Method getCursorY:Int()
		Return currCursorPositionY
	End Method
	
	Method getCurrValueID:Int()
		
		Return MapArray[currCursorPositionX][currCursorPositionY].getValueID()
	End Method 
	
	
	Method getNeighbourIDs:Int[](_Id:Int)
		Local akkuArray:Int[] =  New Int[100]
		For Local i:Int = 0 Until akkuArray.Length()
			akkuArray[i] = -1
		Next 
		
		Local currID:Int = 0
		For Local x:Int = 0 To MapX-1
			For Local y:Int = 0 To MapY-1	 
				If MapArray[x][y].getValueID() = _Id	'Wenn Player Feld gefunden
					'Attack(x,y,icolor,iplayer,ideep)
					Local gNeighborID:Int
					
					'#### Chec for right Element
					If (x+1 < MapX)
						gNeighborID = MapArray[x+1][y].getValueID()
						
						If gNeighborID <> _Id
							If ArrayContains(akkuArray,gNeighborID) = False
								akkuArray[currID] = gNeighborID
								currID +=1
								Print "found new neighbor: " + gNeighborID 
							Endif 
						
						Endif 
					Endif 
					
					
					'Check for bottom
					If (y+1 < MapY)
						gNeighborID = MapArray[x][y+1].getValueID()
						
						If gNeighborID <> _Id
							If ArrayContains(akkuArray,gNeighborID) = False
								akkuArray[currID] = gNeighborID
								currID +=1
								Print "found new neighbor: " + gNeighborID 
							Endif 
						
						Endif 
					Endif
					
					'Check for left
					If (x-1 > 0)
						gNeighborID = MapArray[x-1][y].getValueID()
						
						If gNeighborID <> _Id
							If ArrayContains(akkuArray,gNeighborID) = False
								akkuArray[currID] = gNeighborID
								currID +=1
								Print "found new neighbor: " + gNeighborID 
							Endif 
						
						Endif 
					Endif
					
					'Check for up
					If (y-1 >=0)
						gNeighborID = MapArray[x][y-1].getValueID()
						
						If gNeighborID <> _Id
							If ArrayContains(akkuArray,gNeighborID) = False
								akkuArray[currID] = gNeighborID
								currID +=1
								Print "found new neighbor: " + gNeighborID 
							Endif 
						
						Endif 
					Endif
				Endif
			Next
		Next
		
		Print "Found " + currID + " neighbors"
		
		Local _arr:Int[] = New Int[currID]
		For Local ind:Int = 0 Until currID
			_arr[ind] = akkuArray[ind]
		Next  
		
		Return _arr
	End Method 
	
	#rem monkeydoc
		This Method saves whole TileMap data to _FilePath:String File. (it creates new/rewrties the file)
	#end
	Method saveToFile(_FilePath:String)
		Local file:FileStream = FileStream.Open(_FilePath,"w")
		file.WriteInt(Name.Length())
		file.WriteString(Name)
		file.WriteInt(MapX)
		file.WriteInt(MapY)
		
		file.WriteInt(nrOfValues)
		For Local i:Int = 0 Until nrOfValues
			Local l:Int = arrNameFieldID[i].Length()
			file.WriteInt(l)
			file.WriteString(arrNameFieldID[i])
			file.WriteInt(arrColorFieldID[i])
		Next 
		
		
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				MapArray[x][y].saveField(file)
			Next
		Next 
		file.Close()
	End Method 
	
	
	
	#rem
		This Methods oads complete TileField Data from file.
	#end 
	Method loadFromFile(_File:FileStream)
		'Local file:FileStream = FileStream.Open(_FilePath,"r")
		loadMapHeader(_File)
		loadMapData(_File)
		
		'_File.Close()
	End Method
	
	Method loadMapHeader(_File:FileStream)
		Local nl:Int = _File.ReadInt()
		gMapName = _File.ReadString(nl)
		MapX = _File.ReadInt()
		MapY = _File.ReadInt()
		currFW = Width/MapX
		currFH = Height/MapY
		
		Local OfValues:int = _File.ReadInt()
		For Local i:Int = 0 Until OfValues
			Local l:Int = _File.ReadInt()
			Local str:String = _File.ReadString(l)
			Local col:Int = _File.ReadInt()
			addChoice(str,col)
			'addValueName(str)
		Next 
		
		Print "loaded Val:" + nrOfValues
	End Method  
	
	Method loadMapData(_file:FileStream)
		MapArray = Array2Dmtf(X,Y,Width,Height,MapX,MapY)
		For Local x:Int = 0 Until MapX
			For Local y:Int = 0 Until MapY
				MapArray[x][y].loadField(_file)
			Next
		Next 
		_file.Close()
	End Method 
	
	Method setMapRandom()
	
	End Method 
	
	Method showGrid(_bool:Bool = True )
		bGrid = _bool
	End Method 
	
	Method switchBorder:Void()
		If bShowBorder = False
			CheckForBorder()
			bShowBorder = True 
		Else
		
			bShowBorder = False 
		Endif 
	End Method 
	
	Method printLayerData:Void()
		For Local i:Int = 0 Until nrOfValues
			Print i + " |  Name: " + arrNameFieldID[i] + " |  Color: " + arrColorFieldID[i]
		Next 
	End Method 
	
	Method printMapStats:Void()
		For Local i:Int = 0 Until nrOfValues
		
		Next
	
	End Method 
End Class

#rem
Class Example Extends App

	field BtnTest:ManiacButton		'define a Button
	field BtnTest2:ManiacButton		'define another Button
	
	Method OnCreate:Int()
		SetUpdateRate( 60 )
		maniacInit()			' THIS INITS THE MANIAC FRAMEWORK! THIS NEED TO BE DONE BEFORE USING IT!!!!!
		
		
		BtnTest = New ManiacButton(DW*0.5,DH*0.6,DW*0.3,DH*0.1,"Rounded")	'Initialize the Button (constructor call "new")
		BtnTest.setStyle(BUTTON_STYLE_ROUND)								'Sets the Style; can be one of: BUTTON_STYLE_ROUND,BUTTON_STYLE_STD, BUTTON_STYLE_STDGLOW, BUTTON_STYLE_MODERN, BUTTON_STYLE_ROUND, BUTTON_STYLE_CIRCLE
		BtnTest.setAlignment(ALIGNMENT_RIGHT)
		BtnTest.setMouseOnClickAnim(True, false , True,false)
		
		BtnTest2 = New ManiacButton(DW*0.5,DH*0.6,DW*0.3,DH*0.1,"Rounded")
	end Method 
		
	Method OnUpdate:int()
		maniacUpdate()			'THIS UPDATES ALL NEEDED DATA FOR THE MANIAC-GLOBALS
	end method
		
	Method OnRender:int()
		Cls
		
		maniacDraw()
	end Method  
End class


</pre>
	

#End
'Import maniac



Class ManiacTileField Extends cGuiBase

	Field ValueID:Int =-1
	
	Field bDrawBorder:Bool = False 
	Field bLeft:Bool = False
	Field bRight:Bool
	Field bUp:Bool
	Field bDown:Bool 
	
	
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Value:Int) 
		'Print "new Field"
		setGeo(_X,_Y,_Width,_Height)
		hideFrame()
		setVisible(true)
		'setStyle(MANIAC_STYLE_STD)
		'setText(_Text,ALIGNMENT_MIDDLE,ALIGNMENT_MIDDLEY )
		'setColor_Text(COLOR_WHITE,COLOR_WHITE)
		setColor_BG(COLOR_BLUE,COLOR_GREEN,COLOR_RED)
		setColor_Frame(COLOR_YELLOW,COLOR_ORANGE,COLOR_BLACK)
	End Method 
	
	
	Method Draw:int()
		drawBase()
		
		If bDrawBorder = True 
			SetColor 255,255,255
			If bLeft = True
				DrawBorderLeft()
			Endif 
			
			If bRight = True
				DrawBorderRight()
			Endif 
			
			If bUp = True
				DrawBorderUp()
			Endif 
			
			If bDown = True
				DrawBorderDown()
			Endif
		Endif 
		 
	End Method 
	
	Method DrawID()
		If ValueID > -1 
			SetColor 255,255,255
			DrawText ValueID,getX(),getY()
		Endif
	End Method 
	Method setValueID:Void(_ID:Int)
		ValueID = _ID
	End Method 
	
	Method getValueID:Int()
		Return ValueID
	End Method
	
	Method Update:Int()
		'BtnState = -1
		Local ev:Int = updateBase()
		If isMO() = True
		
		Endif 
		If ev = GUIBASE_ANIMUPDATE_STATE_END
			'BtnState = GUIBASE_ANIMUPDATE_STATE_END
			Return GUIBASE_ANIMUPDATE_STATE_END
		Endif 
	End Method 


	Method isAnimEnd:Bool()
		If BtnState = GUIBASE_ANIMUPDATE_STATE_END
			Return True 
		Else 
			Return false
		Endif 
	End Method 
	
	Method SetColorField(_Color:Int)
		setColor_BG(_Color,_Color,_Color)
	End Method 
	
	Method getColor:int()
		Return getColor_BG_Unselected()
	End Method 
	
	Method switchDrawBorder:Void()
		If bDrawBorder = True
			bDrawBorder = False
		Else
			bDrawBorder = True
		Endif 
	End Method 
	
	Method hideBorder:Void()
		bDrawBorder = False
	End Method 
	
	Method showBorder:Void()
		bDrawBorder = True 
	End Method 
	
	Method DrawBorderRight()
		
		For Local i:Int = 0 Until 2
			DrawLine getX()+getWidth()/2 -(i),  getY() + getHeight()/2,  getX()+ getWidth()/2-(i),  getY() - getHeight()/2
		Next 
		
	End Method 
	
	Method DrawBorderLeft()
		For Local i:Int = 0 Until 2
			DrawLine getX()-getWidth()/2+i,  getY() + getHeight()/2,  getX()-getWidth()/2+i,  getY()-getHeight()/2
		Next 
	End Method 
	Method DrawBorderUp()
		For Local i:Int = 0 Until 2
			DrawLine getX()-getWidth()/2,getY() -getHeight()/2+(i),getX()+getWidth()/2,getY() - getHeight()/2+(i)
		Next
	End Method
	Method DrawBorderDown()
		For Local i:Int = 0 Until 2
			DrawLine getX()-getWidth()/2,getY() +getHeight()/2-(i),getX()+getWidth()/2,getY() + getHeight()/2-(i)
		Next
	End Method 
	
	
	#rem
	Method getX:Float()
		Return getX()
	End Method
	
	Method getY:Float()
		Return getY()
	End Method 
	
	Method getWidth:Float()
		Return getWidth()
	End Method
	
	Method getHeight:Float()
		Return getHeight()
	End Method 
	#end 
	Method saveField(file:FileStream)
		Local n:Int 
		If getVisible() = True
			n = 100
		Else
			n = 0
		Endif 
		
		file.WriteInt(n)
		file.WriteInt(ValueID)
		saveColorToFile(file)	
	End Method 
	
	Method loadField(file:FileStream)
		Local bV:Int = file.ReadInt()
		If bV = 100
			setVisible(True)
		Else
			setVisible(False)
		Endif 
		
		ValueID = file.ReadInt()
		'Print "loaded ValueID: " + ValueID
		loadColorFromFile(file)
	End Method 
End Class 