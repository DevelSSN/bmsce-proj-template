@echo off
setlocal enabledelayedexpansion

:: Function to check if tlmgr is installed
call :check_tlmgr_installed
if errorlevel 1 exit /b

:: Function to install required LaTeX packages
call :install_required_packages

:: Menu to choose options
:menu
cls
echo Select an option:
echo 1) Use Online LaTeX Compiler (does nothing)
echo 2) Ensure tlmgr is installed with required packages for pandoc
echo 3) Exit

set /p choice=Enter your choice (1-3): 

if "%choice%"=="1" (
    echo Option 1: Use an online LaTeX compiler (does nothing)
    :: Option 1 does nothing
    pause
    goto menu
) else if "%choice%"=="2" (
    call :check_tlmgr_installed
    call :install_required_packages
    goto menu
) else if "%choice%"=="3" (
    echo Exiting...
    exit /b
) else (
    echo Invalid option. Please choose a valid option.
    pause
    goto menu
)

:: Function to check if tlmgr is installed
:check_tlmgr_installed
where tlmgr > nul 2>&1
if %errorlevel% neq 0 (
    echo TeX Live Manager (tlmgr) is not installed. Please install it first.
    exit /b 1
)
echo tlmgr is installed.
goto :eof

:: Function to install required LaTeX packages
:install_required_packages
set required_packages=tabular graphicx lipsum geometry soul hyphenat ragged2e

:: Ensure tlmgr is up-to-date before installing packages
echo Updating tlmgr...
tlmgr update --self

echo Installing required LaTeX packages...
for %%p in (%required_packages%) do (
    echo Installing %%p...
    tlmgr install %%p
)

echo All required LaTeX packages are installed.
goto :eof

