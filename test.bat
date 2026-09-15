@echo off
start cmd /k "uv run file_lister.py"
timeout /t 1 /nobreak >nul
start cmd /k "uv run build.py build"
start cmd /k "uv run build.py preview"
start updategit.bat