#Rem monkeydoc Module maniac
	Copyright (C) 2015  Stephan Duckerschein~n
	This Framework provides many additional Graphical Effects and primite Drawings, like unfilled rectangular , ellipsis etc. Diverse GUI Elements.~n
	It has it's own TileMap Engine included and even a Debug Tracking-System. ~n
	~n
	Installation:~n
	to use this Module, you have to Copy the "lib/" Folder data to Your App's Data.~n
	~n
	In the following is an Example, how to Include the maniac Framework to your Monkey Project.~n
Example:
<pre>
'This Example Shows how to integrate the Maniac-Framework to your App
	
'1. First You have to Import the Libs
import mojo
import maniac
		
'2. Main Function and App extending Class
Function Main:Int()
	New Example							
	Return 0
End
		
Class Example extends App
	Method OnCreate:Int()
		SetUpdateRate( 60 )
		initManiac()			' THIS INITS THE MANIAC FRAMEWORK! THIS NEED TO BE DONE BEFORE USING IT!!!!!
	end Method 
		
	Method OnUpdate:int()
		
	end method
		
	Method OnRender:int()
		Cls
	end Method  
End class 
</pre>
	
~n
Featurelist:
	GUI: - Textfield, Button, Dialog, GalleryViewer, Slider, DropDown, ListView, Checkbox ~n
	Graphics: - Outlined: Rect, Ellipsis ; LighningFX, Grid ~n
	TileMap: TileMapEngine featuring an Editor~n
	Font: Including a Font~n
	
#End

#rem
 <The Duke Game Framework. It provides useful little helperfunctions and class to develope 2D Games with Monkey X>
    Copyright (C) 2014-2015  Stephan Duckerschein

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 #end 

#rem
	The main Aim is to provide a wideranged kit for developing games with Monkey X.
	It tries to be as lightweight as possible.
	And it should be usable without changeging the mojo framework.

	Features:
		DebugSystem: It tracks all used Elements from Maniac within the DebugClass.
		So you can easily monitor your Objects.
#end

#rem
	TO DO FEATURES:
		- Include Async Loader for the Images
		- make the including Paths to Files configurable by including an config.ini file to define them ...
#end 

#rem
	Importing the Module-Parts of the maniac Framework.
#end 					

Import maniacLowLevel			'325		364
Import maniacFont				'249
'Import maniacDebug				'334
Import maniacGraphics			'686		763
Import maniacMisc				'248
Import maniacSimpleGUI			'1214		1515
Import maniacTween				'667
Import maniacMap				'168
Import maniacWIP
Import maniacSort
Import maniacSpline



#rem
	These are all global accessable Objects to your project.They will be initialised automatically within the initManiac() Method.
#end 
Global MANIAC_FONT:ManiacFont
Global MANIAC_IMG_LOGO:Image 
Global MANIAC_IMG_STAR:Image
Global MANIAC_IMG_STARBLUR:Image
Global MANIAC_IMG_BACKGROUND:Image 
Global MANIAC_IMG_FRAME_RAW:Image 		' ## DEPRECATED, this global will be removed in next Version
Global MANIAC_IMG_FRAME_RECT2:Image		'
Global MANIAC_IMG_FRAME_ROUND1:Image
Global MANIAC_IMG_FRAME_ROUND2:Image
Global MANIAC_IMG_FRAME_ROUND3:Image
Global MANIAC_IMG_FRAME_BLUR:Image
Global MANIAC_IMG_FRAME_SMOOTHRECT:Image
Global MANIAC_IMG_FRAME_SMOOTHRECTBLUR:Image 
Global MANIAC_IMG_BG_ROUND1:Image
Global MANIAC_IMG_BG_ROUND2:Image
Global MANIAC_IMG_BG_ROUND3:Image
Global MANIAC_IMG_BG_SMOOTHRECT:Image
Global MANIAC_IMG_SLIDERLINE:Image
Global MANIAC_IMG_SLIDERPICKER:Image 
Global MANIAC_IMG_EDITICON:Image
Global MANIAC_IMG_CHECK:Image 
Global MANIAC_IMG_DROPDOWN:Image
Global MANIAC_IMG_ARROWDOWN:Image

Global MANIAC_IMG_ICO_SOUND:Image
Global MANIAC_IMG_ICO_SOUND2:Image
Global MANIAC_CHARACTERSCOUNT:Int = 30

Global MANIAC_SND_SLIDE:Sound 
Global MANIAC_SND_SLIDE2:Sound
Global MANIAC_SND_SLIDE3:Sound
#rem
	Here are the Paths to the Included Images for this Framework
	At the moment theyre not used.
	Future Feature: Set them up via a config.ini file or something.
#end 
Global MANIAC_PATH_LOGO:String						= "lib/logo.png"
Global MANIAC_PATH_STAR:String						= "lib/star.png"
Global MANIAC_PATH_STARBLUR:String
Global MANIAC_PATH_BACKGROUND:String  				= "lib/Hintergrund.png"
Global MANIAC_PATH_FRAME_RECT:String				
Global MANIAC_PATH_FRSME_RECTBLUR:String 
Global MANIAC_PATH_FRAME_RECTROUND:String
Global MANIAC_PATH_FRAME_RECTROUNDBLUR:String 
Global MANIAC_PATH_FRAME_CIRCLE:String
Global MANIAC_PATH_FRAME_CIRCLEBLUR:String 
Global MANIAC_PATH_ICO_EDIT:String
Global MANIAC_PATH_ICO_CHECK:String
Global MANIAC_PATH_ICO_DROPDOWN_ARROW:String
Global MANIAC_PATH_ICO_ARROWDOWN:String 
Global MANIAC_PATH_ICO_SLIDERLINE:String
Global MANIAC_PATH_ICO_SLIDERPICKER:String 


Const FPSGRAPH_OFF:Int = 0
Const FPSGRAPH_FPS_ONLY:Int = 1
Const FPSGRAPH_GRAPH:Int = 2

Global MANIAC_FPSGRAPH:Maniac_Debug' = New fpsCounter
Global MODULE_INITED_CORRECT:Bool 		'if false, the whole Maniac-Module uses a fallback Drawings-Stuff


Global DW:Float,DH:Float,MX:Float,MY:Float
'Mouse Button States
Global gl_clicked:Bool
Global gl_mousereleased:Bool

Global MANIAC_DEBUG:Bool = False 
Global MANIAC_LOADASYNC:Bool = False 		'## RECOMMEND: SET ON FALSE, as there is no Async Loader included @ the moment !!!

Global maniac_lastTime:Int 
Global maniac_timeScale:Float 

Global GLOBAL_SOUNDON:Bool = false 			'if set to false, No Sound at all
	
#Rem monkeydoc
	This Function Inits this Module.
	It Loads all necessary Images and Sounds and stuff from the lib/ folder.
	if No Images were found, it falls back to a "at least running without any Image" mode. so it just shows up, that there are Graphics missing
#End
Function initManiac(_Debug:Bool = False)
	MANIAC_DEBUG = _Debug
	DW = DeviceWidth()
	DH = DeviceHeight()
	MODULE_INITED_CORRECT = True 
	
	If MANIAC_LOADASYNC = False 
		MANIAC_FONT = New ManiacFont(22,27,["lib/font2.png"],[[32,5,27,0,0,0,0,0,0,19],[33,5,27,0,393,46,7,18,-1,4],[34,9,27,0,122,99,10,10,-1,3],[35,15,27,0,51,66,17,17,-1,5],[36,16,27,0,478,0,18,22,-1,2],[37,20,27,0,332,25,21,21,-1,2],[38,16,27,0,34,66,17,17,-1,5],[39,5,27,0,116,99,6,10,-1,3],[40,9,27,0,89,0,11,24,-1,2],[41,9,27,0,78,0,11,24,-1,2],[42,14,27,0,378,46,15,18,-1,4],[43,12,27,0,386,83,14,14,-1,6],[44,6,27,0,109,99,7,10,-1,14],[45,10,27,0,174,99,12,7,-1,10],[46,5,27,0,219,99,6,6,-1,15],[47,12,27,0,366,25,13,21,-1,2],[48,18,27,0,24,83,19,16,-1,5],[49,12,27,0,60,83,14,16,-1,5],[50,14,27,0,171,83,15,15,-1,6],[51,16,27,0,154,83,17,15,-1,6],[52,15,27,0,154,66,17,17,-1,5],[53,15,27,0,138,66,16,17,-1,5],[54,16,27,0,121,66,17,17,-1,5],[55,13,27,0,106,66,15,17,-1,5],[56,15,27,0,89,66,17,17,-1,5],[57,15,27,0,43,83,17,16,-1,6],[58,5,27,0,424,83,6,14,-1,7],[59,6,27,0,68,66,7,17,-1,7],[60,10,27,0,412,83,12,14,-1,7],[61,14,27,0,79,99,16,11,-1,7],[62,10,27,0,400,83,12,14,-1,7],[63,13,27,0,75,66,14,17,-1,5],[64,21,27,0,14,46,22,20,-1,6],[65,17,27,0,461,66,18,17,-1,5],[66,14,27,0,446,66,15,17,-1,5],[67,15,27,0,430,66,16,17,-1,5],[68,15,27,0,414,66,16,17,-1,5],[69,14,27,0,399,66,15,17,-1,5],[70,13,27,0,385,66,14,17,-1,5],[71,15,27,0,369,66,16,17,-1,5],[72,14,27,0,353,66,16,17,-1,5],[73,11,27,0,142,83,12,16,-1,6],[74,15,27,0,126,83,16,16,-1,5],[75,14,27,0,337,66,16,17,-1,5],[76,14,27,0,322,66,15,17,-1,5],[77,17,27,0,304,66,18,17,-1,5],[78,15,27,0,287,66,17,17,-1,5],[79,18,27,0,107,83,19,16,-1,5],[80,15,27,0,416,46,16,18,-1,4],[81,18,27,0,268,66,19,17,-1,5],[82,15,27,0,400,46,16,18,-1,4],[83,16,27,0,250,66,18,17,-1,5],[84,15,27,0,319,83,16,15,-1,6],[85,15,27,0,90,83,17,16,-1,5],[86,16,27,0,233,66,17,17,-1,5],[87,16,27,0,215,66,18,17,-1,5],[88,15,27,0,199,66,16,17,-1,5],[89,14,27,0,184,66,15,17,-1,5],[90,15,27,0,74,83,16,16,-1,5],[91,9,27,0,67,0,11,24,-1,2],[92,12,27,0,353,25,13,21,-1,2],[93,9,27,0,56,0,11,24,-1,2],[94,12,27,0,26,99,13,12,-1,2],[95,15,27,0,203,99,16,6,-1,20],[96,7,27,0,141,99,8,9,-1,3],[97,14,27,0,304,83,15,15,-1,7],[98,12,27,0,287,46,13,19,-1,3],[99,12,27,0,472,83,13,14,-1,7],[100,12,27,0,70,46,14,20,-1,2],[101,13,27,0,290,83,14,15,-1,7],[102,12,27,0,274,46,13,19,-1,3],[103,13,27,0,260,46,14,19,-1,7],[104,13,27,0,246,46,14,19,-1,3],[105,5,27,0,239,46,7,19,-1,3],[106,5,27,0,315,0,7,23,-1,3],[107,12,27,0,56,46,14,20,-1,2],[108,5,27,0,50,46,6,20,-1,2],[109,16,27,0,272,83,18,15,-1,7],[110,13,27,0,258,83,14,15,-1,7],[111,12,27,0,458,83,14,14,-1,7],[112,12,27,0,36,46,14,20,-1,7],[113,13,27,0,225,46,14,19,-1,7],[114,10,27,0,246,83,12,15,-1,7],[115,13,27,0,232,83,14,15,-1,7],[116,12,27,0,171,66,13,17,-1,4],[117,12,27,0,218,83,14,15,-1,7],[118,13,27,0,443,83,15,14,-1,7],[119,16,27,0,200,83,18,15,-1,7],[120,13,27,0,186,83,14,15,-1,7],[121,13,27,0,211,46,14,19,-1,7],[122,12,27,0,430,83,13,14,-1,8],[123,12,27,0,28,0,14,25,-1,2],[124,5,27,0,309,0,6,23,-1,3],[125,12,27,0,14,0,14,25,-1,2],[126,15,27,0,157,99,17,8,-1,10],[127,13,27,0,0,46,14,20,-1,3],[161,5,27,0,371,46,7,18,-1,9],[162,12,27,0,465,0,13,22,-1,3],[163,14,27,0,18,66,16,17,-1,5],[164,16,27,0,0,66,18,17,-1,4],[165,14,27,0,481,46,15,17,-1,5],[166,5,27,0,303,0,6,23,-1,3],[167,13,27,0,317,25,15,21,-1,5],[168,9,27,0,192,99,11,6,-1,5],[169,21,27,0,189,46,22,19,-1,5],[170,13,27,0,65,99,14,11,-1,5],[171,17,27,0,368,83,18,14,-1,7],[172,12,27,0,95,99,14,10,-1,10],[174,21,27,0,167,46,22,19,-1,5],[176,12,27,0,52,99,13,11,-1,4],[177,13,27,0,357,46,14,18,-1,4],[178,12,27,0,0,99,13,13,-1,4],[179,12,27,0,13,99,13,12,-1,5],[180,8,27,0,132,99,9,9,-1,3],[181,14,27,0,152,46,15,19,-1,7],[182,18,27,0,297,25,20,21,-1,4],[183,5,27,0,186,99,6,6,-1,10],[184,7,27,0,149,99,8,8,-1,17],[185,7,27,0,498,83,8,13,-1,5],[186,11,27,0,39,99,13,11,-1,5],[187,17,27,0,350,83,18,14,-1,7],[188,17,27,0,278,25,19,21,-1,2],[189,18,27,0,259,25,19,21,-1,2],[190,18,27,0,239,25,20,21,-1,2],[191,13,27,0,467,46,14,17,-1,10],[192,17,27,0,285,0,18,23,-1,-1],[193,17,27,0,267,0,18,23,-1,-1],[194,17,27,0,249,0,18,23,-1,-1],[195,17,27,0,447,0,18,22,-1,0],[196,17,27,0,221,25,18,21,-1,1],[197,17,27,0,231,0,18,23,-1,-1],[198,22,27,0,0,83,24,16,-1,6],[199,15,27,0,486,25,16,20,-1,5],[200,14,27,0,216,0,15,23,-1,-1],[201,14,27,0,201,0,15,23,-1,-1],[202,14,27,0,186,0,15,23,-1,-1],[203,14,27,0,206,25,15,21,-1,1],[204,11,27,0,174,0,12,23,-1,-1],[205,11,27,0,162,0,12,23,-1,-1],[206,12,27,0,148,0,14,23,-1,-1],[207,11,27,0,194,25,12,21,-1,1],[208,17,27,0,448,46,19,17,-1,5],[209,15,27,0,430,0,17,22,-1,0],[210,18,27,0,411,0,19,22,-1,-1],[211,18,27,0,392,0,19,22,-1,-1],[212,18,27,0,373,0,19,22,-1,-1],[213,18,27,0,175,25,19,21,-1,0],[214,18,27,0,467,25,19,20,-1,1],[215,12,27,0,485,83,13,13,-1,7],[216,18,27,0,129,0,19,23,-1,2],[217,15,27,0,356,0,17,22,-1,-1],[218,15,27,0,339,0,17,22,-1,-1],[219,15,27,0,322,0,17,22,-1,-1],[220,15,27,0,450,25,17,20,-1,1],[221,14,27,0,114,0,15,23,-1,-1],[222,14,27,0,432,46,16,17,-1,5],[223,14,27,0,342,46,15,18,-1,4],[224,14,27,0,160,25,15,21,-1,1],[225,14,27,0,145,25,15,21,-1,1],[226,14,27,0,130,25,15,21,-1,1],[227,14,27,0,435,25,15,20,-1,2],[228,14,27,0,137,46,15,19,-1,3],[229,14,27,0,115,25,15,21,-1,1],[230,21,27,0,479,66,23,16,-1,6],[231,12,27,0,329,46,13,18,-1,7],[232,13,27,0,101,25,14,21,-1,1],[233,13,27,0,87,25,14,21,-1,1],[234,13,27,0,72,25,15,21,-1,1],[235,13,27,0,123,46,14,19,-1,3],[236,7,27,0,64,25,8,21,-1,1],[237,8,27,0,55,25,9,21,-1,1],[238,11,27,0,42,25,13,21,-1,1],[239,9,27,0,112,46,11,19,-1,3],[240,14,27,0,314,46,15,18,-1,3],[241,13,27,0,421,25,14,20,-1,2],[242,12,27,0,407,25,14,20,-1,1],[243,12,27,0,393,25,14,20,-1,1],[244,12,27,0,379,25,14,20,-1,1],[245,12,27,0,98,46,14,19,-1,2],[246,12,27,0,300,46,14,18,-1,3],[247,14,27,0,335,83,15,14,-1,5],[248,12,27,0,28,25,14,21,-1,4],[249,12,27,0,14,25,14,21,-1,1],[250,12,27,0,0,25,14,21,-1,1],[251,12,27,0,496,0,14,21,-1,1],[252,12,27,0,84,46,14,19,-1,3],[253,13,27,0,0,0,14,25,-1,1],[254,12,27,0,42,0,14,24,-1,3],[255,13,27,0,100,0,14,23,-1,3]])
		MANIAC_IMG_BACKGROUND = LoadImage("lib/Hintergrund.png")
		MANIAC_IMG_STAR = LoadImage("lib/star.png")
		MANIAC_IMG_LOGO = LoadImage("lib/logo.png")
		MANIAC_IMG_FRAME_RAW = LoadImage("lib/Button/Frame_Round3.png",1,Image.MidHandle)
		MANIAC_IMG_FRAME_RECT2	= LoadImage("lib/Button/Frame_Rect2.png",1,Image.MidHandle)
		MANIAC_IMG_FRAME_ROUND1	= LoadImage("lib/Button/Frame_Round1.png",1,Image.MidHandle)
		MANIAC_IMG_FRAME_ROUND2	= LoadImage("lib/Button/Frame_Round2.png",1,Image.MidHandle)
		MANIAC_IMG_FRAME_ROUND3 = LoadImage("lib/Button/Frame_Round3.png",1,Image.MidHandle)
		MANIAC_IMG_BG_SMOOTHRECT = LoadImage("lib/Button/BG_Round3.png",1,Image.MidHandle)		'## DEPRECATED !!! Will be removed within next patch
		MANIAC_IMG_BG_ROUND1 = LoadImage("lib/Button/BG_Round1.png",1,Image.MidHandle)
		MANIAC_IMG_BG_ROUND2 = LoadImage("lib/Button/BG_Round2.png",1,Image.MidHandle)
		MANIAC_IMG_BG_ROUND3 = LoadImage("lib/Button/BG_Round3.png",1,Image.MidHandle)
		
		MANIAC_IMG_FRAME_BLUR = LoadImage("lib/Frame_blur.png",1,Image.MidHandle)
		MANIAC_IMG_EDITICON = LoadImage("lib/ico_edit.png")
		MANIAC_IMG_SLIDERLINE = LoadImage("lib/Slider_Line.png")
		MANIAC_IMG_SLIDERPICKER = LoadImage("lib/Slider_Picker.png",1,Image.MidHandle)
		MANIAC_IMG_CHECK = LoadImage("lib/ico_check.png")
		MANIAC_IMG_DROPDOWN = LoadImage("lib/ico_dropdown.png")
		MANIAC_IMG_ARROWDOWN = LoadImage("lib/ico_arrowdown.png")
		
		MANIAC_IMG_ICO_SOUND = LoadImage("lib/Icons/Icon_Std_Sound.png")
		
		MANIAC_SND_SLIDE = LoadSound("lib/SFX/slide1.wav")
		MANIAC_SND_SLIDE2 = LoadSound("lib/SFX/slide2.wav")
		MANIAC_SND_SLIDE3 = LoadSound("lib/SFX/slide3.wav")
		
	Else
		#rem
			TO DO:
			Try to find a way to include some Async Loading stuff with the lowest impact of how to use this Framework.
			## RECOMMEND : SET TO FALSE ##
		#end 
	Endif 
	
	
	If MANIAC_DEBUG = True 
		MANIAC_FPSGRAPH = New Maniac_Debug(DW*0.2,DH*0.8,DW*0.65,DH*0.19)
	Endif 
	If MANIAC_FONT = Null
		Print "Found no Font Data"
		MODULE_INITED_CORRECT = False 
	Endif 
	If MANIAC_IMG_FRAME_RAW = Null
		Print "Found no Raw Frame Data"
		MODULE_INITED_CORRECT = False
	Endif
	If MANIAC_IMG_FRAME_BLUR = Null
		Print "Found no blurred Frame Data"
		MODULE_INITED_CORRECT = False
	Endif
	If MANIAC_IMG_EDITICON = Null
		Print "Found no Edit_Icon"
		MODULE_INITED_CORRECT = False
	Endif
	If MANIAC_FPSGRAPH = Null
		Print "Couldnt create an FPS Graph"
		MODULE_INITED_CORRECT = False
	Endif
	
End Function 

#Rem monkeydoc
	This Function should called on every Update() MEthod within your App.
	It keeps some important states of the ManiacModule active
#End
Function maniacUpdate()
	UpdateAsyncEvents()
	If MANIAC_DEBUG = True
		Maniac_Debug.addCall()
	Endif
	
	MX = MouseX()
	MY = MouseY()
	
	Maniac_CheckMouseState()
	
	ll_UpdateSpeeds()
End Function 


Function maniacSetDebug(b:Bool = True)
	MANIAC_DEBUG = b
End Function 

Function maniacSetAsyncLoad(b:Bool = True)
	MANIAC_LOADASYNC = b
End Function 
