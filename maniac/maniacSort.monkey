#Rem monkeydoc Module maniac.maniacSort
	Sort Module - Version 0.1.0 (alpha)  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	
	This is a Sorting Module.
	At the Moment you can choose between: Shell-, Selection-, Bubble- & Insertion Sort algorithms.
	## ATENTION: it operates on the given Array. It doesn't create a new and returns!!!! ##
	## Your Array Int/Float will be changed after using a Sort-Function##
	
		
	## ISSUE: sorting StringArrays as well
	Version: 0.1.0
		ShellSort - Int,Float Arrays
		SelectionSort - Int,Float
		BubbleSort - int Float
		InsertionSort - int,Float
	
		
		
#End


Function ShellSort( arr:Float[]  )
	Local i:Int
	Local j:Int
	Local increment:Float
	Local temp:float
	
	increment = 3
	While increment > 0
			For i = 0 Until arr.Length()
				j = i
				temp = arr[ i ]
				While j >= increment And arr[j-increment] > temp
						arr[j] = arr[j-increment]
						j = j - increment
				Wend
				arr[j] = temp
			Next
			If increment/2 <> 0 Then
				increment = increment / 2
			ElseIf increment = 1
				increment = 0
			Else
				increment = 1
			EndIf
	Wend
End Function


Function ShellSort( arr:int[]  )
	Local i:Int
	Local j:Int
	Local increment:Float
	Local temp:float
	
	increment = 3
	While increment > 0
			For i = 0 Until arr.Length()
				j = i
				temp = arr[ i ]
				While j >= increment And arr[j-increment] > temp
						arr[j] = arr[j-increment]
						j = j - increment
				Wend
				arr[j] = temp
			Next
			If increment/2 <> 0 Then
				increment = increment / 2
			ElseIf increment = 1
				increment = 0
			Else
				increment = 1
			EndIf
	Wend
End Function



Function SelectionSort( arr:int[] )
	Local i:Int
	Local j:Int
	Local min:int
	Local temp:float
	For i = 0 until arr.Length()
		min = i
		For j = i+1 until arr.Length()
			If arr[j] < arr[min] Then min = j
		Next
		temp = arr[ i ]
		arr[ i ] = arr[min]
		arr[min] = temp
	Next
End Function


Function SelectionSort( arr:float[] )
	Local i:Int
	Local j:Int
	Local min:int
	Local temp:float
	For i = 0 until arr.Length()
		min = i
		For j = i+1 until arr.Length()
			If arr[j] < arr[min] Then min = j
		Next
		temp = arr[ i ]
		arr[ i ] = arr[min]
		arr[min] = temp
	Next
End Function


Function BubbleSort( arr:int[] )
	Local i:Int 
	Local j:Int
	Local temp:float
	
	For i = arr.Length() To 0 Step -1
		For j = 1 To i
			If arr[ j - 1 ] > arr[ j ] Then
				temp = arr[ j - 1 ]
				arr[ j - 1 ] = arr[ j ]
				arr[ j ] = temp
			EndIf
		Next
	Next
End Function


Function BubbleSort( arr:float[] )
	Local i:Int 
	Local j:Int
	Local temp:float
	
	For i = arr.Length() To 0 Step -1
		For j = 1 To i
			If arr[ j - 1 ] > arr[ j ] Then
				temp = arr[ j - 1 ]
				arr[ j - 1 ] = arr[ j ]
				arr[ j ] = temp
			EndIf
		Next
	Next
End Function


Function InsertionSort( arr:int[] )
	Local i:Int 
	Local j:Int
	Local index:int
	
	For i = 1 until arr.Length() - 1
		index = arr[ i ]
		j = i
		While j > 0 And arr[ j-1 ] > index
			arr[ j ] = arr[ j - 1 ]
			j = j - 1
		Wend
		arr[ j ] = index
	Next
End Function

Function InsertionSort( arr:float[] )
	Local i:Int 
	Local j:Int
	Local index:int
	
	For i = 1 until arr.Length() - 1
		index = arr[ i ]
		j = i
		While j > 0 And arr[ j-1 ] > index
			arr[ j ] = arr[ j - 1 ]
			j = j - 1
		Wend
		arr[ j ] = index
	Next
End Function

#rem
Function QuickSort( L, R, RandomPivot = True )
	Local A, B, SwapA#, SwapB#, Middle#
	A = L
	B = R
	
	If RandomPivot Then
		Middle = SortArray( Rand(L, R) )
	Else
		Middle = SortArray( (L+R)/2 )
	EndIf
	
	While True
		
		While SortArray( A ) < Middle
			A = A + 1
			If A > R Then Exit
		Wend
		
		While  Middle < SortArray( B )
			B = B - 1
			If B < 0 Then Exit
		Wend
		
		If A > B Then Exit
		
		SwapA = SortArray( A )
		SwapB = SortArray( A )
		SortArray( A ) = SortArray( B )
		SortArray( A ) = SortArray( B )
		SortArray( B ) = SwapA
		SortArray( B ) = SwapB
		
		A = A + 1
		B = B - 1
		
		If B < 0 Then Exit
		
	Wend
	
	If L < B Then QuickSort( L, B )
	If A < R Then QuickSort( A, R )
End Function

#end
