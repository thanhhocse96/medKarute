@echo off
REM Windows dev: delegate to bash (Git Bash / WSL). Persona Mac dung .sh truc tiep.
where bash >nul 2>&1
if %ERRORLEVEL% neq 0 (
  echo endnote-mcp wrapper: can cai Git Bash hoac dung WSL de chay run-endnote-mcp.sh. 1>&2
  exit /b 1
)
bash "%~dp0run-endnote-mcp.sh"
exit /b %ERRORLEVEL%