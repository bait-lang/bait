@echo off

set "BOOTSTRAP_DIR=%USERPROFILE%\.bait\bootstrap"
set "OLD_BAITJS_DIR=%USERPROFILE%\.bait\baitjs"
set "BOOTSTRAP_URL=https://github.com/bait-lang/bootstrap"

REM Parse arguments
set "IS_LOCAL=0"

for %%i in (%*) do (
  if "%%i"=="--local" (
    set "IS_LOCAL=1"
  )
)

:download_bootstrap
REM Migrate clone of the old baitjs repo
if not exist "%BOOTSTRAP_DIR%" if exist "%OLD_BAITJS_DIR%" (
  move "%OLD_BAITJS_DIR%" "%BOOTSTRAP_DIR%" >nul
  git -C "%BOOTSTRAP_DIR%" remote set-url origin %BOOTSTRAP_URL%
)

if exist "%BOOTSTRAP_DIR%\bait.js" (
  if "%IS_LOCAL%"=="0" (
    git -C "%BOOTSTRAP_DIR%" pull --quiet
  )
) else (
  if "%IS_LOCAL%"=="0" (
    git clone --depth 1 %BOOTSTRAP_URL% "%BOOTSTRAP_DIR%"
  ) else (
    echo bootstrap not found locally. Run without "--local"
    exit /b 1
  )
)

:bootstrap
REM Compile new bait.js and ensure self compilation is working
bun "%BOOTSTRAP_DIR%\bait.js" cli\bait.bt -o bait1.js
bun bait1.js cli\bait.bt -o bait2.js
bun bait2.js self -o bait.js

:check_success
set "allow_retry=%1"

if exist bait.js (
  goto :cleanup
)

if "%allow_retry%"=="true" (
  echo make: compilation failed. Retrying...
  git pull https://github.com/bait-lang/bait main --quiet
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

echo Run 'bait.bat symlink' as Admin to add Bait to your path.
