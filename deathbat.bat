@ECHO OFF
TITLE Deathbat!
COLOR 0b
:TOP

::Begin OS detection::

VER | find /i "Windows 95" >NUL
IF NOT ERRORLEVEL 1 GOTO UNSUPP

VER | find /i "Windows 98" >NUL
IF NOT ERRORLEVEL 1 GOTO UNSUPP

VER | find /i "Windows Millennium" >NUL
IF NOT ERRORLEVEL 1 GOTO UNSUPP

VER | find "2000" > nul
IF %errorlevel% EQU 0 GOTO UNSUPP

VER | find "NT" > nul
IF %errorlevel% EQU 0 GOTO UNSUPP

VER | find "XP" > nul
IF %errorlevel% EQU 0 GOTO toolbox

VER | find "Vista" > nul
IF %errorlevel% EQU 0 GOTO toolbox

VER | find "7" > nul
IF %errorlevel% EQU 0 GOTO toolbox

::Detection failure::
ECHO Unknown OS! The tool will now close.
PAUSE
GOTO :EOF

:UNSUPP
ECHO OS Unsupported. The tools will not run for your safety.
PAUSE
GOTO :eof

::Begin area that tools will be chosen::
:toolbox
CLS
ECHO Welcome to the Deathbat Windows Multitool.
ECHO The following are tools for fixing various issues that can arise in Windows.
ECHO WARNING: I am not responsible for you breaking anything with this tool.
ECHO -----------------------------------------------------------------
ECHO.
ECHO.
ECHO 1. CD/DVD Drive registry fixer
ECHO 2. Reset HP Recovery Media creation software
ECHO 3. Quit
SET menu_option=""
SET /p menu_option= Please select an option: 
IF %menu_option%==1 GOTO CD_REG_FIX
IF %menu_option%==2 GOTO HP_MEDIA
IF %menu_option%==3 GOTO EOF
ECHO Not a valid option, please choose again.
GOTO toolbox

:CD_REG_FIX
CLS
ECHO This tool will remove the registry keys responsible for causing Windows
ECHO to fail to load the drivers for CD and DVD drives. No side effects known.
ECHO Restart to enable/disable drive to see the results.
ECHO.
ECHO Do you want to run this tool?
ECHO 1. Yes
ECHO 2. No
SET menu_option=""
SET /p menu_option= Select an option: 
IF %menu_option%==1 ECHO Running...
IF %menu_option%==2 GOTO toolbox
IF not %menu_option%==1 IF not %menu_option%==2 GOTO toolbox

REG DELETE HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E965-E325-11CE-BFC1-08002BE10318} /v UpperFilters /f
REG DELETE HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E965-E325-11CE-BFC1-08002BE10318} /v LowerFilters /f
GOTO toolbox

:HP_MEDIA
CLS
ECHO This tool will reset the HP Recovery Media Creator program to its
ECHO default state, allowing you to make additional sets of recovery
ECHO discs.
ECHO.
ECHO Do you want to run this tool?
ECHO 1. Yes
ECHO 2. No
SET menu_option=""
SET /p menu_option= Select an option: 
IF %menu_option%==1 ECHO Running...
IF %menu_option%==2 GOTO toolbox
IF not %menu_option%==1 IF not %menu_option%==2 GOTO toolbox

mkdir C:\recovery_temp
move D:\hp\CDCreatorLog\*.* C:\recovery_temp
GOTO toolbox

:EOF
exit