@echo off
rem SETLOCAL ENABLEDELAYEDEXPANSION
:start
cls
echo.
set "debug=N"
echo | set /p="Use Public Test Realm (PTR)? (n/Y): [96m"
set /p isPTR= || set "isPTR=n"
echo [0m
rem set /p isPTR="Use Public Test Realm (PTR)? (n/Y): " || set "isPTR=n"
if %isPTR%==Y (set "ptrname= PUBLIC TEST REALM") else (set "ptrname=")
if %isPTR%==Y (set "ptrnameout=PTR") else (set "ptrnameout=")
if %isPTR%==Y (set "ptrpathescape=\ Public\ Test") else (set "ptrpathescape=")
if %isPTR%==Y (set "ptrpath= Public Test") else (set "ptrpathescape=")
cls
set outputDirNamePrefix=Heroes%ptrnameout%Snapshot
set outputDirNameDataOnlySuffix=_Data
set outputname=GameFiles
rem "sed -n '2p' ^< ^"C:/Program Files/Heroes of the Storm%ptrpath%/.build.info^" ^| cut -d "^|" -f13"
FOR /F "tokens=*" %%a in ('sed "2p" "C:/Program Files/Heroes of the Storm%ptrpath%/.build.info" ^| cut -d "|" -f13') do SET version=%%a
echo.
echo    HEROES OF THE STORM%ptrname% VERSION: [35m%version%[0m
echo.
echo    Please Enter a [94;1;4mDISTINCT[0m output folder name to be used in current directory.
echo    Since this script have no ant exception handling or whatsoever. Please make sure
echo    the folder name is indeed valid on both windows and linux system (no special
echo    characters) as well as it is not exist on the current directory yet. (will be
echo    created later on)	   

echo.

echo | set /p="Output Folder Name: [96m"
set /p outputname= || echo [0mFolder name set to default: [96m%outputname%[0m
echo [0m

rem set /p outputname="Output Folder Name: " || echo Folder name set to default: [96m%outputname%[0m

set outputdir=%outputDirNamePrefix%_%version%_%outputname%
set outputdirDataOnly=%outputdir%%outputDirNameDataOnlySuffix%

if exist %~dp0%outputdir% (
	if %debug%==Y (set verbose="Y")
	if %debug%==Y (goto debug)
	echo.
	echo [91mError:[0m
	echo Folder "[96m%~dp0%outputdir%[0m" Exists.
	echo Please delete it or change the Output Folder Name.
	echo.
	pause
	goto start
)

if exist %~dp0%outputdirDataOnly% (
	if %debug%==Y (set verbose="Y")
	if %debug%==Y (goto debug)
	echo.
	echo [91mError:[0m
	echo Folder "[96m%~dp0%outputdirDataOnly%[0m" Exists.
	echo Please delete it or change the Output Folder Name.
	echo.
	pause
	goto start
)

echo.

echo | set /p="Do you want verbosity? This can make the process slower (n/Y): [96m"
set /p verbose= || set "verbose=n"
echo [0m
echo | set /p="Shutdown the Computer if extraction completed? (n/Y): [96m"
set /p shutdownComplete= || set "shutdownComplete=n"
echo [0m
rem set /p verbose="Do you want verbosity? This can make the process slower (n/Y): " || set "verbose=n"

if %debug%==Y (goto debug)

echo.

echo Extracting Data files to "%~dp0%outputdirDataOnly%" It will take a decent of time (~ 30 minutes)
echo ================================

if "%verbose%"=="Y" (set param="-v") else (set param="-q")
echo Extracting *.xml (1/9)
bash -c "storm-extract %param% -i '/mnt/c/Program Files/Heroes of the Storm%ptrpath%/HeroesData' -o '%outputdirDataOnly%' -t xml -x"
echo Extracting *.txt (2/9)
bash -c "storm-extract %param% -i '/mnt/c/Program Files/Heroes of the Storm%ptrpath%/HeroesData' -o '%outputdirDataOnly%' -t txt -x"
echo Extracting *.galaxy (3/9)
bash -c "storm-extract %param% -i '/mnt/c/Program Files/Heroes of the Storm%ptrpath%/HeroesData' -o '%outputdirDataOnly%' -t galaxy -x"
echo Extracting *.StormLayout (4/9)
bash -c "storm-extract %param% -i '/mnt/c/Program Files/Heroes of the Storm%ptrpath%/HeroesData' -o '%outputdirDataOnly%' -t StormLayout -x"
echo Extracting *.StormHotkeys (5/9)
bash -c "storm-extract %param% -i '/mnt/c/Program Files/Heroes of the Storm%ptrpath%/HeroesData' -o '%outputdirDataOnly%' -t StormHotkeys -x"
echo Extracting *.StormStyle (6/9)
bash -c "storm-extract %param% -i '/mnt/c/Program Files/Heroes of the Storm%ptrpath%/HeroesData' -o '%outputdirDataOnly%' -t StormStyle -x"
echo Extracting *.StormCutscene (7/9)
bash -c "storm-extract %param% -i '/mnt/c/Program Files/Heroes of the Storm%ptrpath%/HeroesData' -o '%outputdirDataOnly%' -t StormCutscene -x"
echo Extracting *.StormComponents (8/9)
bash -c "storm-extract %param% -i '/mnt/c/Program Files/Heroes of the Storm%ptrpath%/HeroesData' -o '%outputdirDataOnly%' -t StormComponents -x"
echo Extracting *.StormLocale (9/9)
bash -c "storm-extract %param% -i '/mnt/c/Program Files/Heroes of the Storm%ptrpath%/HeroesData' -o '%outputdirDataOnly%' -t StormLocale -x"
if not %errorlevel%==0 goto error
:debug

echo ====================================
echo Heroes Snapshot Generation Completed
echo.
echo Snapshot Data Location: %~dp0%outputdirDataOnly%
echo=====================================
if "%shutdownComplete%"=="Y" (shutdown /s /t 0) else (pause)
@echo on
exit /B 0

:error
echo [91mScript End with error. Error code (%errorlevel%)[0m
pause
@echo on
exit /B 1