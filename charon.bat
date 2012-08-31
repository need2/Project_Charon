@ECHO OFF
TITLE Charon v0.5.2
COLOR 0c
::Created by the GCM team::
::Lane Garland (aka need2)::
::Tom B (aka r3l0ad)::
::Revision 0.5.2::

::Begin OS detection::
::Set default value. If OS is not found, then we don't support it!::
SET det_os=unsupp

ver | findstr /i "5\.1\." > nul
IF %ERRORLEVEL% EQU 0 (
	SET det_os=xp
	GOTO TOOLBOX
)

ver | findstr /i "6\.0\." > nul
IF %ERRORLEVEL% EQU 0 SET det_os=vista

ver | findstr /i "6\.1\." > nul
IF %ERRORLEVEL% EQU 0 SET det_os=7

ver | findstr /i "6\.2\." > nul
IF %ERRORLEVEL% EQU 0 SET det_os=8

IF %det_os%==unsupp (
	GOTO UNSUPP
) ELSE (
	GOTO ELEVATE
)

:UNSUPP
::Report unsupported OS::
ECHO OS Unsupported. The tools will not run for your safety.
ECHO If you believe this is wrong, or know that these tools are
ECHO safe in your OS, please create an issue report at:
ECHO https://github.com/need2/Project_Charon
PAUSE
GOTO :EOF

:ELEVATE
::Begin admin check::
>NUL 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

::If error flag is not zero, charon does not have admin rights::
IF %errorlevel% NEQ 0 (
    ECHO Requesting administrative privileges, please allow or this tool cannot run.
    GOTO UACPROMPT
) ELSE ( GOTO GOTADMIN )

:UACPROMPT
::Creates a temporary script to request administrative rights for a new instance of charon::
ECHO SET UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
ECHO UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
EXIT /B

:GOTADMIN
::Cleanup after temporary script::
IF EXIST "%temp%\getadmin.vbs" DEL "%temp%\getadmin.vbs"
PUSHD "%CD%"
CD /D "%~dp0"

:TOOLBOX
::Toolbox main menu::
CLS
ECHO Welcome to the Charon Windows Multitool.
ECHO The following are tools for fixing various issues that can arise in Windows.
ECHO WARNING: I am not responsible for you breaking anything with this tool.
ECHO ----------------------------------------------------------------------------
ECHO.
ECHO.
ECHO 1. CD/DVD Drive registry fixer
ECHO 2. Reset HP Recovery Media creation software (SFC)
ECHO 3. Start Windows Secure File Checker
ECHO 4. Create the SFC log for Vista and 7
ECHO 5. Mass DLL register/unregister
ECHO 6. UNHIDE
ECHO 7. Quit
ECHO.
SET menu_option=""
SET /p menu_option= Please select an option: 
IF %menu_option%==1 GOTO CD_REG_FIX
IF %menu_option%==2 GOTO HP_MEDIA
IF %menu_option%==3 GOTO SFC
IF %menu_option%==4 GOTO SFC_LOG
IF %menu_option%==5 GOTO DLL
IF %menu_option%==6 GOTO UNHIDE
IF %menu_option%==7 GOTO EOF
ECHO Not a valid option, please choose again.
GOTO TOOLBOX

:CD_REG_FIX
::cd/dvd reg fix tool::
CLS
ECHO This tool will remove the registry keys responsible for causing Windows
ECHO to fail to load the drivers for CD and DVD drives. No side effects known.
ECHO Restart or disable then enable the drive to see the results.
ECHO.
ECHO Do you want to run this tool?
ECHO 1. Yes
ECHO 2. No
ECHO.
SET menu_option=""
SET /p menu_option= Select an option: 
IF %menu_option%==1 ECHO Running...
IF %menu_option%==2 GOTO TOOLBOX
IF NOT %menu_option%==1 IF NOT %menu_option%==2 GOTO TOOLBOX

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
ECHO.
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
ECHO your install disc. This can also undo some changes made by third
ECHO party OS mods.
ECHO.
ECHO Do you want to run this tool?
ECHO 1. Yes
ECHO 2. No
ECHO.
SET menu_option=""
SET /p menu_option= Select an option: 
IF %menu_option%==1 ECHO Running...
IF %menu_option%==2 GOTO TOOLBOX
IF NOT %menu_option%==1 IF NOT %menu_option%==2 GOTO TOOLBOX

IF %det_os%==xp START sfc.exe /scannow
IF NOT %det_os%==xp START sfc /scannow
GOTO TOOLBOX

:SFC_LOG
::Retrieve the SFC log in Vista and 7::
CLS
ECHO This will retrieve the SFC log for Windows Vista and Windows 7 and
ECHO place it in a text file on the current user's desktop. This log is
ECHO useful for reviewing files that were repaired or not repairable.
ECHO NOTE: Does not work in XP. Your SFC log is in your Event Viewer.
ECHO.
ECHO Do you want to run this tool?
ECHO 1. Yes
ECHO 2. No
ECHO.
SET menu_option=""
SET /p menu_option= Select an option: 
IF %menu_option%==1 ECHO Running...
IF %menu_option%==2 GOTO TOOLBOX
IF NOT %menu_option%==1 IF NOT %menu_option%==2 GOTO TOOLBOX

IF %det_os%==xp GOTO TOOLBOX
FINDSTR /c:"[SR]" %windir%\Logs\CBS\CBS.log >%userprofile%\Desktop\sfcdetails.txt
GOTO TOOLBOX

:DLL
::DLL mass register / unregister::
CLS
ECHO This will register or unregister EVERY .dll in the folder you select.
ECHO This is useful for manually removing or repairing programs. Do NOT
ECHO use this unless you know what you are doing! You can break your OS.
ECHO.
ECHO Do you want to run this tool?
ECHO 1. Yes
ECHO 2. No
ECHO.
SET menu_option=""
SET /p menu_option= Select an option: 
IF %menu_option%==1 ECHO Running...
IF %menu_option%==2 GOTO TOOLBOX
IF NOT %menu_option%==1 IF NOT %menu_option%==2 GOTO TOOLBOX

:DLL_MENU_A
SET /p target= Please enter the full path to the folder containing the .DLL files: 
IF NOT EXIST %target% ECHO Location does not exist! Try again.
IF NOT EXIST %target% GOTO DLL_MENU_A
:DLL_MENU_B
SET /p state= Please either select (u)nregister or (r)egister: 
IF NOT %state%==u IF NOT %state%==r ECHO Not an available option (%state%). Please select 'u' or 'r'.
IF NOT %state%==u IF NOT %state%==r GOTO DLL_MENU_B

IF %state%==r FOR %%i in (%target%\*.dll) do regsvr32 %%i
IF %state%==u FOR %%i in (%target%\*.dll) do regsvr32 /u %%i
PAUSE
GOTO TOOLBOX

:UNHIDE
::Staging
::Appears to have an issue accessing various Windows and Program Files folders. Usually the virus
::that hides the user's files only target the actual native user folders. Perhaps make this targetable,
::and/or smart-targetting only current user. Would also save processing time. Even better would be to identify
::if the virus only targets completely native folders, or ALL folders in the user file.
CLS
ECHO TODO.
ECHO Mass file unhide script to be implimented here.
ECHO.
PAUSE
::Intended to unhide all files on a hard drive. Useful to clean up after some nasty viruses.
ECHO NOT Running, please wait. This will take some time.
::ATTRIB C:\* /d /s -h -s
ECHO Complete.
PAUSE
GOTO TOOLBOX

:EOF
EXIT