#Rem monkeydoc Module maniac.maniacMisc
	Misc Module - Version 1.0 (alpha)  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	
	Here are all Functions and Classes, that have no Special set or something.
	
	
#End


Import mojo
Import maniacDebug
#If (TARGET <> "html5") And (TARGET <> "flash")
	Import brl.FileSystem
#Endif

#Rem monkeydoc
	This function creates a new 2 Dimensional Int Array with i and j dimensions.
	optionaly You can add a initial Value fill. Standard fill value will then be 0.
	
	<pre>
	Import maniac
	
	Function Main:int()
		local array:Int[][] = Array2D(10,5)
	End Function 
	</pre>
#End
Function Array2D:Int[][] (i:Int, j:Int,fill:Int = 0)
	
    Local arr:Int[][] = New Int[i][]
    For Local ind = 0 Until i
        arr[ind] = New Int[j]
    Next
    
    For Local w:Int = 0 Until i
    	For Local h:Int = 0 Until j
    		arr[w][h] = fill
    	Next
    Next 
    Return arr		
End

#Rem monkeydoc
	This function creates a new 2 Dimensional Int Array with i and j dimensions.
	optionaly You can add a initial Value fill. Standard fill value will then be 0.
	
	<pre>
	Import maniac
	
	Function Main:int()
		local array:Int[][] = Array2D(10,5)
	End Function 
	</pre>
#End
Function Array2Dmf:ManiacField[][] (i:Int, j:Int)
	
    Local arr:ManiacField[][] = New ManiacField[i][]
    For Local ind = 0 Until i
        arr[ind] = New ManiacField[j]
    Next
    
    Return arr		
End
#rem
Function Array3D:Int[][][] (i:Int, j:Int,k:int,fill:Int = 0)
    Local arr:Int[][][] = New Int[i][][]
    For Local ind = 0 Until i
        arr[ind] = New Int[j][]
        For Local ind2:Int = 0 Until j
        	arr[ind][j] = New Int[k]
        Next 
    Next
    
    For Local w:Int = 0 Until i
    	For Local h:Int = 0 Until j
    		For Local o:Int = 0 Until k
    		arr[w][h][o] = fill
    	Next
    Next 
    Return arr		
End
#end

#Rem monkeydoc
	This Functions converts movement Data to Movements per Second.
	It uses the built-in Updating System.
	
	if you want to Move like 200 Pixel in 1 Second, you call
	EqToFPS(PixelPerSecond)
#End
Function EqToFPS:Float(unitsPerSecond:Float) 
	Maniac_Debug.addCalc()
  'Convert the given units-per-second value to units-per-frame
  Return unitsPerSecond * maniac_timeScale
End Function


#Rem monkeydoc
	This Functions Checks if the MouseCursor is within this rectangle dimensions.
	
	_X & _Y are the Top-Left Corner
#End
Function MOBox:Bool(_X:Float, _Y:Float, _Width:Float, _Height:float)
	Maniac_Debug.addTotCall()
	Maniac_Debug.addTotCalc()
		'Maniac_Debug.addTotDraws(2)
	Maniac_Debug.addCalc()
	If _X < MouseX() And _X + _Width > MouseX() And _Y < MouseY() And _Y + _Height > MouseY()
		Return True
	Else
		Return False
	Endif

End Function

#Rem monkeydoc
	This Functions Checks if the MouseCursor is within this circle dimensions.
#End
Function MOCircle:Bool(ix:Int,iy:Int,ir:Int)
	Maniac_Debug.addTotCall()
	Maniac_Debug.addTotCalc()
	Maniac_Debug.addCalc()
	Local dx:Float = ix - MouseX()
	Local dy:Float = iy - MouseY()
						
	Local distance:float = Sqrt( dx*dx + dy*dy )		'berechne den Abstand
						
	'Wenn Abstand geringer als 2*Radius >> Kollision
	If distance < ir
		Return True
	Else
		Return False 
	Endif 
End Function


#Rem monkeydoc
	This Function returns the Time Stamp of the underlaying Operating System as a String.
#End
Const TIMESTAMP_TIME_DATE:Int = 0
Const TIMESTAMP_DATE_TIME:Int = 1
Function GetTimeStamp:String(_Style:Int = 0,_Order:Int = 0)
	'Local currDate:String 
	Maniac_Debug.addCalc()
	Local date:=GetDate()
    
    Local months:=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    
    Local day:=("0"+date[2])[-2..]
    Local month:=months[date[1]-1]
    Local year:=date[0]
    Local hour:=("0"+date[3])[-2..]
    Local min:=("0"+date[4])[-2..]
    Local sec:=("0"+date[5])[-2..] + "." + ("00"+date[6])[-3..]
     
    Local now:String '=hour+":"+min+":"+sec+"  "+day+" "+month+" "+year
    Select _Style
    	Case TIMESTAMP_TIME_DATE
    		now = hour+":"+min+":"+sec+"  "+day+" "+month+" "+year
    	Case TIMESTAMP_DATE_TIME
    		Select _Order
    			Case 0
    				now = year+" "+month+" "+day+"   "+hour+":"+min+":"+sec
    			Case 1
    				now = year+" "+month+" "+day+"   "+hour+":"+min
    			Case 2
    				now = year+" "+month+" "+day
    		End Select 
    		Default 
    End Select   
   
	Return now
End Function

Function Screenshot:Image()
    Local width:Int  = mojo.app.DeviceWidth()
    Local height:Int = mojo.app.DeviceHeight()
    Local img:Image  = mojo.graphics.CreateImage(width,height)
    If img
        Local mem:Int[] = New Int[width*height]
        If mem
            mojo.graphics.ReadPixels(mem,0,0,width,height)
            img.WritePixels(mem,0,0,width,height)
            Return img
        Endif
    Endif
    Return Null
End

#Rem monkeydoc
	This Functions Returns all Files within a Paths as an Array of String 
#End
Function GetFolderFiles:String[](path:String)
	Local i:=0
	Local lfiles:String[] = New String[1000]
	
	
    For Local f:=Eachin LoadDir( path,True )
    	Local p:=path+f
        Local nm:=(f+"                    ")[..20]
       	Local ty:=""
        If FileType( p )=FILETYPE_FILE
        	lfiles[i] = p
       	 	i +=1
       		Print p
    	Else
            Print "### DIR ### " + i
       Endif
       
       'Print i
       
    Next
    
    Local files:String[] = New String[i]
    For Local j:Int = 0 Until i
       	files[j] = lfiles[j]
       	'Print files[j] '+" | " + lfiles[j]
    Next 
    #rem
    For Local i:Int = 0 Until files.Length()
    	Print "loeaded: " + files[i]
    Next 
    #end 
       'Print "files: " + files.Length()
      Return files 
End Function

Function GetFolderFiles2:List<String>(_Path:String)
	Local list:List<String> = New List<String>
	
	For Local f:=Eachin LoadDir(_Path,True )
    	Local p:=_Path+f
        'Local nm:=(f+"                    ")[..20]
       	'Local ty:=""
        If FileType( p )=FILETYPE_FILE
        	list.AddLast(p)
       		Print p
    	Else
            Print "### DIR ### " 
       Endif
              
    Next
	
	Print "loaded Files: " + list.Count()
	
	Return list
End Function 
