#Rem monkeydoc Module maniac.maniacSpline
	Spline - Version 0.1 (alpha)  ~n
	
	Converted from BlitzMax Code ... 
	
	
	
#End


Function MakePoints(Points:Point[])
	For Local p:Int=0 Until Points.Length
		Points[p]=New Point
		Points[p].x=Rnd(50,750)
		Points[p].y=Rnd(100,550)
	Next
End Function




' akima interpolation requires 6 points 
' interpolate between y3 And y4 at position mu (0..1)
'----------------------------------------------------------------------------
Function AkimaInterpolate:Float(y1:Float, y2:Float, y3:Float, y4:Float, y5:Float, y6:Float, mu:Float)

	Local num1:Float = Abs((y5-y4)- (y4-y3))*(y3-y2) + Abs((y3-y2) - (y2-y1))*(y4-y3)
	Local den1:Float = Abs((y5-y4) - (y4-y3)) + Abs((y3-y2) - (y2-y1))
	
	Local num2:Float = Abs((y6-y5)- (y5-y4))*(y4-y3) + Abs((y4-y3) - (y3-y2))*(y5-y4)
	Local den2:Float = Abs((y6-y5) - (y5-y4)) + Abs((y4-y3) - (y3-y2))
	
	Local t1:Float
	If den1>0.00001 Then   '0
		t1=num1/den1
	Else
		t1=0.0
	EndIf
	
	Local t2:Float
	If den2>0.00001 Then   '0
		t2=num2/den2
	Else
		t2=0.0
	EndIf
	
	Local C:Float = (3*(y4-y3) - 2*t1 - t2)
	Local D:Float = (t1 + t2 - 2*(y4-y3))
	
	Return  y3 + (t1 + (C + D*mu)*mu)*mu

End Function




'interpolate between y1 and y2
Function CubicInterpolate:Float(y0:Float, y1:Float, y2:Float, y3:Float, mu:Float)
   Local a0#,a1#,a2#,a3#,mu2#

   mu2 = mu*mu
   a0 = y3-y2-y0+y1
   a1 = y0-y1-a0
   a2 = y2-y0
   a3 = y1
   
   Return a0*mu*mu2+a1*mu2+a2*mu+a3
End Function

Class Point
	Field x:Int
	Field y:Int
	
	#rem
	Method New(_X:Float,_Y:Float)
		x = _X
		y = _Y
	End Method 
	#end
	Function Create:point(x#,y#)
		Local p:point=New point
		p.x=x
		p.y=y
		Return p
	End Function
End Class 
