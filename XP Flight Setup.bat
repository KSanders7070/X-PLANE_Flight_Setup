@echo off

:HELLO

CLS

SET userselected=userselected_NotSet

echo.
echo.
echo -----------------------------------------------------------
echo.
echo       *** RUN THIS FILE IN ADMINISTRATOR MODE ***
echo.
echo  	  Also, you may want to add an exception to your
echo        virus/malware software for this .bat file.
echo.
echo -----------------------------------------------------------
echo.
echo.
echo    Issues? Type HELP and press Enter
echo.
echo.
echo.

	set /p userselected=Just Press Enter to Continue or Type HELP, Then Press Enter: 
		IF /I %userselected%==HELP GOTO HELP
		IF /I "%userselected%"=="userselected_NotSet" GOTO SET_VAR

:SET_VAR

SET DEPAPT=DEPAPT_NotSet

SET ARRAPT=ARRAPT_NotSet

SET XP_LOC=XP_LOC_NotSet

SET XP_DIR=XP_DIR_NotSet

CLS

IF EXIST "%userprofile%\Documents\X-Plane Auto Setup CFG" GOTO CFG_FOLDER_FOUND

CLS

echo.
echo.
echo -------------------------------
echo.
echo  Where is X-Plane Stored?
echo.
echo.
echo       A) On Your Computer
echo.
echo       B) Steam
echo.
echo -------------------------------
echo.
echo.

	set /p UserSelected=Type A or B and Press Enter: 
		IF /I %UserSelected%==A SET XP_LOC=LOCAL
		IF /I %UserSelected%==B SET XP_LOC=STEAM
		
		IF %XP_LOC%==LOCAL GOTO CFG
		IF %XP_LOC%==STEAM GOTO FLIGHT_SETUP

:CFG

CLS

	mkdir "%userprofile%\Documents\X-Plane Auto Setup CFG"
	echo.
	echo.
	echo ----------------------------------------------------
	echo.
	echo  Please Wait While A Configuration Folder Is Made
	echo.
	echo  %userprofile%\Documents\X-Plane Auto Setup CFG
	echo.
	echo ----------------------------------------------------
	echo.
	echo.
	
	PING 127.0.0.1 -n 4 >nul
	
		echo This directory was made for the X-Plane Auto Setup BATCH File to reference. >> "%userprofile%\Documents\X-Plane Auto Setup CFG\Read_Me.txt"
		echo. >> "%userprofile%\Documents\X-Plane Auto Setup CFG\Read_Me.txt"
		echo If ever move your X-Plane directory, come back here and delete the XP_CUSTOM_DIRECTORY.txt file and run the BATCH File again. >> "%userprofile%\Documents\X-Plane Auto Setup CFG\Read_Me.txt"
		echo. >> "%userprofile%\Documents\X-Plane Auto Setup CFG\Read_Me.txt"
		echo Original Author: Kyle Sanders (VATSIM CID: 1187147) >> "%userprofile%\Documents\X-Plane Auto Setup CFG\Read_Me.txt"

CLS

:CFG_FOLDER_FOUND

CD /D "%userprofile%\Documents\X-Plane Auto Setup CFG"
	IF EXIST "XP_CUSTOM_DIRECTORY.txt" GOTO XP_COMPARE1
	GOTO XP_COMPARE2

:XP_COMPARE1

	for /f "delims=" %%x in (XP_CUSTOM_DIRECTORY.txt) do set XP_DIR=%%x
	GOTO FLIGHT_SETUP

:XP_COMPARE2

CLS

echo.
echo.
echo --------------------------------------------------------------------
echo.
echo  Select ONLY the directory up to and including
echo  the Folder where the X-Plane.exe file is.
echo.
echo  Do NOT select the X-Plane.exe file.
echo.
echo     EXAMPLE:
echo.
echo         YES = C:\Users\Kyle Sanders\Desktop\X-Plane 11
echo.
echo          NO = C:\Users\Kyle Sanders\Desktop\X-Plane 11\X-Plane.exe
echo.
echo --------------------------------------------------------------------
echo.
echo.

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The X-Plane.exe',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "XP_DIR=%%I"
	
		echo %XP_DIR% >> "%userprofile%\Documents\X-Plane Auto Setup CFG\XP_CUSTOM_DIRECTORY.txt"

		CLS

:FLIGHT_SETUP

CLS

echo.
echo.
echo -------------------------------
echo.
echo   Type your DEPARTURE airport
echo.
echo       4 letter identifier
echo.
echo -------------------------------
echo.
echo.

	set /p DEPAPT=Press Enter when done: 
	
CLS

echo.
echo.
echo -------------------------------
echo.
echo    Type your ARRIVAL airport
echo.
echo       4 letter identifier
echo.
echo -------------------------------
echo.
echo.

	set /p ARRAPT=Press Enter when done: 

CLS

START "" "https://www.google.com/?gws_rd=ssl#q=%DEPAPT%+X-PLANE+11+SCENERY"

PING 127.0.0.1 -n 3 >nul

START "" "https://www.google.com/?gws_rd=ssl#q=%ARRAPT%+X-PLANE+11+SCENERY"

PING 127.0.0.1 -n 2 >nul

START "" "https://flightaware.com/analysis/route.rvt?origin=%DEPAPT%&destination=%ARRAPT%"

PING 127.0.0.1 -n 2 >nul

START "" "https://skyvector.com/?ll=38.27613847476006,-94.70654296764846&chart=304&zoom=10&fpl=%%20%DEPAPT%%%20undefined%%20%ARRAPT%"

PING 127.0.0.1 -n 2 >nul

START "" "https://www.airnav.com/airport/%DEPAPT%"

PING 127.0.0.1 -n 2 >nul

START "" "https://www.airnav.com/airport/%ARRAPT%"

PING 127.0.0.1 -n 2 >nul

START "" "https://www.aviationweather.gov/"

PING 127.0.0.1 -n 2 >nul

START "" "https://cert.vatsim.net/fp/file.php"

PING 127.0.0.1 -n 2 >nul

START "" "https://www.pilotedge.net/pilot_tools/file"

PING 127.0.0.1 -n 2 >nul

IF %XP_LOC%==LOCAL GOTO LOCAL
IF %XP_LOC%==STEAM GOTO STEAM

:LOCAL

CD /D %XP_DIR%
START X-Plane.exe

GOTO DONE


:STEAM

START "" "steam://rungameid/269950"

CLS

GOTO DONE

:DONE

echo.
echo.
echo ------------------------------------
echo.
echo      *** ORIGINAL AUTHOR ***
echo.
echo   Kyle Sanders VATSIM CID 1187148
echo.
echo ------------------------------------
echo.
echo.

TIMEOUT 15
EXIT /B

:HELP

CLS

ECHO.
ECHO.
ECHO   CHOOSE YOUR ISSUE:
ECHO.
ECHO         A)   HOW DO I RUN THIS BATCH FILE IN ADMINISTRATOR MODE?
ECHO.
ECHO         B)   MY ANTI-VIRUS/MALWARE SOFTWARE IS BLOCKING THIS BATCH FILE
ECHO.
ECHO         C)   WINDOWS WON'T ALLOW THE BATCH FILE TO RUN
ECHO.
ECHO         D)   I HAVE CHANGED THE LOCATION OF X-Plane
ECHO.
ECHO         E)   I WANT TO RESET MY ENTIRE SAVED SETUP CONFIGURATION
ECHO.
ECHO         F)   I WANT TO SET UP DIFFERENT WEBSITES/PROGRAMS TO OPEN
ECHO.
ECHO         G)   IS THIS FILE SAFE TO RUN? WHAT DOES IT DO?
ECHO.
ECHO         H)   I CAN'T SEE THE FOLDERS MY .EXE IS SUPPOSED TO BE STORED IT
ECHO.
ECHO         I)   OTHER/STILL HAVING ISSUES/CONTACT ORIGINAL AUTHORS
ECHO.
ECHO         J)   NEVERMIND
ECHO.
ECHO.

	set /p userselected=Type Your Response (A - I) and Press Enter: 
		IF /I %userselected%==A GOTO ADMIN_MODE
		IF /I %userselected%==B GOTO ANTI_VIRUS
		IF /I %userselected%==C GOTO WDS_EXCLUSION
		IF /I %userselected%==D GOTO DIR_CHG
		IF /I %userselected%==E GOTO RESET_CFG
		IF /I %userselected%==F GOTO CREATE_BAT
		IF /I %userselected%==G GOTO SAFE_ABOUT
		IF /I %userselected%==H GOTO HIDDEN_FOLDERS
		IF /I %userselected%==I GOTO CONTACT_AUTHOR
		IF /I %userselected%==J GOTO HELLO
		
		echo.
		echo.
		echo.
		echo.
		echo  %userselected% IS NOT A RECOGNIZED RESPONSE. Try again.
		echo.
		
		PAUSE
		CLS
		GOTO HELP

:ADMIN_MODE

CLS

START "" https://fossbytes.com/batch-file-run-as-administrator-windows/

ECHO.
ECHO.
ECHO   This is done by simply right clicking the BAT file and selecting:
ECHO   "Run as Administrator"
ECHO.
ECHO   However, this BATCH File should have opened the link just now to
ECHO   the instructions for opening this BATCH file in ADMIN MODE automatically.
ECHO.
ECHO.

PAUSE
CLS
GOTO HELLO

:ANTI_VIRUS

CLS

ECHO.
ECHO.
ECHO What ANTI-VIRUS/MALWARE SOFTWARE DO YOU USE?
ECHO.
ECHO.

	set /p userselected=Type Your Response and Press Enter: 

START "" "https://www.google.com/?gws_rd=ssl#q=ADD+BATCH+FILE+TO+%USERSELECTED%+EXCLUSION+LIST"

CLS

ECHO.
ECHO.
ECHO   This BATCH File should have opened the link just now to
ECHO   the instructions for adding a BATCH file to your
ECHO   anti-virus/malware software exlcusion list.
ECHO.
ECHO.

PAUSE
CLS
GOTO HELLO

:WDS_EXCLUSION

CLS

START "" https://winaero.com/blog/exclusions-windows-defender-windows-10/

ECHO.
ECHO   This BATCH File should have opened the link just now to
ECHO   the instructions for adding a BATCH file to your Windows
ECHO   exclusion list.
ECHO.
ECHO.

PAUSE
CLS
GOTO HELLO

:DIR_CHG

CLS

ECHO.
ECHO.
ECHO   If you have changed X-Plane's location (directory) from what you have previously
ECHO   told this BATCH File, this will allow you to run the BATCH File again
ECHO   and select the new location for X-Plane.
ECHO.
ECHO   CHOICES:
ECHO.
ECHO                A  =  I changed X-Plane's Location (Directory)
ECHO.
ECHO                B  =  Nevermind
ECHO.
ECHO.

	set /p userselected=Type Your Response (A or B) and Press Enter: 
		IF /I %userselected%==A GOTO RESET_CFG_ACTUAL
		IF /I %userselected%==B GOTO HELLO
		
		echo.
		echo.
		echo.
		echo.
		echo  %userselected% IS NOT A RECOGNIZED RESPONSE. Try again.
		echo.
		
		PAUSE
		CLS
		GOTO DIR_CHG
		
:RESET_CFG

CLS

ECHO.
ECHO.
ECHO   If you wish to completely delete all saved directories and reset the
ECHO   BATCH File to new, press any key to continue. 
ECHO.
ECHO.

PAUSE

:RESET_CFG_ACTUAL

CD "%userprofile%\Documents"
RD /S /Q "%userprofile%\Documents\X-Plane Auto Setup CFG"

GOTO HELLO

:CREATE_BAT

CLS

START "" "https://www.google.com/?gws_rd=ssl#q=HOW+TO+WRITE+BATCH+FILES"

ECHO.
ECHO.
ECHO   This is done by simply right clicking the BAT file and
ECHO    selecting "EDIT".
ECHO.
ECHO   This BATCH File should have opened the link just now to
ECHO   the instructions for editing a BATCH file.
ECHO.
ECHO   If you are still stuck, consider contacting the
ECHO   original authors.
ECHO.
ECHO.

PAUSE
CLS
GOTO HELLO

:SAFE_ABOUT

CLS

START "" "https://docs.google.com/presentation/d/e/2PACX-1vTTbx5Szs5I8oveHofFnDDkJxYIWHcb7GqfyQYNXE-JtG2BX6_R0BTyj3DwOqFIRNoco1x8_XwgSc0Z/embed"

ECHO.
ECHO.
ECHO This is what is called a BATCH File.
ECHO For more information, read/watch the material in the google search
ECHO launched in your default internet browser.
ECHO.
ECHO This BATCH File will do the following:
ECHO.
ECHO     Create a folder in your Documents folder. This will help
ECHO     save your X-Plane location if you don't use Steam.
ECHO.
ECHO     This BATCH File does not modify ANY of your core computer
ECHO     files or programs. It never touches the registry or any
ECHO     core components of your OS.
ECHO.
ECHO     With that being said, there are times that the BATCH File
ECHO     will not work correctly if not ran as "Administrator" and
ECHO     not given exclusions to your windows/custom
ECHO     anti-virus/malware software.
ECHO.
ECHO     If you have any further questions, you may right click on
ECHO     the BATCH File and select "Edit" to read the code yourself,
ECHO     have a knowledgable friend look at it first or contact the
ECHO     original authors with any questions.
ECHO.
ECHO.

PAUSE
CLS
GOTO HELLO

:HIDDEN_FOLDERS

START "" "https://support.microsoft.com/en-us/help/14201/windows-show-hidden-files"

ECHO.
ECHO.
ECHO  Chances are that your windows setup is set to hide
ECHO  certain files and folders for use.
ECHO.
ECHO  Follow the steps provided on the webpage
ECHO  that has been opened for you.
ECHO.
ECHO.

PAUSE
CLS
GOTO HELLO

:CONTACT_AUTHOR

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo   STILL HAVING ISSUES OR HAVE FURTHER QUESTIONS?
echo.
echo   Contact the original author of this BATCH File.
echo.
echo.
echo.
echo -----------------------------------------------------------------------------
echo.
echo         Original Author:
echo.
echo                          Kyle Sanders (VATSIM CID 1187147)
echo.
echo -----------------------------------------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

PAUSE
CLS
GOTO HELLO