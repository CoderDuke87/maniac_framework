#Rem monkeydoc Module maniac.maniacDebug
	Debug Module - Version 0.1.2 (alpha)  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	~n
	This Module keeps tracking of all created and rendered objects of this Framework.~n
	you can even let them monitor as it has its own graphical output.~n
	
	I recommand to use this only for Debug-propose and switch it off for release Versions.~n
#End
Import mojo
Import maniac

#Rem monkeydoc
	Main Class of this Module~n
	Monitor:~n
	Objects that are Registered, Images Loaded, Stored Int,Float,Strings
	FPS, Method-Calls (/Frame ; /Second) , RunTime
	payload %CPU, % DrawTime, % UpdateTime
#End
Class Maniac_Debug

	'#### Static Data ####
	Global appStartTime:Int 
	Global appRunTime:int
	Global registeredObjects:Int 	= 0			'Shows the number of all Registered maniac Objects, like Buttons, Sliders and stuff
	Global registeredGraphics:Int 	= 0			'Shows the number of all Loaded Graphics like Png,Jpg & co
	Global registeredSounds:Int		= 0
	
	Global storedBools:Int			= 0
	Global storedInts:Int			= 0
	Global storedFloats:Int			= 0
	Global storedStrings:Int		= 0
	
	Global totCALLS:Int				= 0
	Global totDRAWS:Int				= 0
	Global totCALCS:Int				= 0

	Function addStoredBools:Void(_Number:Int = 1)
		storedBools +=_Number
	End Function 
	Function addStoredInts:Void(_Number:Int = 1)
		storedInts +=_Number
	End Function 
	Function addStoredFloats:Void(_Number:Int = 1)
		storedFloats +=_Number
	End Function
	Function addStoredStrings:Void(_Number:Int = 1)
		storedStrings +=_Number
	End Function
	Function addTotCall:Void(_Number:Int = 1)
		totCALLS +=_Number
	End Function 
	Function addTotDraws:Void(_Number:Int = 1)
		totDRAWS +=_Number
		sumDRAW +=_Number
	End Function 
	Function addTotCalc:Void(_Number:Int = 1)
		totCALCS +=_Number
	End Function
	
	global sumROPS:Int
	Global sumCALC:Float
	Global sumDrawTime:Int
	Global sumUpdateTime:Int
	Global sumCALL:Float 
	Global sumDRAW:Float 
	
	'#### SHOWABLE DATA ####
	Field avgROPS:Float
	Field payloadCPU:Float 
	Field avgCALC:Float
	Field avgDRAW:float
	Field avgCALL:Float 
	
	
	
	
	Global curRenderedObjects:Int  
	Global totRenderedObjects:Float = 0
	
	Global DrawTimePerSecond:Float
	 
	
	Global UpdateTimePerSecond:Float
	 
	Field renderedObjectsPerFrame:Int 
	Field renderedObjectsPerSecond:Int 
	
	
	Field intervallTime:Int = 1000
	 
	
	  
	 
	Field curTime:Int = 0
	Field lastTime:Int = 0
	Field curFPS:Int = 0
	Field fpsHistory:List<int> = New List<int>
	Field visible:Int = FPSGRAPH_GRAPH
	Field drawBG:Bool = true
	Field graphSize:Int = 2
	Field graphMax:Int = 300
	
	'#### VISUAL STYLES ####
	Field X:Float '= 0
	Field Y:Float '= 0
	Field Width:Float
	Field Height:Float
	
	Field lastUpdateCallTime:Int
	Field lastDrawCallTime:Int
	
	Field lastUpdatedTime:Int 
	
	'Field 
	 
	Method New(_X:Float,_Y:Float,_Width:Float,_Height:Float)
		X		= _X
		Y		= _Y
		Width	= _Width
		Height	=_Height
		graphMax = _Width/2
		appStartTime = Millisecs()
	End Method 
	
	
	Function addRegisteredObject()
		registeredObjects += 1
	End Function 
	
	Function getNumberOfRegisteredObjects:Int()
		Return registeredObjects
	End Function 
	
	Function addRegisteredGraphics()
		registeredGraphics += 1
	End Function 
	
	Function getNumberOfRegisteredGraphics:Int()
		Return registeredGraphics
	End Function 
	
	Function addRenderedObject:Void()
		curRenderedObjects +=1
		totRenderedObjects +=1
		sumROPS += 1
	End Function 
	
	Function addRenderTime(time:Int)
		sumDrawTime += time
	End Function 
	Function addUpdateTime(time:Int)
		'Print "added: " + time
		sumUpdateTime += time
	End Function
	
	Function addCalc:Void(_Number:Int = 1)
		sumCALC += _Number
	End Function 
	
	Function addCall:Void()
		sumCALL +=1
	End Function 
	
	'summary: draws FPS counter and a smoothed graph of FPS history
	Method Draw:Void()
		If visible = FPSGRAPH_OFF Then Return
		
		If Millisecs()-lastUpdatedTime >= intervallTime
			avgROPS = sumROPS/(intervallTime/1000)
			sumROPS = 0
			
			DrawTimePerSecond = sumDrawTime/(intervallTime/1000)
			sumDrawTime = 0
			
			UpdateTimePerSecond = sumUpdateTime/(intervallTime/1000)
			sumUpdateTime = 0
			
			payloadCPU = (DrawTimePerSecond+UpdateTimePerSecond)/10
			
			avgCALC = sumCALC/(intervallTime/1000)
			sumCALC = 0
			
			avgDRAW = sumDRAW/(intervallTime/1000)
			sumDRAW = 0
			lastUpdatedTime = Millisecs()
		Endif 
		SetAlpha 0.3
		SetColor 60,60,60
		DrawRect(X, Y, Width, Height)
		
		SetAlpha 0.9
		Drw_Rect(X,Y, Width, Height, 4)
		
		
		Update()
		
		
		SetColor 0, 0, 0
		PushMatrix()
		Scale 1, 1
		Translate(X, Y)
		
		Local ur:Int = UpdateRate()
		' for graph, draw a background of the appropriate size
		If drawBG = True Then
			DrawRect(X, Y, Width, Height)
		EndIf
		
		SetColor 255, 255, 255
		DrawText(curFPS + " fps   | " + Int(payloadCPU)+ " % CPU | " + avgCALC+" Calcs/s   | " + avgDRAW+" Draws/s ", 2, 0)
		' put the next at the far end
		DrawText(curFPS + " fps   | " + avgROPS+" rops   | tot Rendered Objects: " + totRenderedObjects, 5, 80)
		
		DrawText("STATIC DATA    Stored: Bools: "+storedBools + " , Ints: " + storedInts + " , Floats: " + storedFloats,5,100)
		DrawText("Registered Objects: " + registeredObjects + " , Images: " +registeredGraphics + " , Sounds: " + registeredSounds + "  || In Total: Calls: " + totCALLS + " , Draws: " + totDRAWS + " | Calc: " + totCALCS ,5,115)
		
		DrawText("DYNAMIC STATS",5,130)
		DrawText("Usage Drawing: " + DrawTimePerSecond + " ms/s , Updating: " + UpdateTimePerSecond ,5,155)
		DrawText("CPU Payload: " + payloadCPU + " %",5,160)
		DrawText("Avg Calc per Second " + avgCALC + " %",5,175)
		
		Local xOffset:Int = 1
		Local lastFPS:Int = 0
		
		For Local i:Int = EachIn fpsHistory
			
			' gray background is 100% accurate to the FPS
			SetAlpha 0.25
			SetColor 0, 0, 0
			DrawRect(xOffset, 75 - i, graphSize, i)
			
			' faded colored rect to show actual value, but backgrounded
			SetAlpha 0.8
			SetColor(255 - (i * 2), 100 + (i * 2), 50)
			DrawRect(xOffset, 75 - i, graphSize, graphSize)
			SetAlpha 1
			
			' smoothing for the line which is fully visible
			Local gap:Int = i - lastFPS
			If gap > 0 Then i = i - gap * 0.75
			
			' colorcode line
			Local ratio:Float = Float(i) / Float(ur)
			SetColor(255 - ratio * 255, ratio * 255, 0)
			
			' line is smoothed
			DrawLine(xOffset, 75 - i, xOffset - graphSize, 75 - lastFPS)
			SetColor 255, 255, 255
			
			' if FPS falls by half, insert marker of what it fell to
			If i < ur / 2 And xOffset / graphSize > 30
				DrawText(i, xOffset - 30, Max(75 - i, 60))
			EndIf
			
			xOffset = xOffset + graphSize
			lastFPS = i
		Next
		PopMatrix()
		SetColor 255, 255, 255
		
		#rem
		
		
		
		
		
		' for FPS only, just draw it at the X and Y
		If visible = FPSGRAPH_FPS_ONLY
			SetColor 255, 255, 255
			DrawText(curFPS + "fps", X,Y)
			Return
		Endif
		
		SetColor 255,255,255
		If drawBG = True Then
			DrawRect(X, Y, Width, Height)
		EndIf
		#end
		#rem
		Local ur:Int = UpdateRate()
		' for graph, draw a background of the appropriate size
		If drawBG = True Then
			DrawRect(X, Y, Width, Height)
		EndIf
		
		SetColor 255, 255, 255
		
		' put the next at the far end
		'DrawText(curFPS + "fps", graphMax * graphSize - 50, 0)

		Local xOffset:Int = 5
		Local lastFPS:Int = 0
		
		#end
		'SetColor 255, 255, 255
	End
	
	'summary: updates FPS counter and history
	Method Update:Void()
		lastTime = curTime
		curTime = Millisecs()
		Local elapsedtime:Int = curTime - lastTime
		curFPS = 1000 / (elapsedtime + 1)
		
		' don't bother showing FPS above max; it's a math issue
		Local ur:Int = UpdateRate()
		If curFPS > ur Then curFPS = ur
		
		' maintain history
		fpsHistory.AddLast(curFPS)
		Local c:Int = fpsHistory.Count()
		If c > graphMax
			fpsHistory.RemoveFirst()
		EndIf
		
		' shorthand toggle
		If KeyHit(KEY_F)
			visible += 1
			If visible > FPSGRAPH_GRAPH Then visible = FPSGRAPH_OFF
		EndIf
	End
	
	'summary: returns the FPS last frame
	Method FPS:Int()
		Return curFPS
	End

	'summary: sets FPS display. 0: off, 1: FPS only, 2:full graph.	
	Method Visible:Void(set:Int)
		visible = set
	End
	
	'summary:returns a list of the last N recorded FPS rates
	Method History:List<int>()
		Return fpsHistory
	End
End Class 
