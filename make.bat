@echo off

set "BAITJS_DIR=%USERPROFILE%\.bait\baitjs"

REM Parse arguments
set "IS_LOCAL=0"

for %%i in (%*) do (
  if "%%i"=="--local" (
    set "IS_LOCAL=1"
  )
)

:download_baitjs
if exist "%BAITJS_DIR%\bait.js" (
  if "%IS_LOCAL%"=="0" (
    git -C "%BAITJS_DIR%" pull --quiet
  )
) else (
  if "%IS_LOCAL%"=="0" (
    git clone --depth 1 https://github.com/tiabeast/baitjs "%BAITJS_DIR%"
  ) else (
    echo baitjs not found locally. Run without "--local"
    exit /b 1
  )
)

:bootstrap
REM Compile new bait.js and ensure self compilation is working
node "%BAITJS_DIR%\bait.js" cli\bait.bt -o bait1.js
node bait1.js cli\bait.bt -o bait2.js
node bait2.js self -o bait.js

:check_success
set "allow_retry=%1"

if exist bait.js (
  goto :cleanup
)

if "%allow_retry%"=="true" (
  echo make: compilation failed. Retrying...
  git pull --quiet
  call :bootstrap
  call :check_success false
  goto :cleanup
)

echo make: compilation failed
exit /b 1

:cleanup
REM Sanity check the file size
for /f %%a in ('type bait.js ^| find /c /v ""') do set "line_count=%%a"
if %line_count% LEQ 5000 (
  echo bait.js is too small. Something went wrong.
  exit /b 1
)

del /f bait1.js bait2.js

echo Run 'bait.bat symlink' to add Bait to your path.
