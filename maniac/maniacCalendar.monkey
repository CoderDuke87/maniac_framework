Import mojo

Function CalcDateDifference:Int[](date1:Int[],date2:Int[])
	Local diff:Int[] = New Int[6]
	Local carryMin:Bool 
	Local carrySec:Bool 
	
	'Check Seconds
	If date2[5] < date1[5]
		carrySec = True 
		diff[5] = 60 - (date1[5] - date2[5])
	Elseif date2[5] > date1[5]
		carrySec = False 
		diff[5] = date2[5] - date1[5]
	Elseif date2[5] = date1[5]
		carrySec = False 
		diff[5] = 0
	Endif
	
	
	'Check Minutes
	If date2[4] < date1[4]
		carryMin = True 
		diff[4] = 60 - (date1[4] - date2[4])
	Elseif date2[4] > date1[4]
		carryMin = False 
		diff[4] = date2[4] - date1[4]
	Elseif date2[4] = date1[4]
		carryMin = False 
		diff[4] = 0
	Endif 
	
	Return diff
End Function 


Function DiffYear:Int(date1:Int[],date2:Int[])
	If (date2[1] > date1[1])
    	Return date2[0] - date1[0]
	Endif 
	
  	If (date2[1] < date1[1])
    	Return (date2[0] - date1[0] - 1 )
	Endif 
	
 	' // Monate sind identisch.
  	if (date2[2] > date1[2])
    	return date2[0] - date1[0]
	Endif 
  	If (date2[2] < date1[2])
    	return date2[0] - date1[0] - 1
	Endif 
  
  	'// Tag ist bei beiden identisch.
  	if (date2[3] > date1[3])
    	return date2[0] - date1[0]
	Endif 
 	If (date2[3] < date1[3])
    	return date2[0] - date1[0] - 1
	Endif 
  
  	'// Stunde ist identisch
 	If (date2[4] > date1[4])
    	Return date2[0] - date1[0]
	Endif 

  	If (date2[4] < date1[4])
    	return date2[0] - date1[0] - 1
	Endif 
	
  	if (date2[5] > date1[5])
    	return date2[0] - date1[0]
	Endif 
	
  	If (date2[5] < date1[5])
    	return date2[0] - date1[0] - 1
	Endif 
  
  	return date2[0] - date1[0] - 1
End Function 


Function DiffDays:Int(date1:Int[],date2:Int[])

  '// Ist die Ende-Uhrzeit auch hinter der Startuhrzeit ? Das ist der Normalfall.
  '// Andernfalls müssen wir nachher noch eins abziehen!

  	Local lAbzug:int = 0

  	If (  (date2[3] < date1[3]) Or ((date2[3] = date1[3]) And (date2[4] < date1[4])) Or  ( (date2[3] = date1[3]) And (date2[4] = date1[4]) And (date2[5] < date1[5])))
  
  	Else
  		lAbzug = 1
  	Endif 

#rem
		date1[0] = 2015  YEAR
		date1[1] = 2	 MONTH
		date1[2] = 28		DAY
		date1[3] = 9	HOUR
		date1[4] = 15	MIN
		date1[5] = 34	SEC
	#end 
  '// Im gleichen Jahr ? Dann nutzen wir "getTagDesJahres":
  	If (date2[0] = date1[0])
    	Return getDayOfYear(date2[2], date2[1],date2[0]) - getDayOfYear(date1[2], date1[1], date1[0]) - lAbzug

  	Elseif (date2[0] > date1[0])
  
    	'// Wir starten mit der Anzahl Tage im Endejahr:
    	Local lErgebnis:Int = getDayOfYear(date2[2], date2[1],date2[0]) - lAbzug

    	Local uJahr:int = date2[0] - 1

   		'// Jetzt summieren wir alle dazwischenliegenden Jahre:
   		While (uJahr > date1[0])
      		lErgebnis += getDaysOfYear(uJahr)
      		uJahr -=1 
    	End 

    	'// und addieren schließlich noch die Anzahl der Tage aus dem Start - Jahr:
    	lErgebnis += (getDaysOfYear(date1[0]) - getDayOfYear(date1[2], date1[1], date1[0]))

   		Return lErgebnis

  	Else
    	Return -1 '; // Die Endezeit liegt vor der Startzeit !
	Endif 
End Function 


Function DiffSeconds(date1:Int[], date2:Int[])

  	Local lErgebnis:Int = date2[5] - date1[5] 
 ' // lErgebnis kann durchaus negativ sein ! Wird aber gleich korrigiert.
  	lErgebnis += (date2[4] - date1[4]) * 60
  	lErgebnis += (date2[3] - date1[3]) * 3600

  '// Im gleichen Jahr ? Dann nutzen wir "getTagDesJahres":
  	If (date2[0] = date1[0])
    	Return (((getDayOfYear(date2[2], date2[1],date2[0]) - getDayOfYear(date1[2], date1[1],date1[0])) * 86400) + lErgebnis)

  	ElseIf (date2[0] > date1[0])
  
    '// Wir starten mit der Anzahl Tage im Endejahr
    	lErgebnis += getDayOfYear(date2[2], date2[1],date2[0]) * 86400

    	Local uJahr:Int = date2[0] - 1

    '// Jetzt summieren wir alle dazwischenliegenden Jahre:
    	While (uJahr > date1[0])
      		lErgebnis += (getDaysOfYear(uJahr) * 86400)
      		uJahr -=1
    	End 

    '// und addieren schließlich noch die Anzahl der Tage aus dem Start - Jahr:
    	lErgebnis += ((getDaysOfYear(date1[0]) - getDayOfYear(date1[2], date1[1],date1[0])) * 86400)

    	return lErgebnis
  

  	Else 
    	Return -1'; // Die Endezeit liegt vor der Startzeit !
  	Endif 
End Function 

Function isLeapYear:Bool(_Year:int)

	#rem
  // Die Regel lautet: Alles, was durch 4 teilbar ist, ist ein Schaltjahr.
  // Es sei denn, das Jahr ist durch 100 teilbar, dann ist es keins.
  // Aber wenn es durch 400 teilbar ist, ist es doch wieder eins.
	#end
  	if ((_Year Mod 400) = 0)
    	return true
  	else if ((_Year Mod 100) = 0)
    	return false
  	else if ((_Year Mod 4) = 0)
    	return true
	Endif 
  	Return False

End Function 


Function getWeekday(_Day:Int, _Month:Int, _Year:int)

'//                       ungült Jan Feb Mrz Apr Mai Jun Jul Aug Sep Okt Nov Dez 
	Local arrMonatsOffset:Int[] = [  0,  0,  3,  3,  6,  1,  4,  6,  2,  5,  0,  3,  5]

  	Local nResult:int = 0

	#rem
  _ASSERT(uTag > 0);
  _ASSERT(uTag <= 31);
  _ASSERT(uMonat > 0);
  _ASSERT(uMonat <= 12);
	#end
  '// Monat / Tag - Plausi prüfen:
  If ((_Day > 31) or (_Month > 12) or (_Month <= 0) or (_Day <= 0) or (_Year <= 0))
  
    return -1
  Endif 

  Local cbTagesziffer:int = (_Day Mod 7)
  Local cbMonatsziffer:int = arrMonatsOffset[_Month]
  Local cbJahresziffer:int = ((_Year mod 100) + ((_Year mod 100) / 4)) mod 7
  Local cbJahrhundertziffer:int = (3 - ((_Year / 100) Mod 4)) * 2

  '// Schaltjahreskorrektur:
  If ( (_Month <= 2) And (isLeapYear(_Year)) )
   	 cbTagesziffer = cbTagesziffer + 6
  Endif 
  nResult = (cbTagesziffer + cbMonatsziffer + cbJahresziffer + cbJahrhundertziffer) mod 7

	#rem
  // Ergebnis:
  // 0 = Sonntag
  // 1 = Montag
  // 2 = Dienstag
  // 3 = Mittwoch
  // 4 = Donnerstag
  // 5 = Freitag
  // 6 = Samstag
  #end 
  return nResult
End Function 
Function getDaysOfMonth:int(uMonat:Int , uJahr:Int )

 ' //                     ungült,Jan,Feb,Mrz,Apr,Mai,Jun,Jul,Aug,Sep,Okt,Nov,Dez
  	Local arrTageImMonat:Int[] = [  0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

  	if (uMonat = 2)
    '// Februar: Schaltjahr unterscheiden
    	if (isLeapYear(uJahr))
     	 	return 29
    	else
     		Return 28
     	Endif 
  	Endif 

 	if ((uMonat >= 1) and (uMonat <= 12))
    	return arrTageImMonat[uMonat]
  	else
   '// ungültiger Monat !
    	return 0
  	Endif 
End Function  

Function getDaysOfYear(uJahr:int)

	If isLeapYear(uJahr)
		Return 366
	Else
		Return 365
	Endif 
End Function  

Function getDayOfYear:Int(uTag:Int,uMonat:Int,uJahr:int)

 ' // Der wievielte Tag des Jahres ist dieser Tag
  	if ((uMonat = 0) or (uMonat > 12))
    	return -1
  	Endif 

  	Local uLokalTag:int = uTag
 	Local uLokalMonat:Int = uMonat
 	
  	while (uLokalMonat > 1)
  	
   		uLokalMonat -=1
    	uLokalTag += getDaysOfMonth(uLokalMonat, uJahr)
  	End 

 	return uLokalTag
End Function   
#rem

long ZeitDifferenzInJahren(const SYSTEMTIME & Startzeit, 
                           const SYSTEMTIME & Endezeit) const
{
  if (Endezeit.wMonth > Startzeit.wMonth)
    return Endezeit.wYear - Startzeit.wYear;

  if (Endezeit.wMonth < Startzeit.wMonth)
    return Endezeit.wYear - Startzeit.wYear - 1;

  // Monate sind identisch.

  if (Endezeit.wDay > Startzeit.wDay)
    return Endezeit.wYear - Startzeit.wYear;

  if (Endezeit.wDay < Startzeit.wDay)
    return Endezeit.wYear - Startzeit.wYear - 1;

  // Tag ist bei beiden identisch.

  if (Endezeit.wHour > Startzeit.wHour)
    return Endezeit.wYear - Startzeit.wYear;

  if (Endezeit.wHour < Startzeit.wHour)
    return Endezeit.wYear - Startzeit.wYear - 1;

  // Stunde ist identisch.

  if (Endezeit.wMinute > Startzeit.wMinute)
    return Endezeit.wYear - Startzeit.wYear;

  if (Endezeit.wMinute < Startzeit.wMinute)
    return Endezeit.wYear - Startzeit.wYear - 1;

  if (Endezeit.wSecond > Startzeit.wSecond)
    return Endezeit.wYear - Startzeit.wYear;

  if (Endezeit.wSecond < Startzeit.wSecond)
    return Endezeit.wYear - Startzeit.wYear - 1;

  if (Endezeit.wMilliseconds >= Startzeit.wMilliseconds)
    return Endezeit.wYear - Startzeit.wYear;
  else
    return Endezeit.wYear - Startzeit.wYear - 1;
}
//////////////////////////////////////////////////////////////////////////////
// Die Zeitdifferenz in Monaten läßt sich nicht exakt ausrechnen,
// weil ein Monat nicht immer gleich lang ist. Beispiel:
// Zwischen dem 28.2. und dem 28.3. liegen nur 28 Tage. 
// Ist das schon ein Monat (28. bis 28.) ????
// Der März ist erst am 31.3. zu Ende ! Ist das ein Monat (28.2. - 31.3.) ????
//////////////////////////////////////////////////////////////////////////////

long ZeitDifferenzInTagen(const SYSTEMTIME & Startzeit, 
                          const SYSTEMTIME & Endezeit)
{
  // Ist die Ende-Uhrzeit auch hinter der Startuhrzeit ? Das ist der Normalfall.
  // Andernfalls müssen wir nachher noch eins abziehen!

  long lAbzug = 0;

  if (  (Endezeit.wHour < Startzeit.wHour)
    ||  ((Endezeit.wHour == Startzeit.wHour) 
          && (Endezeit.wMinute  < Startzeit.wMinute))
    ||  ((Endezeit.wHour == Startzeit.wHour) 
          && (Endezeit.wMinute == Startzeit.wMinute) 
          && (Endezeit.wSecond  < Startzeit.wSecond))
    ||  ((Endezeit.wHour == Startzeit.wHour) 
          && (Endezeit.wMinute == Startzeit.wMinute) 
          && (Endezeit.wSecond == Startzeit.wSecond) 
          && (Endezeit.wMilliseconds < Startzeit.wMilliseconds))
     )
  {
    lAbzug = 1;
  }

  // Im gleichen Jahr ? Dann nutzen wir "getTagDesJahres":
  if (Endezeit.wYear == Startzeit.wYear)
    return getTagDesJahres(Endezeit.wDay, Endezeit.wMonth, Endezeit.wYear) 
           - getTagDesJahres(Startzeit.wDay, Startzeit.wMonth, Startzeit.wYear) 
           - lAbzug;

  else if (Endezeit.wYear > Startzeit.wYear)
  {
    // Wir starten mit der Anzahl Tage im Endejahr:
    long lErgebnis = getTagDesJahres(Endezeit.wDay, Endezeit.wMonth, 
                                       Endezeit.wYear) - lAbzug;

    UINT uJahr = Endezeit.wYear - 1;

    // Jetzt summieren wir alle dazwischenliegenden Jahre:
    while (uJahr > Startzeit.wYear)
    {
      lErgebnis += getAnzahlTageImJahr(uJahr);
      uJahr--;
    }

    // und addieren schließlich noch die Anzahl der Tage aus dem Start - Jahr:
    lErgebnis += (getAnzahlTageImJahr(Startzeit.wYear) 
                  - getTagDesJahres(Startzeit.wDay, 
                                    Startzeit.wMonth, Startzeit.wYear));

    return lErgebnis;
  }

  else
    return -1; // Die Endezeit liegt vor der Startzeit !
}

long ZeitDifferenzInSekunden(const SYSTEMTIME & Startzeit, const SYSTEMTIME & Endezeit)
{
  __int64 lErgebnis = Endezeit.wSecond - Startzeit.wSecond; 
  // lErgebnis kann durchaus negativ sein ! Wird aber gleich korrigiert.
  lErgebnis += (Endezeit.wMinute - Startzeit.wMinute) * 60;
  lErgebnis += (Endezeit.wHour - Startzeit.wHour) * 3600;

  // Im gleichen Jahr ? Dann nutzen wir "getTagDesJahres":
  if (Endezeit.wYear == Startzeit.wYear)
    return (long) 
      (((getTagDesJahres(Endezeit.wDay, Endezeit.wMonth, Endezeit.wYear) 
      - getTagDesJahres(Startzeit.wDay, Startzeit.wMonth, Startzeit.wYear)) * 86400)
      + lErgebnis);

  else if (Endezeit.wYear > Startzeit.wYear)
  {
    // Wir starten mit der Anzahl Tage im Endejahr
    lErgebnis += getTagDesJahres(Endezeit.wDay, Endezeit.wMonth, Endezeit.wYear) * 86400;

    UINT uJahr = Endezeit.wYear - 1;

    // Jetzt summieren wir alle dazwischenliegenden Jahre:
    while (uJahr > Startzeit.wYear)
    {
      lErgebnis += (getAnzahlTageImJahr(uJahr) * 86400);
      uJahr--;
    }

    // und addieren schließlich noch die Anzahl der Tage aus dem Start - Jahr:
    lErgebnis += ((getAnzahlTageImJahr(Startzeit.wYear) 
            - getTagDesJahres(Startzeit.wDay, 
                    Startzeit.wMonth, Startzeit.wYear)) * 86400);

    return (long) lErgebnis;
  }

  else
    return -1; // Die Endezeit liegt vor der Startzeit !
}    
#end

Function GetCurrentDateTime:String()
	Local date:=GetDate()
    Local months:=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    Print "Day: " + date[2]
    Print "Month: " + date[1]
   	Print "Yeahr: " + date[0]
   	Print "Hour: " + date[3]
   	Print "Min: " + date[4]
   	Print "Sec: " + date[5]
    'Local now:String = hour+":"+min+":"+sec+"  "+day+" "+month+" "+year
    'Return now
End Function

Function BoolToString:String(_Bool:Bool)
	If _Bool = True
		Return "Ja"
	Else
		Return "Nein"
	Endif 
End Function 

Function GetNextDayDate:int[](_Year:Int,_Month:Int,_Day:Int)
	Local nDays:Int = getDaysOfMonth(_Month , _Year )
	
	Local date:Int[] = New Int[3]
	If _Day < nDays
		date[0] = _Year
		date[1] = _Month
		date[2] = _Day+1
	Else
		If _Month < 12
			date[0] = _Year+1
			date[1] = 1
			date[2] = 1
		Else
			date[0] = _Year
			date[1] = _Month+1
			date[2] = 1
		Endif 
	Endif 
	
	Return date
End Function 
