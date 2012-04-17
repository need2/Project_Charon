@ECHO OFF
TITLE Charon
COLOR 0c
SET fail=0
::Created by the GCM team::
::Lane Garland (aka need2)::

::Begin OS detection::
VER | find /i "Windows 95" > NUL
IF NOT ERRORLEVEL 1 GOTO UNSUPP

VER | find /i "Windows 98" > NUL
IF NOT ERRORLEVEL 1 GOTO UNSUPP

VER | find /i "Windows Millennium" > NUL
IF NOT ERRORLEVEL 1 GOTO UNSUPP

VER | find "2000" > NUL
IF %errorlevel% EQU 0 GOTO UNSUPP

VER | find "NT" > NUL
IF %errorlevel% EQU 0 GOTO UNSUPP

VER | find "XP" > NUL
IF %errorlevel% EQU 0 SET is_xp=1
IF %errorlevel% NEQ 0 SET /a fail=%fail%+1

VER | find "Vista" > NUL
IF %errorlevel% EQU 0 SET is_xp=0
IF %errorlevel% NEQ 0 SET /a fail=%fail%+1

VER | find "7" > NUL
IF %errorlevel% EQU 0 SET is_xp=0
IF %errorlevel% NEQ 0 SET /a fail=%fail%+1

IF %fail%==3 GOTO UNSUPP

GOTO TOOLBOX

:UNSUPP
ECHO OS Unsupported. The tools will not run for your safety.
PAUSE
GOTO :EOF

:TOOLBOX
::Toolbox main menu::
CLS
ECHO Welcome to the Charon Windows Multitool.
ECHO The following are tools for fixing various issues that can arise in Windows.
ECHO WARNING: I am not responsible for you breaking anything with this tool.
ECHO -----------------------------------------------------------------
ECHO.
ECHO.
ECHO 1. CD/DVD Drive registry fixer
ECHO 2. Reset HP Recovery Media creation software
ECHO 3. Start Windows Secure File Checker
ECHO 4. Create the SFC log for Vista and 7
ECHO 5. Mass DLL register/unregister
ECHO 6. Quit
SET menu_option=""
SET /p menu_option= Please select an option: 
IF %menu_option%==1 GOTO CD_REG_FIX
IF %menu_option%==2 GOTO HP_MEDIA
IF %menu_option%==3 GOTO SFC
IF %menu_option%==4 GOTO SFC_LOG
IF %menu_option%==5 GOTO DLL
IF %menu_option%==6 GOTO EOF
ECHO Not a valid option, please choose again.
GOTO TOOLBOX

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
IF %menu_option%==2 GOTO TOOLBOX
IF not %menu_option%==1 IF not %menu_option%==2 GOTO TOOLBOX

REG DELETE HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E965-E325-11CE-BFC1-08002BE10318} /v UpperFilters /f
REG DELETE HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E965-E325-11CE-BFC1-08002BE10318} /v LowerFilters /f
PAUSE
GOTO TOOLBOX

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
IF %menu_option%==2 GOTO TOOLBOX
IF NOT %menu_option%==1 IF NOT %menu_option%==2 GOTO TOOLBOX

MKDIR C:\recovery_temp
IF EXIST D:\hp\CDCreatorLog MOVE D:\hp\CDCreatorLog\*.* C:\recovery_temp
IF EXIST D:\RMCStatus.bin MOVE D:\RMCStatus.bin C:\recovery_temp
IF EXIST C:\Windows\System32\Rebecca.dat MOVE C:\Windows\System32\Rebecca.dat C:\recovery_temp
IF EXIST C:\Program Files (x86)\Hewlett-Packard\HP Recovery Manager\RMCStatus.bin MOVE C:\Program Files (x86)\Hewlett-Packard\HP Recovery Manager\RMCStatus.bin C:\recovery_temp
IF EXIST D:\HPCD.SYS MOVE D:\HPCD.SYS C:\recovery_temp
IF EXIST C:\Windows\SMINST\HPCD.SYS MOVE C:\Windows\SMINST\HPCD.SYS C:\recovery_temp
IF EXIST C:\ProgramData\Hewlett-Packard\Recovery\hpdrcu.prc MOVE C:\ProgramData\Hewlett-Packard\Recovery\hpdrcu.prc C:\recovery_temp
IF EXIST D:\hpdrcu.prc MOVE D:\hpdrcu.prc C:\recovery_temp
ECHO Files moved... you can delete C:\recovery_temp if you don't want
ECHO backups of removed files.
PAUSE
GOTO TOOLBOX

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
IF %menu_option%==2 GOTO TOOLBOX
IF NOT %menu_option%==1 IF NOT %menu_option%==2 GOTO TOOLBOX

IF %is_xp%==1 START START sfc.exe /scannow
IF %is_xp%==0 START sfc /scannow
GOTO TOOLBOX

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
IF %menu_option%==2 GOTO TOOLBOX
IF NOT %menu_option%==1 IF NOT %menu_option%==2 GOTO TOOLBOX

IF %is_xp%==1 GOTO TOOLBOX
FINDSTR /c:"[SR]" %windir%\Logs\CBS\CBS.log >%userprofile%\Desktop\sfcdetails.txt
GOTO TOOLBOX

:DLL
::DLL mass register / unregister::
CLS
ECHO The directable DLL bomber will go here.
ECHO This will be a tool that will register or unregister EVERY DLL in the selected
ECHO folder.
ECHO.
ECHO Do you want to run this tool?
ECHO 1. Yes
ECHO 2. No
SET menu_option=""
SET /p menu_option= Select an option: 
IF %menu_option%==1 ECHO Running...
IF %menu_option%==2 GOTO TOOLBOX
IF NOT %menu_option%==1 IF NOT %menu_option%==2 GOTO TOOLBOX

:DLL_MENU
SET /p target= Please enter the full path to the folder containing the .DLL files: 
IF NOT EXIST %target% ECHO Location does not exist! Try again.
IF NOT EXIST %target% GOTO DLL_MENU
SET /p state= Please either select (u)nregister or (r)egister: 
IF NOT %state%==u IF NOT %state%==r ECHO Not an available option (%state%). Please select 'u' or 'r'.
IF NOT %state%==u IF NOT %state%==r GOTO DLL_MENU
SET /p info= Would you like to view the confirmation dialog windows? (Type 1 for yes): 

IF NOT %info%==1 FOR %%i in (%target%\*.dll) do regsvr32 /%state% /s %%i
IF %info%==1 FOR %%i in (%target%\*.dll) do regsvr32 /%state% %%i
PAUSE
GOTO TOOLBOX

:EOF
EXIT