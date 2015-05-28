

Class ManiacDropDown
	Field maniacID:Int 
	Field X:Float
	Field Y:Float
	Field Width:Float
	Field Height:Float
	Field bOpened:Bool 
	Field Caption:String
	
	Field listTextElements:List<textElement>
	
	Field showOpenHeader:Int	= 1		'0 - Always Show Caption, 1 - Show MouseOver Elements , 2 - Show Selected Element
	Field showCloseHeader:Int 	= 2
	Field bCloseOnSelected:Bool = True 
	Field bWrapToLines:Bool 
	Field ShowLines:Int 	= 0
	Field ScrolledLines:Int = 0
	
	Field MOElement:Int 
	Field SelectedElement:Int = 0
	
	Field bSound:Bool = True 
	
	Field tweenY:Tween
	
End Class 