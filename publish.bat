@echo off
setlocal
REM Commit and push this site. GitHub Actions handles deployment.
cd /d "%~dp0"
if errorlevel 1 goto failed

git add -A
if errorlevel 1 goto failed
git diff --cached --quiet
if errorlevel 2 goto failed
if errorlevel 1 (
  git commit -m "Update site"
  if errorlevel 1 goto failed
) else (
  echo [publish] No changes to commit.
)

git push
if errorlevel 1 goto failed
echo.
echo [publish] Push succeeded. GitHub Actions deploys new commits automatically.
echo [publish] https://github.com/yei350630-wq/shanzha-agents/actions
pause
exit /b 0

:failed
echo.
echo [publish] Publish failed. Read the error above and try again.
pause
exit /b 1
