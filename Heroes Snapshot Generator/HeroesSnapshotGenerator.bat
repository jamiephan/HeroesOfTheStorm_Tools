@echo off
rem SETLOCAL ENABLEDELAYEDEXPANSION
:start
cls
echo.
set "debug=n"
echo | set /p="Use Public Test Realm (PTR)? (N/y): [96m"
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

echo | set /p="Generate XML Schema? This will generate a .xsd file (Y/n): [96m"
set /p generatexsd= || set "generatexsd=Y"
echo [0m

echo | set /p="Do you want verbosity? This can make the process slower (N/y): [96m"
set /p verbose= || set "verbose=n"
echo [0m

echo | set /p="Shutdown the Computer if extraction completed? (N/y): [96m"
set /p shutdownComplete= || set "shutdownComplete=n"
echo [0m


rem set /p verbose="Do you want verbosity? This can make the process slower (n/Y): " || set "verbose=n"

if %debug%==Y (goto debug)

echo.

echo Extracting ALL files to "%~dp0%outputdir%" It will take a LONG time (~ 2 - 3 hrs)
echo ================================

if "%verbose%"=="Y" (set param="-v") else (set param="-q")
bash -c "storm-extract %param% -i '/mnt/c/Program Files/Heroes of the Storm%ptrpath%/HeroesData' -o '%outputdir%' -x"
if not %errorlevel%==0 goto error
rem :debug

echo Extracting DATA-ONLY files to "%~dp0%outputdirDataOnly%" It will take a decent amount of time (~ 10 - 15min)
echo ================================

if "%verbose%"=="Y" (set param="--verbose") else (set "param=")
bash -c "mkdir '%outputdirDataOnly%'"
if not %errorlevel%==0 goto error
bash -c "find '%outputdir%' -type f \( -iname \*.xml -o -iname \*.txt -o -iname \*.galaxy -o -iname \*.storm* \) -exec cp %param% --parents {} '%outputdirDataOnly%' \;"
if not %errorlevel%==0 goto error

echo Moving Data Files One Level Up
echo ================================
if "%verbose%"=="Y" (set param="-v") else (set "param=")
rem Note /* is outside of '' below: 
bash -c "mv %param% '%outputdirDataOnly%/%outputdir%/'/* %outputdirDataOnly%"
if not %errorlevel%==0 goto error

bash -c "rmdir %param% '%outputdirDataOnly%/%outputdir%/'"
if not %errorlevel%==0 goto error
rem bash -c "mv %param% '%outputdirDataOnly%${PWD}/%outputdir%/*' '%outputdirDataOnly%'"
rem pause
rem if %verbose%==Y (set param="-v") else (set "param=")

rem bash -c "find '%outputdirDataOnly%' -maxdepth 1 -type d -not -wholename '%outputdirDataOnly%/mods\*' -not -wholename '%outputdirDataOnly%' -not -name '.' -exec rm %param% -rf '{}';"

if "%generatexsd%"=="Y" (
	:debug
	echo ====================================
	echo Generating XSD file
	echo ====================================
	copy schemaGenerator.sh %outputdirDataOnly%
	pushd %outputdirDataOnly%
	bash -c "./schemaGenerator.sh"
	del "schemaGenerator.sh"
	popd
)

echo ====================================
echo Heroes Snapshot Generation Completed
echo.
echo Snapshot Location: %~dp0%outputdir%
echo Snapshot Data Location: %~dp0%outputdirDataOnly%
echo=====================================
if "%shutdownComplete%"=="Y" (shutdown /s /t 0) else (pause)
@echo on
exit 0

:error
echo [91mScript End with error. Error code (%errorlevel%)[0m
pause
@echo on
exit 1