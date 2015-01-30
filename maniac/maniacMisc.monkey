#Rem monkeydoc Module maniac.maniacMisc
	Misc Module - Version 1.0 (alpha)  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	
	Here are all Functions and Classes, that have no Special set or something.
	
	
#End


Import mojo
Import maniacDebug
Import maniacString
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
	This function creates a new 2 Dimensional String Array with i and j dimensions.
	optionaly You can add a initial Value fill. Standard fill value will then be 0.
	
	<pre>
	Import maniac
	
	Function Main:int()
		local array:Int[][] = Array2D(10,5)
	End Function 
	</pre>
#End
Function Array2Dstr:String[][] (i:Int, j:Int,fill:String = "")
	
    Local arr:String[][] = New String[i][]
    For Local ind = 0 Until i
        arr[ind] = New String[j]
    Next
    
    For Local w:Int = 0 Until i
    	For Local h:Int = 0 Until j
    		arr[w][h] = fill
    	Next
    Next 
    Return arr		
End


#Rem monkeydoc
	This function creates a new 2 Dimensional maniacField Array with i and j dimensions.
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
	EqToFPS(200)
#End
Function EqToFPS:Float(unitsPerSecond:Float)
	If MANIAC_DEBUG = True 
		Maniac_Debug.addCalc()
	Endif 
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


#rem monkeydoc
	Checks, if the Mousecursor is inbetween an Triangle (x1,y1,y2,y2,y3,y3)
#end
Function MOTriangle:Bool(x1:Float,y1:Float,x2:Float,y2:Float,x3:Float,y3:Float) 

	local b0:float =  (x2 - x1) * (y3 - y1) - (x3 - x1) * (y2 - y1)
	Local b1:Float = ((x2 - MouseX()) * (y3 - y0) - (x3 - x0) * (y2 - MouseY())) / b0 
	If b1 <= 0 Then Return False
	
	Local b2:Float = ((x3 - MouseX()) * (y1 - y0) - (x1 - x0) * (y3 - MouseY())) / b0
	If b2 <= 0 Then Return False

	Local b3:float = ((x1 - MouseX()) * (y2 - y0) - (x2 - x0) * (y1 - MouseY())) / b0 
	If b3 <= 0 Then Return False
	
	Return True

End Function


#rem monkeydoc
	Checks, if a Point (x0,y0) is inbetween an Triangle (x1,y1,y2,y2,y3,y3
#end
Function InTriangle:Bool(x0,y0,x1,y1,x2,y2,x3,y3)

	local b0:float =  (x2 - x1) * (y3 - y1) - (x3 - x1) * (y2 - y1)
	Local b1:float = ((x2 - x0) * (y3 - y0) - (x3 - x0) * (y2 - y0)) / b0 
	If b1 <= 0 Then Return False
	
	Local b2:Float = ((x3 - x0) * (y1 - y0) - (x1 - x0) * (y3 - y0)) / b0
	If b2 <= 0 Then Return False

	Local b3:float = ((x1 - x0) * (y2 - y0) - (x2 - x0) * (y1 - y0)) / b0 
	If b3 <= 0 Then Return False
	
	Return True

End Function


Function InterpolateAngle:Float(a:Float,b:Float,blend:Float = 0.5)
	Local ix# = Sin(a)
	Local iy# = Cos(a)
	Local jx# = Sin(b)
	Local jy# = Cos(b)
	Return ATan2(ix-(ix-jx)*blend,iy-(iy-jy)*blend)
End Function


#Rem monkeydoc
	This Function returns the Time Stamp of the underlaying Operating System as a String.
#End
Const TIMESTAMP_TIME_DATE:Int = 0
Const TIMESTAMP_DATE_TIME:Int = 1
Const TIMESTAMP_DATE_ONLY:Int = 2
Const TIMESTAMP_TIME_ONLY:Int = 3

Function GetTimeStamp:String(_Style:Int = 0,_Order:Int = 0)
	'Local currDate:String 
	'Maniac_Debug.addCalc()
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
    	 
    	Case TIMESTAMP_DATE_ONLY
    		Select _Order
    			Case 0
    				now = month+"_"+day
    		End Select 
    	Case TIMESTAMP_TIME_ONLY
    	
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

#rem
; Returns a string with the Roman numerals for value v
; This will Not be accurate for numbers > 3999 as the number
; 5000 should be represented as an M with a line above it etc, however as we
; do not have such a character I have used N, O, P.. etc for larger numbers, but see printroman...
#end 

Function roman:String(v:Int )
	Local r:String="IVXLCDMNPQRSTUWYZ"
	Local n:String = v 
	Local i:Int = n.Length()*2 - 1
	Local rom:String 
	For Local x:Int = 1 To n.Length()
		Local d:Int = StrToInt(Mid(n,x,1))
		Select d
			Case 1
				'rom = rom + String( Mid(r ,i,1),d )
				'Print "j"
				rom = rom + "I"
			Case 2
				'rom = rom +String (Mid (r ,i,1),d)
				rom = rom + "II"
			Case 3
				'rom = rom +String (Mid (r ,i,1),d)
				rom = rom + "III"
				
			Case 4		
				rom = rom + Mid(r,i,1) + Mid(r,i+1,1)
			Case 5		; rom = rom+Mid(r,i+1,1)
			Case 6,7,8	; rom = rom+Mid(r,i+1,1)+ (Mid (r,i,1))
			Case 9		; rom = rom+Mid(r,i,1)+Mid(r,i+2,1)
			
		End Select
		i=i-2
	Next
	Return rom
End Function


Function ConvertFloatToString:String(ifloat:Float,ilength:Int,ibconv:Bool = False)
	  
	Local bSuffix:Int = 0
	Local nf:Float = (ifloat / 1000.0)
	If nf < 1001
		bSuffix = 1
	Else 
		bSuffix = 2
		nf = nf/1000
		If (nf/1000) < 1000
			bSuffix = 3
		Endif 
	Endif 
	Local str:String = nf

	Local arr:Int[] = str.ToChars()

	Local number:String 
	Local npos:Int = 0
	For Local pos:Int = 0 To arr.Length()-1
	
		Local char:String = String.FromChar(arr[pos])
		
		If npos <= ilength
			number += char
		Endif 
		 
		npos +=1
	Next 
	Select bSuffix
		Case 0
		Case 1
			number += " k"
		Case 2
			number += " M"
		Case 3
			number += " G"
	End Select 
	Return number 
End Function

Class ManiacTextFile

	Field filecontent:String
	Field currentline:String
	Field remaininglines:String

	Method New(filename:String)
	
		filecontent = LoadString(filename)	' Load text file into string
		remaininglines = filecontent.Replace("~n","") 'Remove newline characters
	
	End

	
	Method Eof:Bool() 'check for End-of-file - returns true if end of file reached

		If remaininglines = ""
			
			Return True
		Else
			'Print "left: " + remaininglines
			Return False
		Endif
	
	End 
	
	Method GetLine:String()
	
		Return currentline	'return the current line in the text file
	
	End 
	
	Method ReadLine:Void()	'read the next line in the file into the currentline
		Local newlinecharindex:Int
		
		If Eof()
		
		Else
		
			newlinecharindex = remaininglines.Find("~r") 'look for carriage returns and return the text that is before that..
			currentline = remaininglines[0..newlinecharindex]
			remaininglines = remaininglines[newlinecharindex+1..]
			
	 	Endif 
	
	End 

	Method GetDataName:String() 
		' see example for details on how this is used, basically returns text in the current line before the equals sign, useful for config files and the like
		
		Local equalsposition:Int
		equalsposition = currentline.Find("=")
		
		If equalsposition = -1 Then Return "" Else Return currentline[0..equalsposition]
		
	
	End 


	Method GetDataValue:String()
	' see example for details on how this is used, basically returns text in the line after the equals sign..useful for config files and the like
	
		Local equalsposition:Int
		equalsposition = currentline.Find("=")
		
		
		If equalsposition = -1 Then 
			Return "" 
		Else 
			Return currentline[equalsposition+1..]
		Endif 
	End


End Class





