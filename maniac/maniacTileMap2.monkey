Class ManiacTileMap2
	Field gMapName:String
	Field gManiacID:Int
	Field X:Float,Y:Float,Width:Float,Height:Float	
	
	Field cursorX:Int
	Field cursorY:Int
	
	Field arrLayer:mTileMapLayer[]
	
	
	#rem monkeydoc
		This Constructor-Method creates an empty TileMap with ViewSize to _X,_Y,_Width,_Height ~n
		with _ix * _iy Fields.
	#end 
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float,_ix:Int,_iy:Int,_NrOfLayer:Int= 1)
		MapArray = Array2Dmtf(_X,_Y,_Width,_Height,_ix, _iy)

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
	
	
	Method getLayer:mTileMapLayer(_LayerID:Int)
		Return arrLayer[_LayerID]
	End Method 
	
	Method DrawMap()
		For Local i:Int = 0 Until arrLayer.Length()
			arrLayer[i].Draw()
		Next 
	End Method
	
	Method DrawMap(_LayerID:Int)
		If arrLayer[_LayerID] = Null
			 
		Else
			arrLayer[_LayerID].Draw()
		Endif 
	End Method 
	
	Method UpdateMap:Void()
		Local currCPosX = ll_GridX(currFW, X)
		Local currCPosY = ll_GridY(currFH, Y)
	End Method 
End Class 

#rem monkeydoc
Example:
<pre>
#rem
Map:
#########################################
#Field	#		#		#		#		#
#		#		#		#		#		#
#		#		#		#		#		#
#		#		#		#		#		#
#########################################
#		#		#		#		#		#
#		#		#		#		#		#
#		#		#		#		#		#
#########################################
#		#		#		#		#		#
#		#		#		#		#		#
#		#		#		#		#		#
#########################################
#		#		#		#		#		#
#		#		#		#		#		#
#		#		#		#		#		#
#########################################
#end 
</pre>
#end
Class mTileMapLayer
	Field LayerID:Int 
	
	Field arrFields:ManiacTileField2[][]
	Field MapX:Int
	Field MapY:Int
	Field currFW:Float		'Field Width in Pixel
	Field currFH:Float		'Field Height in Pxl
	
	
End Class 