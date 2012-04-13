@ECHO OFF
TITLE Deathbat!
COLOR 0c

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
IF %errorlevel% EQU 0 SET Is_xp=1

VER | find "Vista" > nul
IF %errorlevel% EQU 0 SET Is_xp=0

VER | find "7" > nul
IF %errorlevel% EQU 0 SET Is_xp=0

IF %errorlevel% NEQ 0 GOTO UNSUPP

GOTO toolbox

:UNSUPP
ECHO OS Unsupported. The tools will not run for your safety.
PAUSE
GOTO :eof

:toolbox
::Toolbox main menu::
CLS
ECHO Welcome to the Deathbat Windows Multitool.
ECHO The following are tools for fixing various issues that can arise in Windows.
ECHO WARNING: I am not responsible for you breaking anything with this tool.
ECHO -----------------------------------------------------------------
ECHO.
ECHO.
ECHO 1. CD/DVD Drive registry fixer
ECHO 2. Reset HP Recovery Media creation software
ECHO 3. Start Windows Secure File Checker
ECHO 4. Create the SFC log for Vista and 7
ECHO 5. Quit
SET menu_option=""
SET /p menu_option= Please select an option: 
IF %menu_option%==1 GOTO CD_REG_FIX
IF %menu_option%==2 GOTO HP_MEDIA
IF %menu_option%==3 GOTO SFC
IF %menu_option%==4 GOTO SFC_LOG
IF %menu_option%==5 GOTO EOF
ECHO Not a valid option, please choose again.
GOTO toolbox

:CD_REG_FIX
::cd/dvd reg fix tool::
CLS
ECHO This tool will remove the registry keys responsible for causing Windows
ECHO to fail to load the drivers for CD and DVD drives. No side effects known.
ECHO Restart or enable/disable drive to see the results.
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
PAUSE
GOTO toolbox

:HP_MEDIA
::HP recovery media creation reset tool::
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
PAUSE
GOTO toolbox

:SFC
::Windows Secure File Checker helper tool::
CLS
ECHO This tool will start the Windows Secure File Checker for your OS.
ECHO This will verify that various critical Windows files are in their
ECHO original state, unmodified and unmoved. If they are changed it will
ECHO try to replace the damaged file with a clean copy. XP may prompt for
ECHO your install disc.
ECHO.
ECHO Do you want to run this tool?
ECHO 1. Yes
ECHO 2. No
SET menu_option=""
SET /p menu_option= Select an option: 
IF %menu_option%==1 ECHO Running...
IF %menu_option%==2 GOTO toolbox
IF not %menu_option%==1 IF not %menu_option%==2 GOTO toolbox

IF %Is_xp%==1 START START sfc.exe /scannow
IF %Is_xp%==0 START sfc /scannow
GOTO toolbox

:SFC_LOG
::Retrieve the SFC log in Vista and 7::
CLS
ECHO This will retrieve the SFC log for Windows Vista and Windows 7
ECHO and place it in a text file on the current user's desktop. This
ECHO log is useful for reviewing files that were repaired or not
ECHO repairable.
ECHO NOTE: Does not work in XP. Your SFC log is in your Event Viewer.
ECHO.
ECHO Do you want to run this tool?
ECHO 1. Yes
ECHO 2. No
SET menu_option=""
SET /p menu_option= Select an option: 
IF %menu_option%==1 ECHO Running...
IF %menu_option%==2 GOTO toolbox
IF not %menu_option%==1 IF not %menu_option%==2 GOTO toolbox

IF %Is_xp%==1 GOTO toolbox
findstr /c:"[SR]" %windir%\Logs\CBS\CBS.log >%userprofile%\Desktop\sfcdetails.txt
GOTO toolbox

:EOF
exit