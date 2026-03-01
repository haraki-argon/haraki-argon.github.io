@echo off
start cmd /k "uv run build.py build"
start cmd /k "uv run build.py preview"
start updategit.bat