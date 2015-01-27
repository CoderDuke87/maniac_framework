#Rem monkeydoc Module maniac.maniacSort
	Sort Module - Version 0.1.0 (alpha)  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	
	This is a Sorting Module.
	At the Moment you can choose between: Shell-, Selection-, Bubble-, Quick-  & Insertion Sort algorithms.
	## ATENTION: it operates on the given Array. It doesn't create a new and returns!!!! ##
	## Your Array Int/Float will be changed after using a Sort-Function##
	
		
	## ISSUE: sorting StringArrays as well
	Version: 0.1.0
		ShellSort - Int,Float Arrays
		SelectionSort - Int,Float
		BubbleSort - int Float
		InsertionSort - int,Float
		QuickSort -int,float
	
		
Example:
<pre>

'This Example shows a little Benchmark-Sort with 10000 Array-Elements


Function Main:Int()
	New Example							
	Return 0
End

Class Example Extends App
	Field arr:Float[]
	Field arr2:Float[]
	Field arr3:Float[]
	Field arr4:float[]
	Field arr5:Float[]
	
	Method OnCreate:Int()
		SetUpdateRate( 60 )
		initManiac(False)	
		Local l:Int = 10000
		arr = New Float[l]
		arr2 = New Float[l]
		arr3 = New Float[l]
		arr4 = New Float[l]
		arr5 = New float[l]
		For Local i:Int = 0 Until l
			arr[i] = Rnd(-452232.2,445342.3)
			arr2[i] = arr[i]
			arr3[i] = arr[i]
			arr4[i] = arr[i]
			arr5[i] = arr[i]
		Next 
		
		
		Print "Sorting"
		
		Local t:Int = Millisecs()
		ShellSort( arr )
		Print "shell time: " + (Millisecs()- t) + " ms"
		
		t = Millisecs()
		SelectionSort( arr2 )
		Print "selection time: " + (Millisecs()- t) + " ms"
		
		t = Millisecs()
		BubbleSort( arr3 )
		Print "Bubble time: " + (Millisecs()- t) + " ms"
		
		t = Millisecs()
		InsertionSort( arr4 )
		Print "Insertion time: " + (Millisecs()- t) + " ms"
		
		Local t2:int = Millisecs()
		QuickSort(arr5, 0, arr5.Length()-5, False )
		Print "Quick time: " + (Millisecs()- t2) + " ms"
		
		For Local i:Int = 0 Until l			
			'Print "("+i+") " + arr5[i]
		Next
	
		Return 0
	End 
</pre>
		
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
		For j = 1 until i
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


Function QuickSort(arr:Float[], L:Int, R:Int, RandomPivot:bool = True )
	Local A, B, SwapA#, SwapB#, Middle#
	A = L
	B = R
	
	
	
	If RandomPivot Then
		Middle = arr[ Rnd(L, R) ]
	Else
		Middle = arr[ (L+R)/2 ]
	EndIf
	
	While True
		
		While arr[ A ] < Middle
			A = A + 1
			If A > R Then Exit
		Wend
		
		While  Middle < arr[ B ]
			B = B - 1
			If B < 0 Then Exit
		Wend
		
		If A > B Then Exit
		
		SwapA = arr[ A ]
		SwapB = arr[ A ]
		arr[ A ] = arr[ B ]
		arr[ A ] = arr[ B ]
		arr[ B ] = SwapA
		arr[ B ] = SwapB
		
		A = A + 1
		B = B - 1
		
		If B < 0 Then Exit
		
	Wend
	
	If L < B Then QuickSort(arr, L, B )
	If A < R Then QuickSort(arr, A, R )
End Function

Function QuickSort(arr:int[], L:Int, R:Int, RandomPivot:bool = True )
	Local A, B, SwapA#, SwapB#, Middle#
	A = L
	B = R
	
	
	
	If RandomPivot Then
		Middle = arr[ Rnd(L, R) ]
	Else
		Middle = arr[ (L+R)/2 ]
	EndIf
	
	While True
		
		While arr[ A ] < Middle
			A = A + 1
			If A > R Then Exit
		Wend
		
		While  Middle < arr[ B ]
			B = B - 1
			If B < 0 Then Exit
		Wend
		
		If A > B Then Exit
		
		SwapA = arr[ A ]
		SwapB = arr[ A ]
		arr[ A ] = arr[ B ]
		arr[ A ] = arr[ B ]
		arr[ B ] = SwapA
		arr[ B ] = SwapB
		
		A = A + 1
		B = B - 1
		
		If B < 0 Then Exit
		
	Wend
	
	If L < B Then QuickSort(arr, L, B )
	If A < R Then QuickSort(arr, A, R )
End Function
