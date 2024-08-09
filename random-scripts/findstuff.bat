@echo off

:start
set "param="
set "case="
set "caseparam="
set "filename="
echo What to find? (Regex)
echo   Note: Please escape manually both linux and windows, [0;4mlinux first[0m.
echo   Example: [93ma^|b[0m ^-^> [93ma^\^|b[0m ^-^> [93ma^^^\^^^|b[0m
echo | set /p="[Escaped Regex]: [96m"
set /p find=
echo [0m

:choosetype
echo | set /p="What filetype? (Leave empty to skip): [96m"
set /p filter= || goto endchoosetype
echo [0m

set param=%param% --include=""*\.%filter%""
goto choosetype

:endchoosetype
echo [0m
echo | set /p="Case Sensitive? (n/Y): [96m"
set /p case= || set "case=n"
echo [0m

if not %case%==Y set "caseparam= -i"

echo | set /p="Output result to filename? (Leave empty for output to STDOUT): [96m"
set /p filename= || goto noout
echo [0m
goto out


:noout
echo [0m
bash -c 'grep -Ern %caseparam% --color=always %param% ""%find%"" ./mods'
goto end

:out 
bash -c 'grep -Ern %caseparam% %param% ""%find%"" ./mods' > %filename%
echo Saved file to %~dp0%filename%
goto end 

:end
echo =============================================================
echo.
goto start