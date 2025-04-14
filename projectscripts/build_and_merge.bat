@echo off
setlocal enabledelayedexpansion

if not exist "variables.bat" (
    copy .variables.structure.bat variables.bat
    echo variables.bat created. Please fill in all of the empty variables, then rerun this script.
    pause
	exit
)
call variables.bat

set empty_variables=true
if not "%EV_PROJECT_PATH%"=="" if not "%UNDERTALEMODCLI_PATH%"=="" if not "%VOID_STRANGER_PATH%"=="" if not "%GAMEMAKER_CACHE_PATH%"=="" if not "%LICENSE_FILE_PATH%"=="" (
	set empty_variables=false
)
if %empty_variables%==true (
	echo Some variables are empty. Please fill in all of the variables.
	pause
	exit
)

cd "%EV_PROJECT_PATH%\projectscripts"


if not exist "%VOID_STRANGER_PATH%\clean_data.win" (
	echo First run detected. Please make sure the data.win in "%VOID_STRANGER_PATH%" is not modified.

	set /P "USER_ANSWER=Continue? (y/n) "
	
	if /i "!USER_ANSWER!"=="Y" (
		echo I believe you... Copying clean_data.win
		copy "%VOID_STRANGER_PATH%\data.win" "%VOID_STRANGER_PATH%\clean_data.win"
	)
)

set IGOR_PATH=%GAMEMAKER_CACHE_PATH%\runtimes\runtime-2023.4.0.113\bin\igor\windows\x64\Igor.exe
set RUNTIME_PATH=%GAMEMAKER_CACHE_PATH%\runtimes\runtime-2023.4.0.113

if exist "data.win" (
	echo Removing old data.win
	del "data.win"
)

echo -------------------------------
echo Building EV's GameMaker project
echo -------------------------------

"%IGOR_PATH%" ^
/lf="%LICENSE_FILE_PATH%" ^
/project="%EV_PROJECT_PATH%\void-stranger-endless-void.yyp" ^
/config="NoVoidStrangerGroups" ^
/rp="%RUNTIME_PATH%" ^
/tf="void-stranger-endless-void.zip" ^
-- Windows PackageZip

if not exist ".\output\void-stranger-endless-void\data.win" (
	echo Something failed. Could not find data.win.
	pause
	exit
)
echo Building finished.
copy .\output\void-stranger-endless-void\data.win .\data.win

echo Removing output folder and zip
rmdir /s /q ".\output" 
if exist ".\void-stranger-endless-void.zip" (
	del ".\void-stranger-endless-void.zip"
)

echo --------------------------
echo Merging into Void Stranger
echo --------------------------


:: https://github.com/UnderminersTeam/UndertaleModTool/pull/2063
del "%VOID_STRANGER_PATH%\data.win"

%UNDERTALEMODCLI_PATH% load "%VOID_STRANGER_PATH%\clean_data.win" --scripts ".\csx\merger.csx" --output "%VOID_STRANGER_PATH%\data.win"

echo All done!