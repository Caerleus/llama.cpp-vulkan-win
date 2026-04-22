@echo off
setlocal ENABLEDELAYEDEXPANSION

:: ============================================================
:: llama.cpp Vulkan Launcher (Interactive Menu)
:: Author: Caerleus
:: Description:
::   Allows the user to select a GGUF model and choose between
::   CPU, GPU0, GPU1, or Multi‑GPU Vulkan execution.
::   Uses only relative paths (safe for GitHub).
:: ============================================================

:: Base directory (folder where this script is located)
set BASE_DIR=%~dp0

:: llama.cpp binary
set LLAMA_BIN=%BASE_DIR%llama-server.exe

:: Models directory
set MODEL_DIR=%BASE_DIR%models

:: Create models folder if missing
if not exist "%MODEL_DIR%" mkdir "%MODEL_DIR%"

echo ============================================================
echo   llama.cpp Vulkan Launcher - Dual RX 580 Edition
echo ============================================================
echo.

:: ------------------------------------------------------------
:: 1) MODEL SELECTION
:: ------------------------------------------------------------
echo Available models:
echo.

set /a index=0
for %%f in ("%MODEL_DIR%\*.gguf") do (
    set /a index+=1
    set "model[!index!]=%%f"
    echo   !index!) %%~nxf
)

if %index%==0 (
    echo No GGUF models found in the "models" folder.
    echo Please place your .gguf files inside:
    echo   %MODEL_DIR%
    pause
    exit /b
)

echo.
set /p MODEL_CHOICE=Select a model number: 

set MODEL=!model[%MODEL_CHOICE%]!

echo.
echo Selected model:
echo   %MODEL%
echo.

:: ------------------------------------------------------------
:: 2) EXECUTION MODE SELECTION
:: ------------------------------------------------------------
echo Choose execution mode:
echo   1) CPU only
echo   2) GPU 0 (Vulkan)
echo   3) GPU 1 (Vulkan)
echo   4) Multi‑GPU (GPU1 + GPU0 split)
echo.

set /p MODE_CHOICE=Select an option: 
echo.

:: ------------------------------------------------------------
:: 3) APPLY SETTINGS BASED ON USER CHOICE
:: ------------------------------------------------------------
set CTX=4096
set THREADS=8
set HOST=0.0.0.0
set PORT=11434

if "%MODE_CHOICE%"=="1" (
    set BACKEND=CPU
    set CMD="%LLAMA_BIN%" -m "%MODEL%" -c %CTX% -t %THREADS% --host %HOST% --port %PORT%
)

if "%MODE_CHOICE%"=="2" (
    set BACKEND=GPU0 Vulkan
    set CMD="%LLAMA_BIN%" --vulkan --main-gpu 0 -m "%MODEL%" -c %CTX% -t %THREADS% --host %HOST% --port %PORT%
)

if "%MODE_CHOICE%"=="3" (
    set BACKEND=GPU1 Vulkan
    set CMD="%LLAMA_BIN%" --vulkan --main-gpu 1 -m "%MODEL%" -c %CTX% -t %THREADS% --host %HOST% --port %PORT%
)

if "%MODE_CHOICE%"=="4" (
    set BACKEND=Multi‑GPU Vulkan (GPU1 + GPU0)
    set CMD="%LLAMA_BIN%" --vulkan --main-gpu 1 --tensor-split 1,1 -m "%MODEL%" -c %CTX% -t %THREADS% --host %HOST% --port %PORT%
)

echo ============================================================
echo   Starting llama.cpp
echo   Backend: %BACKEND%
echo   Model:   %MODEL%
echo ============================================================
echo.

%CMD%

echo.
echo Server stopped.
echo ============================================================

endlocal
