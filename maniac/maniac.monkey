#Rem monkeydoc Module maniac
	Copyright (C) 2015  Stephan Duckerschein~n
	Version: 0.9.6 Alpha~n
	The Aim of Maniac~n
	The aim of this Project is to offer a OpenSource, Easy to install/use and widerange toolsets,functions and gui-objects for your Games~n
	
	This Framework provides many additional Graphical Effects and primite Drawings, like unfilled rectangular , ellipsis etc. Diverse GUI Elements.~n
	It has it's own TileMap Engine included and even a Debug Tracking-System. ~n
	~n
	Installation:~n
	create a folder named maniac within your modules_ext folder, copy all maniac src into
	to use this Module, you have to Copy the "lib/" Folder data to Your App's Data.~n
	~n
	In the following is an Example, how to Include the maniac Framework to your Monkey Project.~n
	#ToDo:
		GUI Elements: cGuiBase -> Button,CheckBox,RadioGroup,Dialog,Title,Logo,StateSwitcher,TabLine,
		Language: 	English,German,French: for Predefined ManiacGUIElements,Quotes
		Security: 	AES256 De-/Encryption
		Graphics: 	extend mojo with: Drw_Rect,Ellipsis,Blitz,
		
		Useful/Handy functions: Deltatiming,Multidimensional-ArrayCreator,SwipeDetect
		
		GameComponents: TileMap
		
		
	#ChangeLog:
	Ver 1.0 Contains:
	Examples:
	Tutorials:
	
	- IntroMovie
	- a tweening Module
	- MiscFunctions Module: ,2D & 3D ArrayCreators, MouseOver Box/Circle/Triangle functions, Deltatiming helper, get Date & Time with (American,German) Style + a good ordering as a String
	- GraphicsModule: Ths Module has 'direct-Draw' Helpers. They just have to be called within OnRender() Method
		- Drw_Grid, Drw_Circle, Drw_Ellipsis, Drw_Stars, LoadingBar, TimeBar, Drw_ManiacText (this is a Font-Helper function, for better positioning within your Project)
		- Drw_Rect (actually its just the frame around an Rect, as i missed this in mojo itself)
	- FontModule: Maniac comes along with its own Font
	
	Current Plannings on Ver 1.1:
	- Include at least 1 more Scheme
	- Include English Quotes, make Language choosable
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
		maniacInit()			' THIS INITS THE MANIAC FRAMEWORK! THIS NEED TO BE DONE BEFORE USING IT!!!!!
	end Method 
		
	Method OnUpdate:int()
		maniacUpdate()			'THIS UPDATES ALL NEEDED DATA FOR THE MANIAC-GLOBALS
	end method
		
	Method OnRender:int()
		Cls
		
		maniacDraw()
	end Method  
End class 
</pre>
	
~n

	
#End

#rem
 <The Maniac Framework. It provides useful little helperfunctions and class to develope 2D Games with Monkey X>
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
Import mojo
#If TARGET <> "html5"
Import brl
#Endif 
'537


			'		5233
			'		3127
			'		 790
			'		 668
			'###########
'	SUMMARY:		9818

#rem
	###############################################################################################################
	IMPORTING maniac Libs
#end
Import maniacLowLevel			' 525		using: ver. 1.0		READY
Import maniacTween				' 713		using: ver. 1.0		READY
Import maniacMisc				' 860		using: ver. 1.0		READY
Import maniacGraphics			' 925		using: ver. 1.0		READY
Import maniacFont				' 253		using: ver. 1.1		READY
Import maniacDebug				' 334							TO DO
Import maniacSecure				'1152							READY
Import maniacCalendar			' 471							TO DO
'Import maniacComplexMap
					'SUMMARY :	'5233
					
#rem
	#### GUI-Elements ####			'3127
#end
Import gui.maniacGuiBase			'849		new since Version 1.0
Import gui.maniacGuiLogo			'113		new since Version 1.0 rv1
Import gui.maniacGuiTitle			'170		new since Version 1.0 rv1
Import gui.maniacButton				'162
Import gui.maniacTabLine			'441
Import gui.maniacRadioGroup			'331
Import gui.maniacDialogue			'89
Import gui.maniacDropDown			'147
Import gui.maniacTextfield			'324
Import gui.maniacGuiColorSelector	'138
Import gui.maniacCalendar			
'Import gui.maniacGallery
'Import gui.maniacCheckbox
'Import maniacNumberSelector		'215
Import gui.maniacStateSwitcher		'109
'Import maniacTextfield
Import gui.maniacSlider				'254
Import gui.maniacBackground			

#rem
	#### HIGHLEVEL GAMING COMPONENTS ####### 790
#end 
Import maniacTileMap				'790
'Import maniacTileField				'135
'Import maniacLogo
'Import maniacLogoField

#rem
	Global Data
#end 
Global DW:Float,DH:Float		'Global DeviceWidth and DeviceHeight

Global gl_clicked:Bool			
Global gl_mousereleased:Bool	'Will be true, if user has released left mousebutton 

Global bClickedNext:Bool = False 

Global MANIAC_DEBUG:Bool = False 
Global MANIAC_LOADASYNC:Bool = False 		'## RECOMMEND: SET ON FALSE, as there is no Async Loader included @ the moment !!!

Global GLOBAL_SOUNDON:Bool = False 			'if set to false, No Sound at all; else it decides by local setting

Global GLOBAL_LANGUAGE:String 	= MANIAC_LANGUAGE_GERMAN			'selected Language for Standard UI-
Const MANIAC_LANGUAGE_GERMAN:String 	= "Deutsch"
Const MANIAC_LANGUAGE_ENGLISH:String 	= "English"
Const MANAIC_LANGUAGE_FRENCH:String 	= "Francaise"

Global ManiacQuotes:String[][]
Global ManiacAppStats:Int[]

Global ManiacCurrRuntime:Int
Global ManiacStartRuntime:Int

Global mLogo:ManiacGuiLogo
Global monkeyLogo:ManiacGuiLogo
Global mTitle:ManiacTitle
Global monkeyTitle:ManiacTitle2
Global mBackground:ManiacGuiBackground

#rem monkeydoc
	This Function returns the current Language.~n
	Return String  
#end
Function getManiacLanguage:String()
	Return GLOBAL_LANGUAGE
End Function 


#rem monkeydoc
	This Function sets the current Language.~n  
#end
Function setManiacLanguage:Void(_Language:String = MANIAC_LANGUAGE_GERMAN)
	GLOBAL_LANGUAGE = _Language
End Function 


#rem monkeydoc
	This Function sets the current global Caption Color.~n  
#end
Function setManiacButton_CaptionColor:Void(_Color:Int )
	BUTTON_STD_CAPTIONCOLOR = _Color
End Function 

'### StringPath to Std-Lib Images ###
Global IMG_LOGO:Int 					= 0 , PATH_IMG_LOGO:String 						= "lib/logo.png"
Global IMG_BACKGROUND:Int 				= 1 , PATH_IMG_BACKGROUND:String 				= "lib/Hintergrund.png"
Global IMG_STYLE_MODERN_BACKGROUND:Int 	= 2 , PATH_IMG_STYLE_MODERN_BACKGROUND:String 	= "lib/Button/ModernBackground.png"
Global IMG_STYLE_MODERN_FRAME:Int     	= 3	, PATH_IMG_STYLE_MODERN_FRAME:String 		= "lib/Button/ModernFrame.png"
Global IMG_STYLE_ROUND_BACKGROUND:Int 	= 4 , PATH_IMG_STYLE_ROUND_BACKGROUND:String 	= "lib/Button/RoundedBackground.png"
Global IMG_STYLE_ROUND_FRAME:Int		= 5 , PATH_IMG_STYLE_ROUND_FRAME:String			= "lib/Button/RoundedFrame.png"
Global IMG_STYLE_CIRCLE_BACKGROUND:Int 	= 6 , PATH_IMG_STYLE_CIRCLE_BACKGROUND:String 	= "lib/Button/CircleBackground.png"
Global IMG_STYLE_CIRCLE_FRAME:Int		= 7 , PATH_IMG_STYLE_CIRCLE_FRAME:String		= "lib/Button/CircleFrame.png"
Global IMG_STYLE_MODERN2_BACKGROUND:Int = 8 , PATH_IMG_STYLE_MODERN2_BACKGROUND:String 	= "lib/Button/Modern2Background.png"
Global IMG_STYLE_MODERN2_FRAME:Int     	= 9	, PATH_IMG_STYLE_MODERN2_FRAME:String 		= "lib/Button/Modern2Frame.png"

Global IMG_SLIDER_FLATLINE:Int			= 10 , PATH_IMG_STYLE_FLATLINE:String			= "lib/Slider/Slider_Line.png"
Global IMG_SLIDER_PICKER:Int			= 11 , PATH_IMG_STYLE_PICKER:String				= "lib/Slider/Slider_Picker.png"

Global IMG_ICON_CHECKEDARROW:Int 		= 12, PATH_IMG_CHECKEDARROW:String 				= "lib/Icons/ico_check.png"
Global IMG_ICON_ARROWDOWN:Int			= 13, PATH_IMG_ARROWDOWN:String					= "lib/Icons/ico_arrowdown.png"
Global IMG_ICON_ARROWUP:Int				= 14, PATH_IMG_ARROWUP:String					= "lib/Icons/ico_arrowup.png"
 
Global IMG_LOGO_PART_LEFT:Int 			= 15, PATH_IMG_LOGO_PART_LEFT:String			= "lib/DynamicLogos/ManiacLogo/logo_left.png"
Global IMG_LOGO_PART_RIGHT:Int			= 16, PATH_IMG_LOGO_PART_RIGHT:String			= "lib/DynamicLogos/ManiacLogo/logo_right.png"
Global IMG_LOGO_PART_DOWN:Int 			= 17, PATH_IMG_LOGO_PART_DOWN:String			= "lib/DynamicLogos/ManiacLogo/logo_down.png"
Global IMG_LOGO_PART_TOP:Int 			= 18, PATH_IMG_LOGO_PART_TOP:String				= "lib/DynamicLogos/ManiacLogo/logo_top.png"
Global IMG_LOGO_PART_INNERCIRCLE:Int 	= 19, PATH_IMG_LOGO_PART_INNERCIRCLE:String		= "lib/DynamicLogos/ManiacLogo/logo_innercircle.png"
Global IMG_LOGO_PART_OUTERCIRCLE:Int 	= 20, PATH_IMG_LOGO_PART_OUTERCIRCLE:String		= "lib/DynamicLogos/ManiacLogo/logo_outercircle.png"
Global IMG_LOGO_PART_CENTER:Int 		= 21, PATH_IMG_LOGO_PART_CENTER:String			= "lib/DynamicLogos/ManiacLogo/logo_center.png"

Global IMG_ICON_MOUSECURSOR:Int 		= 22, PATH_ICO_MOUSECURSOR:String 				= "lib/Icons/ico_mousecursor2.png"
Global IMG_ICON_ZOOMIN:Int 				= 23, PATH_ICO_ZOOMIN:String					= "lib/Icons/ico_zoomin.png"
Global IMG_ICON_ZOOMOUT:Int 			= 24, PATH_ICO_ZOOMOUT:String					= "lib/Icons/ico_zoomout.png"

'### Std-Lib Image/Sound Array ###
Global ManiacImg:Image[]			
Global ManiacSnd:Sound[]
Global MANIAC_FONT:ManiacFont

'### Standard Init-Logo Time Settings ###
Global mInit:Bool = True 
Global mInitTime:Int = 2500
Global mCurrInitTime:Int 

Const ALIGNMENT_LEFT:Int 		= 1
Const ALIGNMENT_MIDDLE:Int 		= 2
Const ALIGNMENT_RIGHT:Int 		= 3
Const ALIGNMENT_TOP:Int 		= 4
Const ALIGNMENT_MIDDLEY:int 	= 5
Const ALIGNMENT_BOTTOM:Int 		= 6




Const MANIAC_STYLE_STD:Int 		= 0
Const MANIAC_STYLE_STDGLOW:Int 	= 1
Const MANIAC_STYLE_MODERN:Int 	= 2
Const MANIAC_STYLE_ROUND:Int 	= 3
Const MANIAC_STYLE_CIRCLE:Int	= 4
Const MANIAC_STYLE_MODERN2:Int	= 5



Global BUTTON_STD_CAPTIONCOLOR:Int 	= COLOR_WHITE
Global BUTTON_STD_MAINCOLOR:Int
Global BUTTON_STD_FRAMECOLOR:Int 

Const BUTTON_STATE_MOUSEOVER:Int		= 90
Const BUTTON_STATE_MOUSECLICK:Int		= 91
Const BUTTON_STATE_MOUSECLICKDOWN:Int	= 92
Const BUTTON_STATE_MOUSERELEASED:Int 	= 93

Const TAB_DISPOSAL_MIDDLE:Int	= 0
Const TAB_DISPOSAL_ALL:Int		= 1
Const TAB_DISPOSAL_TOP:Int		= 2
Const TAB_DISPOSAL_BOTTOM:Int 	= 3
Const TAB_DISPOSAL_LEFT:Int		= 4
Const TAB_DISPOSAL_RIGHT:Int	= 5

Const TAB_ALIGN_TOP:Int			= 0
Const TAB_ALIGN_LEFT:Int		= 1
Const TAB_ALIGN_RIGHT:Int		= 2
Const TAB_ALIGN_BOTTOM:Int		= 3
Const TAB_ALIGN_INDIVIDUALHORIZONTAL:Int 	= 4
Const TAB_ALIGN_INDIVIDUALVERTICAL:Int 	= 5

Const TAB_MOUSEOVERSTYLE_RESIZE:Int			= 1
Const TAB_MOUSEOVERSTYLE_BRIGHTENING:Int	= 2
Const TAB_MOUSEOVERSTYLE_WOBBLE:Int			= 3
Global maniac_lastTime:Int 
Global maniac_timeScale:Float 
'COLOR_LPASTEL_BLUE_DARK
Const MANIAC_COLORSCHEME_LIGHTPASTEL:Int 	= 2 '"LightPastel"
Const MANIAC_COLORSCHEME_COLORFUL:Int 		= 3





Global MANIAC_COLOR_FOREGROUND:Int
Global MANIAC_COLOR_BACKGROUND:Int 

#rem monkeydoc
	This Function Initializes the maniac-Framework.~n
	_DEBUG << can be True or False ; 
#end
Function maniacInit:Void(_DEBUG:Bool = MANIAC_DEBUG)
	MANIAC_DEBUG = _DEBUG
	DW = DeviceWidth()
	DH = DeviceHeight()
	ManiacImg = New Image[30]		'Initialize an Array of 30 Images
	ManiacSnd = New Sound[5]		' -"- 5 Sounds
	
	
	
	'## Set The Global Maniac Language ##
	'GLOBAL_LANGUAGE = MANIAC_LANGUAGE_GERMAN
	If MANIAC_LOADASYNC = False 
		MANIAC_FONT = New ManiacFont(22,27,["lib/font2.png"],[[32,5,27,0,0,0,0,0,0,19],[33,5,27,0,393,46,7,18,-1,4],[34,9,27,0,122,99,10,10,-1,3],[35,15,27,0,51,66,17,17,-1,5],[36,16,27,0,478,0,18,22,-1,2],[37,20,27,0,332,25,21,21,-1,2],[38,16,27,0,34,66,17,17,-1,5],[39,5,27,0,116,99,6,10,-1,3],[40,9,27,0,89,0,11,24,-1,2],[41,9,27,0,78,0,11,24,-1,2],[42,14,27,0,378,46,15,18,-1,4],[43,12,27,0,386,83,14,14,-1,6],[44,6,27,0,109,99,7,10,-1,14],[45,10,27,0,174,99,12,7,-1,10],[46,5,27,0,219,99,6,6,-1,15],[47,12,27,0,366,25,13,21,-1,2],[48,18,27,0,24,83,19,16,-1,5],[49,12,27,0,60,83,14,16,-1,5],[50,14,27,0,171,83,15,15,-1,6],[51,16,27,0,154,83,17,15,-1,6],[52,15,27,0,154,66,17,17,-1,5],[53,15,27,0,138,66,16,17,-1,5],[54,16,27,0,121,66,17,17,-1,5],[55,13,27,0,106,66,15,17,-1,5],[56,15,27,0,89,66,17,17,-1,5],[57,15,27,0,43,83,17,16,-1,6],[58,5,27,0,424,83,6,14,-1,7],[59,6,27,0,68,66,7,17,-1,7],[60,10,27,0,412,83,12,14,-1,7],[61,14,27,0,79,99,16,11,-1,7],[62,10,27,0,400,83,12,14,-1,7],[63,13,27,0,75,66,14,17,-1,5],[64,21,27,0,14,46,22,20,-1,6],[65,17,27,0,461,66,18,17,-1,5],[66,14,27,0,446,66,15,17,-1,5],[67,15,27,0,430,66,16,17,-1,5],[68,15,27,0,414,66,16,17,-1,5],[69,14,27,0,399,66,15,17,-1,5],[70,13,27,0,385,66,14,17,-1,5],[71,15,27,0,369,66,16,17,-1,5],[72,14,27,0,353,66,16,17,-1,5],[73,11,27,0,142,83,12,16,-1,6],[74,15,27,0,126,83,16,16,-1,5],[75,14,27,0,337,66,16,17,-1,5],[76,14,27,0,322,66,15,17,-1,5],[77,17,27,0,304,66,18,17,-1,5],[78,15,27,0,287,66,17,17,-1,5],[79,18,27,0,107,83,19,16,-1,5],[80,15,27,0,416,46,16,18,-1,4],[81,18,27,0,268,66,19,17,-1,5],[82,15,27,0,400,46,16,18,-1,4],[83,16,27,0,250,66,18,17,-1,5],[84,15,27,0,319,83,16,15,-1,6],[85,15,27,0,90,83,17,16,-1,5],[86,16,27,0,233,66,17,17,-1,5],[87,16,27,0,215,66,18,17,-1,5],[88,15,27,0,199,66,16,17,-1,5],[89,14,27,0,184,66,15,17,-1,5],[90,15,27,0,74,83,16,16,-1,5],[91,9,27,0,67,0,11,24,-1,2],[92,12,27,0,353,25,13,21,-1,2],[93,9,27,0,56,0,11,24,-1,2],[94,12,27,0,26,99,13,12,-1,2],[95,15,27,0,203,99,16,6,-1,20],[96,7,27,0,141,99,8,9,-1,3],[97,14,27,0,304,83,15,15,-1,7],[98,12,27,0,287,46,13,19,-1,3],[99,12,27,0,472,83,13,14,-1,7],[100,12,27,0,70,46,14,20,-1,2],[101,13,27,0,290,83,14,15,-1,7],[102,12,27,0,274,46,13,19,-1,3],[103,13,27,0,260,46,14,19,-1,7],[104,13,27,0,246,46,14,19,-1,3],[105,5,27,0,239,46,7,19,-1,3],[106,5,27,0,315,0,7,23,-1,3],[107,12,27,0,56,46,14,20,-1,2],[108,5,27,0,50,46,6,20,-1,2],[109,16,27,0,272,83,18,15,-1,7],[110,13,27,0,258,83,14,15,-1,7],[111,12,27,0,458,83,14,14,-1,7],[112,12,27,0,36,46,14,20,-1,7],[113,13,27,0,225,46,14,19,-1,7],[114,10,27,0,246,83,12,15,-1,7],[115,13,27,0,232,83,14,15,-1,7],[116,12,27,0,171,66,13,17,-1,4],[117,12,27,0,218,83,14,15,-1,7],[118,13,27,0,443,83,15,14,-1,7],[119,16,27,0,200,83,18,15,-1,7],[120,13,27,0,186,83,14,15,-1,7],[121,13,27,0,211,46,14,19,-1,7],[122,12,27,0,430,83,13,14,-1,8],[123,12,27,0,28,0,14,25,-1,2],[124,5,27,0,309,0,6,23,-1,3],[125,12,27,0,14,0,14,25,-1,2],[126,15,27,0,157,99,17,8,-1,10],[127,13,27,0,0,46,14,20,-1,3],[161,5,27,0,371,46,7,18,-1,9],[162,12,27,0,465,0,13,22,-1,3],[163,14,27,0,18,66,16,17,-1,5],[164,16,27,0,0,66,18,17,-1,4],[165,14,27,0,481,46,15,17,-1,5],[166,5,27,0,303,0,6,23,-1,3],[167,13,27,0,317,25,15,21,-1,5],[168,9,27,0,192,99,11,6,-1,5],[169,21,27,0,189,46,22,19,-1,5],[170,13,27,0,65,99,14,11,-1,5],[171,17,27,0,368,83,18,14,-1,7],[172,12,27,0,95,99,14,10,-1,10],[174,21,27,0,167,46,22,19,-1,5],[176,12,27,0,52,99,13,11,-1,4],[177,13,27,0,357,46,14,18,-1,4],[178,12,27,0,0,99,13,13,-1,4],[179,12,27,0,13,99,13,12,-1,5],[180,8,27,0,132,99,9,9,-1,3],[181,14,27,0,152,46,15,19,-1,7],[182,18,27,0,297,25,20,21,-1,4],[183,5,27,0,186,99,6,6,-1,10],[184,7,27,0,149,99,8,8,-1,17],[185,7,27,0,498,83,8,13,-1,5],[186,11,27,0,39,99,13,11,-1,5],[187,17,27,0,350,83,18,14,-1,7],[188,17,27,0,278,25,19,21,-1,2],[189,18,27,0,259,25,19,21,-1,2],[190,18,27,0,239,25,20,21,-1,2],[191,13,27,0,467,46,14,17,-1,10],[192,17,27,0,285,0,18,23,-1,-1],[193,17,27,0,267,0,18,23,-1,-1],[194,17,27,0,249,0,18,23,-1,-1],[195,17,27,0,447,0,18,22,-1,0],[196,17,27,0,221,25,18,21,-1,1],[197,17,27,0,231,0,18,23,-1,-1],[198,22,27,0,0,83,24,16,-1,6],[199,15,27,0,486,25,16,20,-1,5],[200,14,27,0,216,0,15,23,-1,-1],[201,14,27,0,201,0,15,23,-1,-1],[202,14,27,0,186,0,15,23,-1,-1],[203,14,27,0,206,25,15,21,-1,1],[204,11,27,0,174,0,12,23,-1,-1],[205,11,27,0,162,0,12,23,-1,-1],[206,12,27,0,148,0,14,23,-1,-1],[207,11,27,0,194,25,12,21,-1,1],[208,17,27,0,448,46,19,17,-1,5],[209,15,27,0,430,0,17,22,-1,0],[210,18,27,0,411,0,19,22,-1,-1],[211,18,27,0,392,0,19,22,-1,-1],[212,18,27,0,373,0,19,22,-1,-1],[213,18,27,0,175,25,19,21,-1,0],[214,18,27,0,467,25,19,20,-1,1],[215,12,27,0,485,83,13,13,-1,7],[216,18,27,0,129,0,19,23,-1,2],[217,15,27,0,356,0,17,22,-1,-1],[218,15,27,0,339,0,17,22,-1,-1],[219,15,27,0,322,0,17,22,-1,-1],[220,15,27,0,450,25,17,20,-1,1],[221,14,27,0,114,0,15,23,-1,-1],[222,14,27,0,432,46,16,17,-1,5],[223,14,27,0,342,46,15,18,-1,4],[224,14,27,0,160,25,15,21,-1,1],[225,14,27,0,145,25,15,21,-1,1],[226,14,27,0,130,25,15,21,-1,1],[227,14,27,0,435,25,15,20,-1,2],[228,14,27,0,137,46,15,19,-1,3],[229,14,27,0,115,25,15,21,-1,1],[230,21,27,0,479,66,23,16,-1,6],[231,12,27,0,329,46,13,18,-1,7],[232,13,27,0,101,25,14,21,-1,1],[233,13,27,0,87,25,14,21,-1,1],[234,13,27,0,72,25,15,21,-1,1],[235,13,27,0,123,46,14,19,-1,3],[236,7,27,0,64,25,8,21,-1,1],[237,8,27,0,55,25,9,21,-1,1],[238,11,27,0,42,25,13,21,-1,1],[239,9,27,0,112,46,11,19,-1,3],[240,14,27,0,314,46,15,18,-1,3],[241,13,27,0,421,25,14,20,-1,2],[242,12,27,0,407,25,14,20,-1,1],[243,12,27,0,393,25,14,20,-1,1],[244,12,27,0,379,25,14,20,-1,1],[245,12,27,0,98,46,14,19,-1,2],[246,12,27,0,300,46,14,18,-1,3],[247,14,27,0,335,83,15,14,-1,5],[248,12,27,0,28,25,14,21,-1,4],[249,12,27,0,14,25,14,21,-1,1],[250,12,27,0,0,25,14,21,-1,1],[251,12,27,0,496,0,14,21,-1,1],[252,12,27,0,84,46,14,19,-1,3],[253,13,27,0,0,0,14,25,-1,1],[254,12,27,0,42,0,14,24,-1,3],[255,13,27,0,100,0,14,23,-1,3]])
		ManiacImg[IMG_LOGO] 						= LoadImage(PATH_IMG_LOGO)
		ManiacImg[IMG_BACKGROUND] 					= LoadImage(PATH_IMG_BACKGROUND,1,Image.MidHandle)
		ManiacImg[IMG_STYLE_MODERN_BACKGROUND] 		= LoadImage(PATH_IMG_STYLE_MODERN_BACKGROUND,1,Image.MidHandle)
		ManiacImg[IMG_STYLE_MODERN_FRAME] 			= LoadImage(PATH_IMG_STYLE_MODERN_FRAME,1,Image.MidHandle)
		ManiacImg[IMG_STYLE_MODERN2_BACKGROUND] 	= LoadImage(PATH_IMG_STYLE_MODERN2_BACKGROUND,1,Image.MidHandle)
		ManiacImg[IMG_STYLE_MODERN2_FRAME] 			= LoadImage(PATH_IMG_STYLE_MODERN2_FRAME,1,Image.MidHandle)
		ManiacImg[IMG_STYLE_ROUND_BACKGROUND] 		= LoadImage(PATH_IMG_STYLE_ROUND_BACKGROUND,1,Image.MidHandle)
		ManiacImg[IMG_STYLE_ROUND_FRAME] 			= LoadImage(PATH_IMG_STYLE_ROUND_FRAME,1,Image.MidHandle)
		ManiacImg[IMG_STYLE_CIRCLE_BACKGROUND] 		= LoadImage(PATH_IMG_STYLE_CIRCLE_BACKGROUND,1,Image.MidHandle)
		ManiacImg[IMG_STYLE_CIRCLE_FRAME] 			= LoadImage(PATH_IMG_STYLE_CIRCLE_FRAME,1,Image.MidHandle)
		ManiacImg[IMG_SLIDER_FLATLINE] 				= LoadImage(PATH_IMG_STYLE_FLATLINE,1,Image.MidHandle)
		ManiacImg[IMG_SLIDER_PICKER] 				= LoadImage(PATH_IMG_STYLE_PICKER,1,Image.MidHandle)
		ManiacImg[IMG_ICON_CHECKEDARROW]			= LoadImage(PATH_IMG_CHECKEDARROW,1,Image.MidHandle)
		ManiacImg[IMG_ICON_ARROWDOWN]				= LoadImage(PATH_IMG_ARROWDOWN,1,Image.MidHandle)
		ManiacImg[IMG_ICON_ARROWUP]					= LoadImage(PATH_IMG_ARROWUP,1,Image.MidHandle)
		
		ManiacImg[IMG_LOGO_PART_LEFT] 				= LoadImage(PATH_IMG_LOGO_PART_LEFT,1,Image.MidHandle)
		ManiacImg[IMG_LOGO_PART_RIGHT] 				= LoadImage(PATH_IMG_LOGO_PART_RIGHT,1,Image.MidHandle)
		ManiacImg[IMG_LOGO_PART_DOWN] 				= LoadImage(PATH_IMG_LOGO_PART_DOWN,1,Image.MidHandle)
		ManiacImg[IMG_LOGO_PART_TOP] 				= LoadImage(PATH_IMG_LOGO_PART_TOP,1,Image.MidHandle)
		ManiacImg[IMG_LOGO_PART_INNERCIRCLE]		= LoadImage(PATH_IMG_LOGO_PART_INNERCIRCLE,1,Image.MidHandle)
		ManiacImg[IMG_LOGO_PART_OUTERCIRCLE]		= LoadImage(PATH_IMG_LOGO_PART_OUTERCIRCLE,1,Image.MidHandle)
		ManiacImg[IMG_LOGO_PART_CENTER]				= LoadImage(PATH_IMG_LOGO_PART_CENTER,1,Image.MidHandle)
		ManiacImg[IMG_ICON_MOUSECURSOR]				= LoadImage(PATH_ICO_MOUSECURSOR,1,Image.MidHandle)
		
		ManiacImg[IMG_ICON_ZOOMIN]					= LoadImage(PATH_ICO_ZOOMIN,1,Image.MidHandle)
		ManiacImg[IMG_ICON_ZOOMOUT]					= LoadImage(PATH_ICO_ZOOMOUT,1,Image.MidHandle)

	
	Else
		#rem
			TO DO:
			Try to find a way to include some Async Loading stuff with the lowest impact of how to use this Framework.
			## RECOMMEND : SET TO FALSE ##
		#end 
	Endif 
	
	
	If MANIAC_DEBUG = True 
'		MANIAC_FPSGRAPH = New Maniac_Debug(DW*0.1,DH*0.7,DW*0.8,DH*0.29)
	Endif 
	
	Seed = Millisecs()
	initData_Quotes()
	initAppStates()
	mLogo = New ManiacGuiLogo(DW*0.4,DH*0.35,DW*0.35,DW*0.35)
	mLogo.addLayer(PATH_IMG_LOGO_PART_LEFT)
	mLogo.addLayer(PATH_IMG_LOGO_PART_RIGHT)
	mLogo.addLayer(PATH_IMG_LOGO_PART_DOWN)
	mLogo.addLayer(PATH_IMG_LOGO_PART_TOP)
	mLogo.addLayer(PATH_IMG_LOGO_PART_INNERCIRCLE)
	mLogo.addLayer(PATH_IMG_LOGO_PART_OUTERCIRCLE)
	mLogo.addLayer(PATH_IMG_LOGO_PART_CENTER)
	ManiacStartRuntime = Millisecs()
	mCurrInitTime = Millisecs()
	
	mLogo.getLayer(0).startAnimSlide(-DW*0.1,3000,"Back","Out")
	mLogo.getLayer(1).startAnimSlide(+DW*1.1,4000,"Back","Out")
	mLogo.getLayer(2).startAnimDrop(+DH*1.1,4500,"Back","Out")
	mLogo.getLayer(3).startAnimDrop(-DH*0.1,3500,"Back","Out")
	mLogo.getLayer(4).startAnimRotate(3000,1,"Back","InOut")
	mLogo.getLayer(5).startAnimPopIn(4500,"Back","Out")
	mLogo.getLayer(6).startAnimPopOut(5000,"Back","Out")
	
	monkeyLogo = New ManiacGuiLogo(DW*0.2,DH*0.88,DW*0.2,DW*0.2)
	monkeyLogo.addLayer("lib/DynamicLogos/MonkeyLogo/Logo_MonkeyHair.png")
	monkeyLogo.addLayer("lib/DynamicLogos/MonkeyLogo/Logo_MonkeyFace.png")
	monkeyLogo.addLayer("lib/DynamicLogos/MonkeyLogo/Logo_MonkeyEyes.png")
	monkeyLogo.addLayer("lib/DynamicLogos/MonkeyLogo/Logo_MonkeyEarRight.png")
	monkeyLogo.addLayer("lib/DynamicLogos/MonkeyLogo/Logo_MonkeyEarLeft.png")
	monkeyLogo.getLayer(0).startAnimPopIn(5000,"Back","Out")'startAnimPopOut(5000,"Back","Out")
	monkeyLogo.getLayer(1).startAnimPopOut(5000,"Back","Out")'startAnimRoll(DW*1.2,4000,-2,"Back","Out")'startAnimSlide(+DW*1.1,4000,"Back","Out")
	monkeyLogo.getLayer(2).startAnimDrop(+DH*1.1,4500,"Back","Out")
	monkeyLogo.getLayer(3).startAnimRotate(3000,-1,"Back","InOut")
	monkeyLogo.getLayer(4).startAnimRotate(3000,1,"Back","InOut")

	monkeyTitle = New ManiacTitle2(DW*0.3,DH*0.8,DW*0.5,DH*0.15)
	monkeyTitle.addCaharcter("M")
	monkeyTitle.addCaharcter("o")
	monkeyTitle.addCaharcter("n")
	monkeyTitle.addCaharcter("k")
	monkeyTitle.addCaharcter("e")
	monkeyTitle.addCaharcter("y")
	monkeyTitle.addCaharcter("-")
	monkeyTitle.addCaharcter("X")
	monkeyTitle.startAnimWaveInPopOut()
	
	mTitle = New ManiacTitle(DW*0.2,DH*0.5)
	mTitle.setScale(3.5)
	mTitle.addChar("M",COLOR_RED)
	mTitle.addChar("A",COLOR_GREEN)
	mTitle.addChar("N",COLOR_BLUE)
	mTitle.addChar("I",COLOR_YELLOW)
	mTitle.addChar("A",COLOR_ORANGE)
	mTitle.addChar("C",COLOR_PURPLE)
	
	mBackground = New ManiacGuiBackground(DW*0.5,DH*0.5,DW,DH)
	mBackground.addLayer("lib/DynamicBackgrounds/ManiacStandard/background_shiny.png")
	'mBackground.addLayer("lib/DynamicBackgrounds/ManiacStandard/background_frame.png")
	mBackground.getLayer(0).setBlink(true)
	mBackground.getLayer(0).setBlinkRange(0.05,0.6)
	mBackground.getLayer(0).setBlinkHertz(0.25)
	
	
End Function 

#rem monkeydoc
	This Function Draws additional Stuff, Like Intro ; Explosion Effects etc. .~n
	_DEBUG << can be True or False ; 
#end
Function maniacDraw()
	If MANIAC_DEBUG = True
		'MANIAC_FPSGRAPH.Draw()
	Else
	
	Endif
	
	 
	
	If mInit = True 		
		mBackground.Draw()
		Local scale:Float = 0.8
		SetColor 255,255,255
		SetAlpha 1
		Drw_ManiacText(" - " + ManiacQuotes[MANIAC_USE_QUOTE_ID][0]+" -  ("+ ManiacQuotes[MANIAC_USE_QUOTE_ID][1]+")",DW*0.05,DH*0.62,DW*0.9/scale,DH*0.9,ALIGNMENT_LEFT,ALIGNMENT_TOP,0.8)	 
		mLogo.Draw()
		
		Drw_ManiacText("Powered by",DW*0.2,DH*0.1,DW*0.6,DH*0.08,ALIGNMENT_LEFT,ALIGNMENT_MIDDLEY,2.3)
		mTitle.Draw()
		
		SetColor 255,255,255
		SetAlpha 1
		Drw_ManiacText("Written In",DW*0.1,DH*0.75,DW*0.6,DH*0.08,ALIGNMENT_LEFT,ALIGNMENT_MIDDLEY,1.7)
		monkeyTitle.Draw()
		monkeyLogo.Draw()
	Endif 
	
	If Millisecs() -  mCurrInitTime > mInitTime And bClickedNext = False
		Drw_ManiacText("[Click on Display]",DW*0.2,DH*0.02,DW*0.6,DH*0.08,ALIGNMENT_LEFT,ALIGNMENT_MIDDLEY,2.3)
	Endif  
	
	'DrawText "Runtime: " + ManiacCurrRuntime,DW-200,DH*0.9
	'DrawText "AllTime: " + ManiacAppStats[MANIACSTATS_APPRUNTIME],DW-200,DH*0.9+30
	'DrawText "AppStarts: " + ManiacAppStats[MANIACSTATS_APPSTARTS],10,DH*0.9
End Function

#rem monkeydoc
	This Function Updates additional Stuff, Like Intro ; Explosion Effects etc. .~n
	_DEBUG << can be True or False ; 
#end
Function maniacUpdate:Bool()
	UpdateAsyncEvents()
	If MANIAC_DEBUG = True
		Maniac_Debug.addCall()
	Endif
	If Millisecs() -  mCurrInitTime > mInitTime And bClickedNext = True 
		mInit = False 
		
	Endif
	ManiacCurrRuntime = Millisecs() - ManiacStartRuntime

	maniacCurrFrame +=1
	If Millisecs() - maniacLastUpdate >=1000
		maniacFPS_avg = maniacCurrFrame
		maniacCurrFrame = 0
		maniacLastUpdate = Millisecs()
	Endif 
	
	Maniac_CheckMouseState()
	
	ll_UpdateSpeeds()
	If mInit = True
	
		mLogo.Update()
		mBackground.Update()
		monkeyLogo.Update()
		monkeyTitle.Update()
		If TouchHit()
			bClickedNext = True 
		Endif 
		
		If KeyHit(KEY_SPACE)
			Print "RE-INIT Intro"
			mLogo.getLayer(0).startAnimSlide(-DW*0.1,3000,"Back","Out")
			mLogo.getLayer(1).startAnimSlide(+DW*1.1,4000,"Back","Out")
			mLogo.getLayer(2).startAnimDrop(+DH*1.1,4500,"Back","Out")
			mLogo.getLayer(3).startAnimDrop(-DH*0.1,3500,"Back","Out")
			mLogo.getLayer(4).startAnimRotate(3000,1,"Back","InOut")
			mLogo.getLayer(5).startAnimPopIn(4500,"Back","Out")
			mLogo.getLayer(6).startAnimPopOut(5000,"Back","Out")
			
			monkeyTitle.startAnimWaveInPopOut()
	
			monkeyLogo.getLayer(0).startAnimPopIn(5000,"Back","Out")'startAnimSlide(-DW*0.1,3000,"Back","Out")
			monkeyLogo.getLayer(1).startAnimPopOut(5000,"Back","Out")'startAnimRoll(DW*1.2,4000,-2,"Back","Out")'(+DW*1.1,4000,"Back","Out")
			monkeyLogo.getLayer(2).startAnimDrop(+DH*1.1,4500,"Back","Out")
			monkeyLogo.getLayer(3).startAnimRotate(3000,-1,"Back","InOut")
			monkeyLogo.getLayer(4).startAnimRotate(3000,1,"Back","InOut")
	
	
		Endif 
		Return True
		
	Else
		Return False 
	Endif 
End Function

Const MANIAC_INITTIME_SHORT:Int = 750
Const MANIAC_INITTIME_EXTENDSHORT:Int = 1000
Const MANIAC_INITTIME_MEDIUM:Int		= 1500
Const MANIAC_INITTIME_EXTENDMEDIUM:Int	= 1750
Const MANIAC_INITTIME_LONG:Int 			= 2000
Const MANIAC_INITTIME_EXTENDLONG:Int	= 2250
Const MANIAC_INITTIME_VERYLONG:Int 		= 2500
Const MANIAC_INITTIME_EXTREME:Int		= 5000


#rem monkeydoc
	This function sets the Init / Intro Time.
	Eather you can use the predefined Length:
		MANIAC_INITTIME_SHORT,MANIAC_INITTIME_EXTENDSHORT,MANIAC_INITTIME_MEDIUM,MANIAC_INITTIME_EXTENDMEDIUM,MANIAC_INITTIME_LONG,MANIAC_INITTIME_EXTENDLONG,MANIAC_INITTIME_VERYLONG,MANIAC_INITTIME_EXTREME
	Params: 
#end 
Function setInitTime:Void(_TimeInMilliSecs:Int)
	mInitTime = _TimeInMilliSecs
End Function 


#rem monkeydoc
	This Function Checks, wether the Framework is still Initing.
	
	returns true, if maniac is loading Data 
	returns false, if the Framework is ready to use
#end
Function maniacIsIniting:Bool()
	If mInit = True 
		Return True
	Else
		Return False
	Endif 
End Function 


#rem monkeydoc
	This Functions Loads the Quotes from Datafiles to the ManiacSystem.
#end 
private
Function initData_Quotes()
	'arrDayOf = Array2Dstr(12,31)
	ManiacQuotes = Array2Dstr(100,2)
	Local file:ManiacTextFile
	Print "Language: " + GLOBAL_LANGUAGE
	Select GLOBAL_LANGUAGE
		Case MANIAC_LANGUAGE_GERMAN
			file = New ManiacTextFile("lib/Texts/Quotes_german.dat")
			
		Case MANIAC_LANGUAGE_ENGLISH
			file = New ManiacTextFile("lib/Texts/Quotes_english.dat")
			
		Case MANAIC_LANGUAGE_FRENCH
	
	End Select 
	

	If file <> Null Then
			'Print "FOUND FILE"
		Local i:Int = 0 
		While file.Eof() = False
				
			file.ReadLine()
				'Print file.GetLine()
			Local quote:String =  file.GetDataName()
			Local author:String = file.GetDataValue()
			'Print "("+i+") Zitat: " + quote + " by " + author 
			
			ManiacQuotes[i][0] = quote
			ManiacQuotes[i][1] = author
			i +=1
 			
		End While
		Print "Found " + i + " quotes"
		
		MANIAC_USE_QUOTE_ID =  Rnd(0,i+1)
	Endif 
	
End Function 

Const MANIACSTATS_APPSTARTS:Int = 0
Const MANIACSTATS_APPRUNTIME:Int = 1

Function initAppStates:Void()
	ManiacAppStats = New Int[10]
	#If TARGET <> "html5"
		Local file:FileStream = FileStream.Open("ManiacAppStats.dat","r")
		Print "Init - Open File"
		If file <> Null
			Print "File Found"
			ManiacAppStats[MANIACSTATS_APPSTARTS] = file.ReadInt()+1
			ManiacAppStats[MANIACSTATS_APPRUNTIME] = file.ReadInt()
			file.Close()
		Else
			Print "Init - Write New File"
			Local wfile:FileStream = FileStream.Open("ManiacAppStats.dat","w")
			ManiacAppStats[MANIACSTATS_APPSTARTS] = 1
			ManiacAppStats[MANIACSTATS_APPRUNTIME] = 0
			
			wfile.WriteInt(ManiacAppStats[MANIACSTATS_APPSTARTS])
			wfile.WriteInt(ManiacAppStats[MANIACSTATS_APPRUNTIME])
			wfile.Close()
		Endif 
	#End 
End Function 

Public 
Function saveAppStates:Void()
	#If (TARGET <> "html5")
		Local wfile:FileStream = FileStream.Open("ManiacAppStats.dat","w")
		Print "Safe Data"
		wfile.WriteInt(ManiacAppStats[MANIACSTATS_APPSTARTS])
		wfile.WriteInt(ManiacAppStats[MANIACSTATS_APPRUNTIME]+(ManiacCurrRuntime/1000))
		wfile.Close()
	#Endif 
End Function 

Global MANIAC_USE_QUOTE_ID:Int  
	
#rem ClassScheme
	Explain , Aufgabe,zweck etc.
	Params type,zweck,was passiert wenn falscher
	Return
	
	Author
	Datum
	Example
#end


Global maniacFPS_avg:Int 
Global maniacCurrFrame:Int 
Global maniacLastUpdate:Int 

#rem monkeydoc
	Returning the Current FPS (1 Sek Avg)
#end 
Function maniacGetFPS:Int()
	Return maniacFPS_avg
End Function 