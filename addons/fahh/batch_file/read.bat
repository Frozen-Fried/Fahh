@echo off
setlocal

if "%~1"=="" (
    echo Usage:
    echo   read_godot_log.bat "C:\Path\To\Godot\logs"
    exit /b 1
)

set "LOG_DIR=%~1"

set "INPUT_FILE=%LOG_DIR%\godot.log"
set "OUTPUT_FILE=%LOG_DIR%\godot_fahh.txt"

if not exist "%INPUT_FILE%" (
    echo File not found:
    echo   %INPUT_FILE%
    exit /b 1
)

copy /y "%INPUT_FILE%" "%OUTPUT_FILE%" >nul

if exist "%OUTPUT_FILE%" (
    echo Log copied successfully:
    echo   %OUTPUT_FILE%
) else (
    echo Failed to copy log.
)

endlocal