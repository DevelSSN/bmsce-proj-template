@echo off
SETLOCAL

REM Check for tlmgr
echo Checking for tlmgr...
where tlmgr >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo tlmgr not found. Installing TeX Live...
    REM Download and install TeX Live (customize the URL and installer as necessary)
    powershell -Command "Invoke-WebRequest -Uri 'http://mirror.ctan.org/systems/texlive/tlnet/install-tl-windows.exe' -OutFile 'install-tl-windows.exe'"
    start /wait install-tl-windows.exe /silent
) ELSE (
    echo tlmgr is already installed.
)

REM Check for pandoc
echo Checking for pandoc...
where pandoc >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo Pandoc not found. Installing Pandoc...
    REM Install Pandoc (customize installation steps for Windows)
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/jgm/pandoc/releases/download/3.6.3/pandoc-3.6.3-windows-x86_64.msi' -OutFile 'pandoc-installer.msi'"
    start /wait msiexec /i pandoc-installer.msi /quiet
) ELSE (
    echo Pandoc is already installed.
)

REM Install TeX Live packages via tlmgr
echo Installing TeX Live packages...
tlmgr install tabulary graphicx lipsum geometry soul hyphenat ragged2e pgf logreq biber

echo Installation complete!
ENDLOCAL
