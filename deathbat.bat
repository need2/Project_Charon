@ECHO OFF
TITLE Deathbat!
COLOR 0b
:TOP

::Begin OS detection::

VER | find /i "Windows 95" >NUL
IF NOT ERRORLEVEL 1 GOTO W9598ME

VER | find /i "Windows 98" >NUL
IF NOT ERRORLEVEL 1 GOTO W9598ME

VER | find /i "Windows Millennium" >NUL
IF NOT ERRORLEVEL 1 GOTO W9598ME

VER | find "XP" > nul
IF %errorlevel% EQU 0 GOTO s_win_XP

VER | find "2000" > nul
IF %errorlevel% EQU 0 GOTO s_win_2000

VER | find "NT" > nul
IF %errorlevel% EQU 0 GOTO s_win_NT

VER | find "Vista" > nul
IF %errorlevel% EQU 0 GOTO s_win_vista

VER | find "7" > nul
IF %errorlevel% EQU 0 GOTO s_win_7

::Detection failure::
ECHO Unknown OS !
PAUSE
GOTO :EOF

:: Begin OS report and decide if tool can function::

:W9598ME
ECHO OS Unsupported. The tools will not run for your
ECHO safety.
PAUSE
GOTO :eof

:s_win_XP
ECHO You have XP
PAUSE
goto :toolbox

:s_win_2000
ECHO You have Windows 2000
PAUSE
goto :toolbox

:s_win_NT
ECHO NT!
PAUSE
goto :toolbox

:s_win_vista
ECHO You have Vista
PAUSE
goto :toolbox

:s_win_7
ECHO You have Windows 7
PAUSE
goto :toolbox

:toolbox
::Begin area that tools will be chosen::
ECHO Info will go here!
ECHO Options will go here!
ECHO Tools will go here!
PAUSE
goto :eof

:EOF
exit