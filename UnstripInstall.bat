@echo off
if not exist "UnstrippedLibs" mkdir UnstrippedLibs
curl -L -o "temp1.zip" https://unity.bepinex.dev/libraries/2019.3.15.zip
curl -L -o "temp2.zip" https://unity.bepinex.dev/corlibs/2019.3.15.zip
powershell -command "Expand-Archive -Force '%~dp0temp1.zip' '%~dp0UnstrippedLibs'
powershell -command "Expand-Archive -Force '%~dp0temp2.zip' '%~dp0UnstrippedLibs'
set "file=%~dp0doorstop_config.ini"
set "file2=%~dp0temp.ini"
:Replace
>"%file2%" (
  for /f "usebackq delims=" %%A in ("%file%") do (
    if "%%A" equ "dllSearchPathOverride=" (echo dllSearchPathOverride=UnstrippedLibs) else (echo %%A)
  )
)
del "%~dp0doorstop_config.ini"
del "temp1.zip"
del "temp2.zip"
ren "temp.ini" "doorstop_config.ini"
