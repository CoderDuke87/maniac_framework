#Rem monkeydoc Module maniac.maniacGraphics
	Graphics Module - Version 1.0 (alpha)  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	
	Here You can find some "ad-Hoc" Graphic-Elements to use for your App.~n
	They have to be managed by the Programmer.~n
	
	VERSION HISTORY: ~n
	1.0.0-rv1	@ 19.07.2015
		- Added some Orange,Magenta and Purple
		
	1.0.0	@ 29.05.2015~n
		- Updated the documentary~n
		- Drw_Ellipsis, Drw_Grid, Drw_ManiacText are now rotatable~n
		
	0.1.3~n
		Added some Browns~n
		Drw_Rect is now rotateable~n
		completed Drw_ManiacText with Width & Height Alignment~n
		Recoded Drw_Grid~n
	
	0.1.2~n
		Added: some more Green , Blue & Yellow Colors~n
		Added ManiacImage~n
		Added Drw_ManiacText~n
	0.1.1~n
		Added Lighning,Maniac_Color~n
		~n
	
		
		
#End

Import maniac
#rem
Import mojo
Import maniacLowLevel
Import maniacDebug
#end 
#rem
	Included Functions:
		- Drawing outline Rect
		- Drawing an outlining Ellipsis
		- Drawing a Lighning Effect
		- Drawing a Grid
		- Set the Current Color to RenderMode with Maniac_Color using Maniac_Color Convention
		- ManiacImage Class

#end 
#Rem monkeydoc
	### READY TO USE ###~n
	This Function Draws a Outlining Rectangle at the Position _X,_Y with the Dimensions _Witdth and _Height with the thickness _Thickness.
	You must call this within the OnRender() Method
#End
Function Drw_Rect:Int(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Thickness:Int=1,_Angle:Float = 0.0)
	'Maniac_Debug.addRenderedObject()
'	If MANIAC_DEBUG = True
	'	Maniac_Debug.addTotDraws(4*_Thickness)
	'endif
	
	'### Rotate The Matrix at the MidX/MidY Position around Angle
	If _Angle <> 0.0
		RotateAt(_X+_Width/2,_Y+_Height/2, _Angle)
	Endif 
	
	'### Drawing the Outline Rect with Thickness in Pixels for the Frame
	For Local i:Int = 0 until _Thickness
		'Obere Kante
		DrawLine (_X-i,_Y-i,_X +_Width+i,_Y-i)
		
		'Untere Kante
		DrawLine (_X-i,_Y+_Height+i,_X+_Width+i,_Y+_Height+i)
		
		'Linke Seite
		DrawLine (_X-i,_Y-i,_X-i,_Y+_Height+i)
		
		'Recht Seite
		DrawLine (_X+_Width+i,_Y-i,_X+_Width+i,_Y+_Height+i)
	Next 
	
	'### Reset The MAtrix
	If _Angle <> 0.0
		ResetMatrix()
	Endif 
End Function


#Rem monkeydoc
	### READY TO USE ###~n
	This Function Draws a outlining ellipsis at _X,_Y with the Dimensions _Witdth and _Height and the number of cells in x and y direction.
	You must call this within the OnRender() Method
#End
Function Drw_Ellipsis( posx:Float, posy:Float, width:Float, height:Float,_Angle:Float = 0.0)
	
	'### Rotate The Matrix at the MidX/MidY Position around Angle
	If _Angle <> 0.0
		RotateAt(_X+_Width/2,_Y+_Height/2, _Angle)
	Endif
	
   	Local x:Float 
   	Local y:Float 
   	Local rx:Float = width / 2
   	Local ry:Float = height / 2

   	Local r:Int = Abs(rx) + Abs(ry)

   	x = 0
   	y = r
   
   	Local d:Int 
   	Local ddf_x:Int 
   	Local ddf_y:Int 
   
   	d = 1 - r
   	ddf_x = 3
	ddf_y = -2 * r + 5
   
   	While y >= x And r
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotDraws(8)
		endif
	    DrawPoint( posx + x * rx/r, posy + y * ry/r )
	    DrawPoint( posx + y * rx/r, posy + x * ry/r )
	    DrawPoint( posx + y * rx/r, posy - x * ry/r )
	    DrawPoint( posx + x * rx/r, posy - y * ry/r )
	    DrawPoint( posx - x * rx/r, posy - y * ry/r )
	    DrawPoint( posx - y * rx/r, posy - x * ry/r )
	    DrawPoint( posx - y * rx/r, posy + x * ry/r )
	    DrawPoint( posx - x * rx/r, posy + y * ry/r )
	       
	    If d < 0
	       d= d + ddf_x
	       ddf_x= ddf_x+ 2
	       ddf_y=ddf_y+ 2
	       x=x + 1
	    Else
	       d= d+ ddf_y
	       ddf_x=ddf_x+ 2
	       ddf_y=ddf_y+ 4
	       x=x+ 1
	       y=y- 1  
	    EndIf
	Wend
	
	'### Reset The MAtrix
	If _Angle <> 0.0
		ResetMatrix()
	Endif 
End Function 


#Rem monkeydoc
	### READY TO USE ###~n
	This Function Draws a outlining Circle at _X,_Y (Middle) with the radius _Radius.
	You must call this within the OnRender() Method
#End
Function Drw_Circle( posx:Float, posy:Float, _Radius:Float)
	
   	Local x:Float 
   	Local y:Float 
   	Local rx:Float = _Radius / 2
   	Local ry:Float = _Radius / 2

   	Local r:Int = Abs(rx) + Abs(ry)

   	x = 0
   	y = r
   
   	Local d:Int 
   	Local ddf_x:Int 
   	Local ddf_y:Int 
   
   	d = 1 - r
   	ddf_x = 3
	ddf_y = -2 * r + 5
   
   	While y >= x And r
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotDraws(8)
		endif
	    DrawPoint( posx + x * rx/r, posy + y * ry/r )
	    DrawPoint( posx + y * rx/r, posy + x * ry/r )
	    DrawPoint( posx + y * rx/r, posy - x * ry/r )
	    DrawPoint( posx + x * rx/r, posy - y * ry/r )
	    DrawPoint( posx - x * rx/r, posy - y * ry/r )
	    DrawPoint( posx - y * rx/r, posy - x * ry/r )
	    DrawPoint( posx - y * rx/r, posy + x * ry/r )
	    DrawPoint( posx - x * rx/r, posy + y * ry/r )
	       
	    If d < 0
	       d= d + ddf_x
	       ddf_x= ddf_x+ 2
	       ddf_y=ddf_y+ 2
	       x=x + 1
	    Else
	       d= d+ ddf_y
	       ddf_x=ddf_x+ 2
	       ddf_y=ddf_y+ 4
	       x=x+ 1
	       y=y- 1  
	    EndIf
	Wend
End Function 


#Rem monkeydoc
	### READY TO USE ###~n
	This Function Draws a Grid at the Position _X,_Y with the Dimensions _Witdth and _Height and the number of cells in x and y direction
	You must call this within the OnRender() Method
#End
Function Drw_Grid:Void(_X:Float,_Y:Float,_Width:Float,_Height:Float,_CellsX:Int,_CellsY:Int,_Angle:Float = 0.0)
	If MANIAC_DEBUG = True
		Maniac_Debug.addTotDraws(2*_CellsX*_CellsY)
	endif
	'zeichnet ein Gitter an Position posx,posy (links oben), w/h breite bzw. hÃƒÂ¶he (des gesamten Grids) und zieht dabei cntx/cnty striche in der horizontalen,bzw vertikalen
	'allerdings wird hierbei das Gitter automatisch angepasst
	'### Rotate The Matrix at the MidX/MidY Position around Angle
	If _Angle <> 0.0
		RotateAt(_X+_Width/2,_Y+_Height/2, _Angle)
	Endif
	
	
	'1. bestimmen der breite eines KÃƒÂ¤stchens anhand der Breite und der anzahl
	Local cell_w:Float = _Width/_CellsX
	Local cell_h:Float = _Height/_CellsY

	For Local x:Int = 1 To _CellsX-1
		'Vertikale
		DrawLine(_X+x*cell_w,_Y,_X+x*cell_w,_Y+_CellsY*cell_h)	
	Next 
	
	For Local y:Int = 1 To _CellsY-1
		'Horizontale
		DrawLine(_X,_Y+y*cell_h,_X+_CellsX*cell_w,_Y+y*cell_h)
	Next 
	
	'### Reset The MAtrix
	If _Angle <> 0.0
		ResetMatrix()
	Endif
End Function


#Rem monkeydoc
	### READY TO USE ###~n
	This Function Draws a "Star-Bar" @ _X,_Y with the Dimensions _Witdth and _Height and the number of _MaxStars.~n
	_FullStars is the number of Colored Stars from Left
	You must call this within the OnRender() Method
#End
Function Drw_Stars(_X:Float,_Y:Float,_Width:Float,_Height:Float,_MaxStars:Int = 5,_FullStars:Int = 3)
	Local starWidth:Float = ll_Width(_Width,_MaxStars,5)
	
	For Local i:Int = 0 Until _MaxStars
		If i < _FullStars
			SetColor 255,0,0
		Else
			SetColor 75,75,75
		Endif 
		
		DrawImage MANIAC_IMG_STAR, _X + 5 + i*(starWidth+5), _Y+5, 0 , starWidth/MANIAC_IMG_STAR.Width(),_Height/MANIAC_IMG_STAR.Height()
	Next 
End Function 


#Rem monkeydoc
	### READY TO USE ###~n
	This Function Draws a Loading-Bar at the Position _X,_Y with the Dimensions _Witdth and _Height 
	You must call this within the OnRender() Method
	
	_Prozent must be between 0.0 and 1.0
#End
Function Drw_LoadingBar(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Caption:String,_Prozent:Float)
	If _Prozent >= 0.0 And _Prozent <= 1.0
		SetColor 75,75,75
		DrawRect(_X,_Y,_Width*_Prozent,_Height)
	
		SetColor 255,255,255
		Drw_Rect(_X,_Y,_Width,_Height,2)
	
		SetColor 255,0,0
		Local l:Int = MANIAC_FONT.getW(( Int(_Prozent*100))+ " %")
		MANIAC_FONT.Wrap((Int(_Prozent*100))+ " %",_X+_Width*0.5-l/2+1,_Y,_Width,_Height,15)
	Endif 
End Function 


#Rem monkeydoc
	### READY TO USE ###~n
	This Function Draws a Loading-Bar at the Position _X,_Y with the Dimensions _Witdth and _Height 
	You must call this within the OnRender() Method
	This Function calculates the percentage by its own, by giving
#End
Function Drw_LoadingBar(_X:Float,_Y:Float,_Width:Float,_Height:Float,_Caption:String,_CurrValue:Float,_MaxValue:Float)
	Local pr:Float = _CurrValue/_MaxValue

	SetColor 75,75,75
	DrawRect(_X,_Y,_Width*pr,_Height)
	
	SetColor 255,255,255
	Drw_Rect(_X,_Y,_Width,_Height,2)
	
	SetColor 255,0,0
	Local l:Int = MANIAC_FONT.getW(( Int(pr*100))+ " %")
	MANIAC_FONT.Wrap((Int(pr*100))+ " %",_X+_Width*0.5-l/2+1,_Y,_Width,_Height,15)
End Function


#Rem monkeydoc
	This Functions Draws an LoadingBar @ position ix,iy with w,h in Pixels
	istartTime is the Beginning Time, length is the max Time (both in ms)
#End
Function Drw_TimingBar(ix:Int,iy:Int,w:Int,h:Int,istartTime:Int,ilengthTime:Int,iStyle:Int = 0)

	Duke_Drw_Rect(ix,iy,w,h,2)
	Local lw:Int = ( ( Millisecs()-istartTime ) * w ) / ilengthTime
	If iStyle = 0
		DrawRect(ix,iy,w-lw,h)
	Elseif iStyle = 1
		DrawRect(ix,iy,w-lw,h)
	Endif 
	
End Function

#Rem monkeydoc
	### READY TO USE ###~n
	Draw 2d Lightning.
	Pass the starting and ending points.  Depth parameters refers to recursion.  Don't want to blow the stack!
	
	It uses CPU HEAVILY!!! best for short use for some effects. or lower the recursion.
	You must call this within the OnRender() Method
	Example:
	<pre>
		'Within the On Render you jast call the Lightning
		Method OnRender:Int()		
			Cls		
			Drw_Lightning(0,0,DW*0.5,DH*0.5)
			Return 0
		End
	</pre>
	
	Credits:
	this Code is from http://www.blitzbasic.com/codearcs/codearcs.php?code=3119 
	Matt Lloyd Lightning Implementation.
	and is translated into monkey by Stephan D
	Free To use as you wish. Play around with the parameters.
#End
Function Drw_Lightning(sx#,sy#,fx#,fy#,depth=4)
	
	'Local dx#,dy#,dist#,ox#,oy#,x#,y#,udx#,udy#
	Local i
	
	'play around with these numbers to see the effects
	Local shakiness#=-2.5 ;
	Local branchchance=6;
	Local wr1 = 16
	Local wr2 = 16
	Local hr1 = 4
	Local hr2 = 24


	If(depth<=0) Then Return ';;as said - don't want to go too deep in the stack...

	Local dx#=fx-sx
	Local dy#=fy-sy
	Local dist#=Sqrt(dx*dx+dy*dy)
	
	If(dist=0) Then Return ' ;no need To do any lightning If our start And ending points are on top of each other...And also avoid nasty division by zeroes...

	Local udx#=dx/dist'	;unit vectors in direction of lightning...
	Local udy#=dy/dist


	Local x#=sx 
	Local y#=sy
	Local ox#=x
	Local oy#=y

	For i=1 To dist 
		If MANIAC_DEBUG = True
			Maniac_Debug.addTotDraws(5)
		endif
		x=x+udx+Rnd(-shakiness,shakiness)
		y=y+udy+Rnd(-shakiness,shakiness)
		
		ll_ColorCentre()
		DrawLine x,y,ox,oy
		
		ll_ColorInnerEdge()
		DrawLine x-udy,y+udx, ox-udy,oy+udx
		DrawLine x+udy,y-udx,ox+udy,oy-udx
		
		ll_ColorOuterEdge()
		DrawLine x-udy*2.0,y+udx*2.0, ox-udy*2.0,oy+udx*2.0
		DrawLine x+udy*2.0,y-udx*2.0,ox+udy*2.0,oy-udx*2.0
		
		ox=x
		oy=y
		
		If(Rnd(1,100)<branchchance) Then 
			If MANIAC_DEBUG = True
				Maniac_Debug.addTotDraws()
			endif
			Drw_Lightning(ox,oy,ox+Rnd(-wr1,wr2),oy+Rnd(-hr1,hr2),depth-1)
		EndIf 
	
	Next 
End Function


#Rem monkeydoc
	### READY TO USE ###~n
	Draws a wrapped Text (ManiacFontText) to the _X,_Y,_Width,_Height Container with the _AlignX & _AlignY Parameter.

	This Function returns the CursorPosition in Pxl for the X-Koordinate
	You must call this within the OnRender() Method
	Example:
	<pre>
		'Within the On Render you jast call the Lightning
		Method OnRender:Int()		
			Cls		
			Drw_ManiacText("Hallo",50,200,300,50,ALIGNMENT_MIDDLE)
			Return 0
		End
	</pre>
#End
Function Drw_ManiacText:Float(_Caption:String,_X:Float,_Y:Float,_Width:Float,_Height:Float,_AlignX:Int = ALIGNMENT_MIDDLE,_AlignY:Int = ALIGNMENT_MIDDLEY,_Scale:Float = 1.0,_Angle:Float=0.0)
	
	'### Rotate The Matrix at the MidX/MidY Position around Angle
	If _Angle <> 0.0
		RotateAt(_X+_Width/2,_Y+_Height/2, _Angle)
	Endif
	
	Local lW:Float
	Local lH:Float = 0
	If MANIAC_DEBUG = True
		Maniac_Debug.addTotDraws(1)
	endif
	Select _AlignX
		Case ALIGNMENT_LEFT
			lW = 0 + 5
			
		Case ALIGNMENT_MIDDLE
			Local l:Int = (MANIAC_FONT.getW(_Caption)*_Scale)
			lW = _Width/2-l/2
			
			
		Case ALIGNMENT_RIGHT
			Local l:Int = (MANIAC_FONT.getW(_Caption)*_Scale)
			lW = _Width-l-5	
		Default 
			lW = 0 +5
	End Select
	
	
	'### ToDo Include a Y Alignment System ...
	Select _AlignY
		Case ALIGNMENT_TOP
			lH = 0
		Case ALIGNMENT_MIDDLEY
			lH = _Height/2- (MANIAC_FONT.getH()*_Scale)/2
		Case ALIGNMENT_BOTTOM
			lH = _Height-MANIAC_FONT.getH()
		
	End Select 
	ScaleAt(_X+lW, _Y+lH, _Scale, _Scale)
	MANIAC_FONT.Wrap(_Caption,_X+lW,_Y+lH,_Width,_Height,_Caption.Length())
	
	'### Reset The MAtrix
	'If _Angle <> 0.0
		ResetMatrix()
	'Endif
	Local tW:Float = MANIAC_FONT.getW(_Caption)
	Return (_X+lW+tW)
End Function 


Const COLOR_BLACK:Int 		= 	0
Const COLOR_GRAY:Int		=	4
Const COLOR_WHITE:Int		= 	9
Const COLOR_RED:Int			=	10
Const COLOR_GREEN:Int		=	20
Const COLOR_DARKGREEN:Int 	= 	27
Const COLOR_BLUE:Int		= 	30
Const COLOR_YELLOW:Int 		= 	40
Const COLOR_YELLOWLIGHT:Int	= 	47
Const COLOR_YELLOWLIGHT2:Int	= 	48
Const COLOR_BEIGE:Int 		=   46
Const COLOR_ORANGE:Int 		= 	50
Const COLOR_MAGENTA:Int		= 	60
Const COLOR_BROWN:Int		= 	70
Const COLOR_PURPLE:Int		= 	80

Const COLOR_PLAYER1:Int =  801
Const COLOR_PLAYER2:Int =  802
Const COLOR_PLAYER3:Int	=  803
Const COLOR_PLAYER4:Int =  804

Const COLOR_SCHEME_LPASTEL_BLUE_VERYDARK:Int 		= 301
Const COLOR_SCHEME_LPASTEL_BLUE_DARK:Int			= 302
Const COLOR_SCHEME_LPASTEL_BLUE_BRIGHT:Int			= 303
Const COLOR_SCHEME_LPASTEL_BLUE_VERYBRIGHT:Int		= 304
Const COLOR_SCHEME_LPASTEL_BLUE_BACKGROUND:Int		= 305


#Rem monkeydoc
	### EXPERIMENTAL ### ~n
	This Function sets the Render-Color to a predefined color by The Maniac-Color-Consts.
	You can find the Colors in the Functions Section.~n
	Details: 
	COLOR_BLACK = 0, COLOR_GRAY = 4, COLOR_WHITE = 9
	COLOR_RED = 10 To 19 ; 10 is 255,0,0, the part of Red decreases by higher ID
	So, every COlOR has 10 brightnes grades.
	You can use it like
	
	Duke_Color2(COLOR_GREEN + brightness), whereas brightness can be an int Value between 0 and 9
	so, COLOR_GREEN + 8 is a very dark green
#End
Function Maniac_Color(_Color:Int)
	'Maniac_Debug.addCall()
	Select _Color
		Case 0	'Schwarz
			SetColor 0,0,0
		Case 1
			SetColor 50,50,50
		Case 2
			SetColor 75,75,75
		Case 3
			SetColor 100,100,100
		Case 4
			SetColor 125,125,125
		Case 5
			SetColor 150,150,150
		Case 6
			SetColor 175,175,175
		Case 7
			SetColor 200,200,200
		Case 8	
			SetColor 225,225,225
		Case 9	'Weiss
			SetColor 255,255,255
			
			'### ROT ### colors 10-19
		Case 10
			SetColor 255,0,0
		Case 11
			SetColor 230,0,0
		Case 12
			SetColor 210,0,0
		Case 13
			SetColor 190,0,0
		Case 14
			SetColor 170,0,0	
		Case 14
			SetColor 150,0,0
		Case 15
			SetColor 130,0,0
		Case 16
			SetColor 110,0,0
		Case 17
			SetColor 90,0,0
		Case 18
			SetColor 70,0,0
		Case 19
			SetColor 50,0,0
		
		
			'### GRUEN ### 20-29
		Case 20	
			SetColor 0,255,0
		Case 21	
			SetColor 0,230,0
		Case 22	
			SetColor 0,210,0
		Case 23	
			SetColor 0,190,0
		Case 24	
			SetColor 0,170,0
		Case 25	
			SetColor 0,150,0
		Case 26	
			SetColor 0,130,0
		Case 27 	
			SetColor 0,110,0
		Case 28	
			SetColor 0,90,0
		Case 29
			SetColor 0,70,0	
			
			
			
			'### BLAU ###
		Case 30
			SetColor 0,0,255
		Case 31
			SetColor 0,0,230
		Case 32
			SetColor 0,0,210
		Case 33
			SetColor 0,0,190
		Case 34
			SetColor 0,0,170
		Case 35
			SetColor 0,0,150
		Case 36
			SetColor 0,0,130
		Case 37
			SetColor 0,0,110
		Case 38
			SetColor 0,0,90
		Case 39
			SetColor 0,0,70
			
			
			'### GELB ###
		Case 40
			SetColor 255,255,0
		Case 41
			SetColor 255,255,120
		Case 42
			SetColor 255,255,50
		Case 43
			SetColor 215,215,0
		Case 44
			SetColor 205,205,0
		Case 45
			SetColor 139,139,0
		Case 46
			SetColor 245,245,220
		Case 47
			SetColor 255,255,224
		Case 48
			SetColor 255,236,139
			
		
		'###	ORANGE ###
		Case 50
			SetColor 255,165,0
		Case 51
			SetColor 255,140,0
		Case 52
			SetColor 255,127,0
		Case 53
			SetColor 238,118,0
		Case 54
			SetColor 205,133,0
		Case 55
			SetColor 205,102,0
		Case 56
			SetColor 180,132,11
			
			
		'### MAGENTA ###
		Case 60
			SetColor 255,0,255
		Case 61
			SetColor 238,0,238
		Case 62
			SetColor 205,0,205
		Case 63
			SetColor 139,0,139
			
		'### BROWN ###
		Case 70
			SetColor 210,180,140
		Case 71
			SetColor 222,184,135
		Case 72
			SetColor 205,133,63
		Case 73
			SetColor 165,42, 42
		Case 74
			SetColor 160,82,45
		Case 75
			SetColor 139,69,19
			
			
		'### PURPLE +####
		Case 80
			SetColor 75,0,130 
		Case 81
			SetColor 160,32,240
			
		Case COLOR_PLAYER1
			SetColor 50,50,230
			
		Case COLOR_PLAYER2
			SetColor 30,230,30
			
		Case COLOR_PLAYER3
			SetColor 255,30,30
			
		Case COLOR_PLAYER4
			SetColor 255,255,255
		
		'### COLORSCHEME SPECIFIC COLOURS ###
		'LPASTEL
		Case COLOR_SCHEME_LPASTEL_BLUE_VERYDARK
			SetColor 144,144,217
		Case COLOR_SCHEME_LPASTEL_BLUE_DARK
			SetColor 166,166,229
		Case COLOR_SCHEME_LPASTEL_BLUE_BACKGROUND
			SetColor 189,189,239
		Case COLOR_SCHEME_LPASTEL_BLUE_BRIGHT
			SetColor 210,210,246
		Case COLOR_SCHEME_LPASTEL_BLUE_VERYBRIGHT
			SetColor 230,230,252
	End Select 
End Function 

Const IMGEFFECT_MIRRORX:Int = 1
Const IMGEFFECT_MIRRORY:Int = 2

Const IMGEFFECT_ROTATE_SHEARX45:Int = 7

Const IMGANIMAGION_FADE_IN:Int = 3
Const IMGANIMATION_DROP_IN:Int = 4
Const IMGANIMATION_SPIRAL_IN:Int = 5
Const IMGANIMATION_WAVE_IN:Int = 6

Const IMGGLOW_STYLE_SIN:Int 	= 0

Const IMG_ALIGN_LEFT:Int		= 0
Const IMG_ALIGN_MIDDLE:Int		= 1
Const IMG_ALIGN_RIGHT:Int		= 2

Const IMG_ALIGN_ONTOP:Int		= 3
Const IMG_ALIGN_TOP:Int			= 4
Const IMG_ALIGN_BOTTOM:Int		= 5
Const IMG_ALIGN_UNDERBOTTOM:Int	= 6

#Rem monkeydoc
	This is kind of an extended mojo Image.~n
	It provides some additional features.
	
	-InstantEffects:
		- Glow
		- Shearing,rotation & stuff
	
	-Complex-Animations
	
	-MoveAnimation

	BUGLIST:
		The Caption is not rendered correctly with RenderMode - Done
#End
Class ManiacImage
	Field MidX:Float,MidY:Float,Width:Float,Height:Float 
	Field Caption:String 
	Field CaptionColor:Int		'Color of the Caption
	Field AlignX:Int
	Field AlignY:Int  
	
	Field img:Image 
	Field bFramed:Bool = False  
	Field bBlink = True 
	Field Color:Int = 9
	Field angle:Float =0.0
	Field mode:Int = 0
	
	'### Glow Effects ###
	Field bGlow:Bool  = False  
	Field GlowAlpha:Float 
	Field HertzAlpha:Float 		'
	Field AlphaFrom:Float		= 0.2
	Field AlphaTo:Float			= 0.95
	Field GlowStyle:Int		= 0	'0 - If Alpha reases max, it decreases from max ; 1 - if Alpha reaches max, it jumps to min
	Field bAlphaDirection:Bool = True		'if True, Alpha raises, if false, Alpha decreases
	Field HertzIncreaseeAlpha:Float	=0.4
	Field HertzDecreaseAlpha:Float	=1
	
	
	Field AddWidthByMO:Int 		= 0
	Field AddHeightByMO:Int		= 0
	Field Scale:Float = 1.0
	
	#Rem monkeydoc
		Creates a new ManiacImage.
		midX and midy are both the midhandled coordiantes of the image.
		String the is Sourcepath to the Image
		_Caption if wanted is will be shown withing the Image
	#End
	Method New(midx:Float,midy:Float,width:Float,height:Float,Path:String,_Caption:String="",_AlignX:Int = 0,_AlignY:Int = 3,_Hertz:Float = 1.0 )
		img = LoadImage(Path)
		MidX = midx
		MidY = midy
		Width = width
		Height = height
		Caption = _Caption 
		CaptionColor = COLOR_BLUE
		AlignX = _AlignX
		AlignY = _AlignY
		HertzAlpha = _Hertz
		mode = 0
	End Method 
	
	Method setCaption:Void(_Caption:String,_AlignX:Int,_AlignY:int)
		Caption = _Caption
	End Method 
	
	Method setMode(_mode:Int)
		mode = _mode
	End Method 
	
	Method getMode:Int()
		Return mode 
	End Method 
	
	Method setGlow(_isGlowing:Bool = True)
		bGlow = _isGlowing
	End Method 
	
	Method setCostomMode(shearx:Int,sheary:Int,anglespeed:Float=4.0,scale:Float = 1.0)
	
	End Method 

	Method setFrame(_isFramed:Bool = True,_FrameColor:Int = 0)
		bFramed = _isFramed
		FrameColor = _FrameColor
	End Method
	
	
	Method Draw()
	
		If bGlow = True 
			If bAlphaDirection = True
				GlowAlpha += EqToFPS(HertzIncreaseeAlpha)
				If GlowAlpha >= AlphaTo
					If GlowStyle = 0
						bAlphaDirection = False
					Elseif GlowStyle = 1
						bAlphaDirection = True 
						GlowAlpha = AlphaFrom
					Endif 
				Endif 
			Else
				GlowAlpha -= EqToFPS(HertzDecreaseAlpha)
				If GlowAlpha <= AlphaFrom
					If GlowStyle = 0
						bAlphaDirection = true
					Elseif GlowStyle = 1
						bAlphaDirection = false 
						GlowAlpha = AlphaTo
					Endif
				Endif 
			Endif
		Endif  
		
		
		'
		'DrawText "mode: " +mode, 300,200
		Select mode
            Case IMGEFFECT_MIRRORX
                MirrorXAt(MidX, MidY)
            Case IMGEFFECT_MIRRORY
                MirrorYAt(MidX, MidY)
                
                
                
            Case 3
                angle += EqToFPS(45)
                ScaleAt(MidX, MidY, 0.6, 0.6)
                ShearXAt(MidX, MidY, Cos(angle))
                ShearYAt(MidX,MidY,	angle)
                RotateAt(MidX, MidY, angle)
                
            Case 4
                ShearXAt(MidX, MidY, Sin(angle))
            Case 5
                ShearYAt(MidX, MidY, -angle)
            Case 6
                ShearXAt(MidX, MidY, 30)
                ShearYAt(MidX, MidY, 30)
                
            Case IMGEFFECT_ROTATE_SHEARX45
                'ScaleAt(MidX, MidY, 1, 0.3)
                ShearXAt(MidX, MidY, 45)
                RotateAt(MidX, MidY, angle)
            Case 8
            	angle += EqToFPS(180)
                ScaleAt(MidX, MidY, 1, 0.3)
                RotateAt(MidX, MidY, -angle)
                ShearXAt(MidX, MidY, 45)
                ShearYAt(MidX, MidY, 45)
                RotateAt(MidX, MidY, angle)
            Case 9
            	angle += EqToFPS(180)
                RotateAt(MidX, MidY, -angle)
                ShearXAt(MidX, MidY, 45)
                ShearYAt(MidX, MidY, -45)
                RotateAt(MidX, MidY, angle)
            Case 10
            	angle += EqToFPS(180)
                ScaleAt(MidX, MidY, 1, 0.1)
                ShearXAt(MidX, MidY, -45)
                RotateAt(MidX, MidY, angle)
            Case 11
            	angle += EqToFPS(180)
                ScaleAt(MidX, MidY, 1, 0.2)
                ShearXAt(MidX, MidY, -45)
                RotateAt(MidX, MidY, angle)
            Case 12
            	angle += EqToFPS(180)
                ScaleAt(MidX, MidY, 1, 0.4)
                ShearXAt(MidX, MidY, -45)
                RotateAt(MidX, MidY, angle)
            Case 13
            	angle += EqToFPS(180)
                ScaleAt(MidX, MidY, 1, 0.8)
                ShearXAt(MidX, MidY, -45)
                RotateAt(MidX, MidY, angle)
            Case 14
            	angle += EqToFPS(180)
                ScaleAt(MidX, MidY, 1, 1.6)
                ShearXAt(MidX, MidY, -45)
                RotateAt(MidX, MidY, angle)
            Case 15
            	angle += EqToFPS(180)
                ScaleAt(MidX, MidY, 1, 3.2)
                ShearXAt(MidX, MidY, -45)
                RotateAt(MidX, MidY, angle)
            Case 16
            	angle += EqToFPS(180)
                ScaleAt(MidX, MidY, 1, 6.4)
                ShearXAt(MidX, MidY, -45)
                RotateAt(MidX, MidY, angle)
            Case 17
            	angle += EqToFPS(180)
                ScaleAt(MidX, MidY, 3, 1)
                ShearYAt(MidX, MidY, -45)
                RotateAt(MidX, MidY, -angle)
            Case 18
            	angle += EqToFPS(180)
                If angle=160 Then angle = 0
                ShearXAt(MidX, MidY, angle-80)
            Case 19
            	angle += EqToFPS(180)
                If angle=160 Then angle = 0
                ShearYAt(MidX, MidY, angle-80)
            Case 20
            	angle += EqToFPS(180)
                If angle=160 Then angle = 0
                ShearXAt(MidX, MidY,-angle+80)
                ShearYAt(MidX, MidY, angle-80)
            Case 21
            	angle += EqToFPS(180)
                ScaleAt(MidX, MidY, 1, Sin(angle))
                ShearXAt(MidX, MidY, -45)
                RotateAt(MidX, MidY, angle)
            Case 22
            	angle += ATan(EqToFPS(180))
                ScaleAt(MidX, MidY, 1, Sin(angle))
                ShearXAt(MidX, MidY, -45)
                RotateAt(MidX, MidY, angle)
            
        End Select
        
        Maniac_Color(Color)
        '###### GLOW EFFECT STUFF #####
		If bGlow = true
			SetAlpha GlowAlpha
			DrawImage MANIAC_IMG_FRAME_BLUR, MidX,MidY,angle,Width*1.3/MANIAC_IMG_FRAME_BLUR.Width(),Height*1.3/MANIAC_IMG_FRAME_BLUR.Height()
		End If
		
		 
        DrawImage img,MidX-Width*0.5,MidY-Height*0.5,0,Width/img.Width(),Height/img.Height()
        
        '###### BUTTON FRAME ########
		If bFramed = True	
			'Maniac_Color(FrameColor)
			DrawImage MANIAC_IMG_FRAME_RAW , MidX,MidY,angle,(Width+AddWidthByMO)/MANIAC_IMG_FRAME_RAW.Width(),(Height+AddHeightByMO)/MANIAC_IMG_FRAME_RAW.Height()
		Endif
		
        '##### DRAWING THE CAPTION TO THE BUTTON #####
		SetAlpha 1
		Maniac_Color(CaptionColor)
		Select AlignX
			Case IMG_ALIGN_LEFT
				MANIAC_FONT.Wrap(Caption,MidX-Width/2,MidY-Height/5,Width,Height,Caption.Length())
				ResetMatrix()
			Case IMG_ALIGN_MIDDLE
				Local l:Int = MANIAC_FONT.getW(Caption)
				MANIAC_FONT.Wrap(Caption,MidX-l/2+1,MidY-Height/5,Width,Height,Caption.Length())
				ResetMatrix()
			Case IMG_ALIGN_RIGHT
				Local l:Int = MANIAC_FONT.getW(Caption)
				MANIAC_FONT.Wrap(Caption,MidX+Width/2-l,MidY-Height/5,Width,Height,Caption.Length())
				ResetMatrix()	
		End Select 
		
        ResetMatrix()
        
        SetAlpha 1
	End Method 

End Class
