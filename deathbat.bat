@ECHO OFF
TITLE Deathbat!
COLOR 0b
:TOP

:: Win9x checks ::

VER | find /i "Windows 95" >NUL
IF NOT ERRORLEVEL 1 GOTO W9598ME

VER | find /i "Windows 98" >NUL
IF NOT ERRORLEVEL 1 GOTO W9598ME

VER | find /i "Windows Millennium" >NUL
IF NOT ERRORLEVEL 1 GOTO W9598ME

:: NT/XP checks ::
VER | find "XP" > nul
IF %errorlevel% EQU 0 GOTO s_win_XP

VER | find "2000" > nul
IF %errorlevel% EQU 0 GOTO s_win_2000

VER | find "NT" > nul
IF %errorlevel% EQU 0 GOTO s_win_NT

:: Vista/7 Checks::
VER | find "Vista" > nul
IF %errorlevel% EQU 0 GOTO s_win_vista

VER | find "7" > nul
IF %errorlevel% EQU 0 GOTO s_win_7

::Detection failure::
ECHO Unknown OS !
PAUSE
GOTO :EOF

:: Win9x commands ::

:W9598ME
ECHO OS Unsupported.
PAUSE
GOTO :EOF

:W98
ECHO OS Unsupported.
PAUSE
GOTO :EOF

:: NT/XP commands ::

:s_win_XP
ECHO You have XP
PAUSE
goto :eof

:s_win_2000
ECHO You have Windows 2000
PAUSE
goto :eof

:s_win_NT
ECHO NT!
PAUSE
goto :eof

:s_win_vista
ECHO You have Vista
PAUSE
goto :eof

:s_win_7
ECHO You have Windows 7
PAUSE
goto :eof

:EOF
exit