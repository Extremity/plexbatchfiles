@echo off
SETLOCAL DisableDelayedExpansion
title Thumbnail Import
color 0e
echo\&echo This script must be placed in the proper location to work.
echo\
echo Make sure your thumbnails are in located in season folders, named SXXEXX.ext.
echo This batch file should be in the same directory as those season folders, the
echo parent directory. For example, with the folder structure:
echo\
echo Pictures ^> Plex Thumbs ^> Severance ^> Season 1, Season 2, etc ^> S01E01.png, S01E02.png, etc
echo\
echo ...this batch script would be located in the "Severance" folder.
echo\
echo The season folders should match your TV show season folders; ie, Season 1 or Season 01.
echo Any folder names will work, really, as long as they match the seasons of the show. ie, 
echo thumbnails in a "Season 4" folder will attempt to connect with episode files in a
echo "Season 4" folder.
echo\
@pause
:begin
cls
color 0b
echo\
echo Please enter the number corresponding to your thumbnails' file type
echo\
echo 1) .png
echo 2) .jpg
echo 3) .jpeg
echo 4) .tbn
echo\
echo 9)  Exit
echo\
set ext=

choice /n /c 12349 /m "Input:"
IF %ERRORLEVEL% == 1 (set ext=png&goto set)
IF %ERRORLEVEL% == 2 (set ext=jpg&goto set)
IF %ERRORLEVEL% == 3 (set ext=jpeg&goto set)
IF %ERRORLEVEL% == 4 (set ext=tbn&goto set)
IF %ERRORLEVEL% == 5 exit
goto begin

:set

cls
:set2
echo\
color 0b
echo Enter the path to the TV show's base directory; ie: D:\Plex Content\Television\Rick and Morty
echo\
echo Do note use quotes.
echo\
set pth=
set /p pth=Directory path: 
if not defined pth goto set
set "pth=%pth:/=\%"
if not exist "%pth%" cls&echo That path does not exist.&goto set2
if %pth:~-1% == \ (set "pth=%pth:~0,-1%")

cls
:set3
echo\
echo Thumbnail type: .%ext%
echo Episode path: "%pth%"
echo\
echo Would you like to move these thumbnails, or copy them^?
echo\
echo 1) Move
echo 2) Copy
echo\
echo 8) Start Over
echo 9) Exit
echo\
set m=
choice /n /c 1289 /m "Enter:"
IF %ERRORLEVEL% == 1 (set m=1&set verb=Moving&goto execute)
IF %ERRORLEVEL% == 2 (set m=2&set verb=Copying&goto execute)
IF %ERRORLEVEL% == 3 goto begin
IF %ERRORLEVEL% == 4 exit
goto set3

:execute
cls
echo\
echo Migrating %ext% thumbnails to series root "%pth%"...
echo\
set foundthumb=
set /a founddest=0
for /r %%f in (*%ext%) do (
	echo Thumbnail file: %%~nxf
	SETLOCAL EnableDelayedExpansion
	set "tempf=%%~dpf"
	set "tempf=!tempf:~0,-1!"
	set ef=
	for %%P in ("!tempf!") do (
	ENDLOCAL
		echo Attempting to locate corresponding episode file...
		for %%g in ("%pth%\%%~nxP\*%%~nf*.mkv","%pth%\%%~nxP\*%%~nf*.avi","%pth%\%%~nxP\*%%~nf*.mp4","%pth%\%%~nxP\*%%~nf*.mpg","%pth%\%%~nxP\*%%~nf*.mpeg") do (
			echo Located: %%~nxg
			echo %verb% thumbnail...   Renaming thumbnail...
			if %m% == 1 (move "%%~ff" "%%~dpng.%ext%") else (copy "%%~ff" "%%~dpng.%ext%")
			echo Migration successful. Continuing...&echo ------------------------------------------ 
			set /a founddest=founddest+1
			set ef=1
		)
		if not defined ef echo  ***** Episode file not found. Continuing...&echo ------------------------------------------ 
		set foundthumb=1
	)
)
if not defined foundthumb echo\&echo No thumbnails with the extension %ext% were found.&echo:&pause>nul|set/p =Press any key to start over . . .&goto begin
if %founddest% == 0 echo\&echo Your thumbnails were parsed, but no valid episode files were found at the provided show path.&echo\&pause>nul|set/p =Press any key to start over . . .&goto begin

echo\&echo %verb% complete^! %founddest% thumbnails have been attached to their respective episodes.
echo\
 pause>nul|set/p =Press any key to exit . . .
