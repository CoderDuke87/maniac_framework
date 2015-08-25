#Rem monkeydoc Module maniac.maniacFont
	Fontmodule-Version 1.1  ~n
	Copyright (C) 2015  Stephan Duckerschein~n
	
	Here You can find my Font Module.
	You can use it for drawing with another Font then the Monkey Standard.
	It features automatically wraps the Text into a Rectangle and let it Write like a Fontmachine.
	
	
	CHANGES: maniacFont
	Version 1.1 added:
		- Method: getW:int(txt:String) returns the lengths of a String in Pixel
		- italic style to the Wrap method as parameter
		
	Implemented Feature: FONT
		- Wrapping a Text with a certain Font to Rectangle 
		- Writing Italic Text
#End

Import mojo
Import maniac

Const CHARACTER_ASCII := 0
Const CHARACTER_WIDTH := 1
Const CHARACTER_HEIGHT := 2
Const CHARACTER_PAGE := 3
Const CHARACTER_RECT_X := 4
Const CHARACTER_RECT_Y := 5
Const CHARACTER_RECT_WIDTH := 6
Const CHARACTER_RECT_HEIGHT := 7
Const CHARACTER_OFFSET_X := 8
Const CHARACTER_OFFSET_Y := 9


#Rem monkeydoc
	This is the Font Class.
	It automatically wraps the Text into a Rectangle.
	You can even let it Write like a Fontmachine.
#End
Class ManiacFont
    Field width:Int = 0
    Field height:Int = 0
    Field pages:Image[0]
    Field baseCharacter:Int = 0
    Field characters:FontCharacter[256]

	#Rem monkeydoc
		This is the Constructor for the Font Class-Object.
		
	#End
    Method New(_width:Int,_height:Int,_pages:String[],_characters:Int[][])
        ' --- setup the font object with the data passed in! ---
        width = _width
        height = _height

        'load in the page images
        pages = New Image[_pages.Length()]
        For Local index := 0 Until _pages.Length()
            pages[index] = LoadImage(_pages[index])
        Next

        'create the
        For Local character := Eachin _characters
            characters[character[CHARACTER_ASCII]] = New FontCharacter(character[CHARACTER_WIDTH],character[CHARACTER_HEIGHT],pages[character[CHARACTER_PAGE]],character[CHARACTER_RECT_X],character[CHARACTER_RECT_Y],character[CHARACTER_RECT_WIDTH],character[CHARACTER_RECT_HEIGHT],character[CHARACTER_OFFSET_X],character[CHARACTER_OFFSET_Y])
        Next
    End

    Method Draw(text:String,x:Float,y:Float)
        ' --- draw a single line of text ---
        Local length:Int = text.Length()
        Local character:FontCharacter

        For Local index := 0 Until length
            character = characters[text[index]]
            If character <> Null
                print text[index]
                DrawImage(character.image,x,y)
                x += character.width
            Endif
        Next
    End
    
    
    #Rem monkeydoc
		This Method returns the width in Pixel of the given text.
	#End
    Method getW:Int(text:String)
    	Local n:Int = text.Length()
    	Local l:Int 
    	Local character:FontCharacter
    	For Local index := 0 Until n
            character = characters[text[index]]
            If character <> Null
                l += character.width
            Endif
        Next
        
        Return l
    End Method 
    
    function getH:Float()
    	Return 27
    End Function  
    
    Function getH2:Float()
    	Return height
    End Function 

	#Rem monkeydoc
		This Method fits the Text to the given Container Dimensions.
		
		<pre>
		Example:
		font.Wrap("Hallo Welt",100,100,200,400,0)
		
		</pre>
	#End
    Method Wrap(text:String,containerX:Float,containerY:Float,containerWidth:Float,containerHeight:Float,count:Int=-1,bitalic:Bool = False)
    	If MANIAC_DEBUG = True
			'Maniac_Debug.addCalc()
			Maniac_Debug.addCall()
		Endif
        ' --- wrap text within an area ---
        'get the number of characters that will be rendered from the text
        If count < 0 Or count > text.Length() count = text.Length()

        Local drawX:Float = containerX
        Local drawY:Float = containerY
        Local lineStart:Bool = True
        Local textIndex:Int = 0
        Local textLength = text.Length()
        Local wordStart:Int
        Local wordLength:Int
        Local wordWidth:Int
        Local character:FontCharacter

        While textIndex < count
            'find the next complete word!
            wordStart = textIndex
            wordLength = 0
            For Local wordIndex := textIndex Until textLength
                If text[wordIndex] = 32
                    'break out as a word has been found
                    Exit
                Else
                    'increase the word length
                    wordLength += 1
                Endif
            Next

            'calculate the width of the word
            wordWidth = 0
            For Local wordIndex := wordStart Until wordStart + wordLength
                character = characters[text[wordIndex]]
                If character <> Null wordWidth += character.width
            Next

            'add split character
            If lineStart = False
                character = characters[32]
                If character
                    If drawX + character.width <= containerX + containerWidth
                        DrawImage(character.image,drawX,drawY)
                        drawX += character.width
                    Else
                        drawX = containerX
                        drawY += height
                        If drawY + height > containerHeight Return
                        lineStart = True
                    Endif
                Endif
            Endif

            'make sure only drawing upto count!
            textIndex += 1
            If textIndex > count Return


			If bitalic = True
				ShearXAt(drawX, drawY, -20)
			Endif 
            'render the word
            'print text[wordStart..wordStart+wordLength]+" :: "+(drawX + wordWidth)+" / "+(containerX + containerWidth)
            If drawX + wordWidth <= containerX + containerWidth Or wordWidth <= containerWidth
                'move WHOLE word onto new line
                If drawX + wordWidth > containerX + containerWidth
                    drawX = containerX
                    drawY += height
                    If drawY + height > containerHeight Return
                    lineStart = True
                Endif

                'draw word as a whole!
                For Local drawIndex := wordStart Until wordStart + wordLength
                    'print String.FromChar(text[drawIndex])
                    character = characters[text[drawIndex]]
                    If character <> Null
                        DrawImage(character.image,drawX,drawY)
                        drawX += character.width
                    Endif

                    'make sure only drawing upto count!
                    textIndex += 1
                    If textIndex > count Return
                Next
                lineStart = False
            Else
                'need to split the word onto multiple lines!
                 For Local drawIndex := wordStart Until wordStart + wordLength
                    character = characters[text[drawIndex]]
                    If character
                        'look for going onto new line!
                        If drawX + character.width > containerX + containerWidth
                            drawX = containerX
                            drawY += height
                            If drawY + height > containerHeight Return
                            lineStart = True
                        Endif

                        'draw the character
                        DrawImage(character.image,drawX,drawY)
                        drawX += character.width
                        lineStart = False
                    Endif

                    'make sure only drawing upto count!
                    textIndex += 1
                    If textIndex > count Return
                Next
            Endif
            
            '
        Wend
        
        ResetMatrix()
    End
End



Class FontCharacter
    Field width:Int
    Field height:Int
    Field image:Image

    Method New(_width:Int,_height:Int,page:Image,rectX:Int,rectY:Int,rectWidth:Int,rectHeight:Int,offsetX:Int,offsetY:Int)
        width = _width
        height = _height
        image = page.GrabImage(rectX,rectY,rectWidth,rectHeight)
        image.SetHandle(-offsetX,-offsetY)
    End
End
