@echo off
:: Script invokes FZF.exe in Windows friendly way and then either just echoes
:: a selected command or alternatively executes the command if '-r' option was given.

:: Path to the directory containing all the .cheat files.
:: Defaults to the cheats directory inside repo. Change if needed.
set CHEATDIR="%~dp0/cheats"

:: Function piping needs this (explained at the bottom of the file).
:jump
    set "LABEL=%~1_"
    if "%LABEL:~0,1%"==":" SHIFT /1 & goto %LABEL:~0,-1%

:check_args
    set "EXECUTE="
    if [%1]==[] goto :main
    if "%~1"=="-r" set EXECUTE=1
    if "%~1"=="-h" goto show_help
    if "%~1"=="-v" goto show_version

:main
    :: select a cheat-file
    call :fzfselect
    :: pipe file contents to FZF and select a command
    type %CHEAT% | call "%~f0" :fzfrun
    exit /B %ERRORLEVEL%

:: Select a cheat sheet
:fzfselect
    set CWD=%cd%
    cd %CHEATDIR%
    for /f "usebackq delims=" %%i in (`fzf`) do set CHEAT=%%~fi
    cd %CWD%
    exit /b

:: Call or echo the selected command
:fzfrun
    set SELECTION=""
    for /f "usebackq delims=" %%i in (`fzf`) do set SELECTION=%%~i
    if defined %SELECTION% (
        if "%EXECUTE%"=="" ( echo Command: %SELECTION% ) else ( %SELECTION% )
    )
    exit /b

:show_version
    echo Version: 0.01
    exit /b

:: Prints the help text
:show_help
    echo USAGE: select.bat [option]
    echo:
    echo OPTIONS:
    echo  -r        "Run the selected command"
    echo  -h        "Print the help text..."
    echo  -v        "Show version number"
    exit /b

@echo on


:: Details:
:: There is a little trick in the code that may need some clarification.
:: The :jump is intentionally placed at the top and it does not have
:: an exit. The code inside is always executed. Jump does nothing
:: on the first call, but when the script is restarted right after the pipe
:: call ("%~f0"), the second instance instantly jumps to a function instead
:: of running the main again. This allows us to pipe the file contents to FZF
:: directly from single script file. Without the trick, the function name
:: would be interpreted as a cmd-argument instead of going to the function.
