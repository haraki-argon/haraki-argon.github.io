@echo off
echo submit to github?
pause>nul
echo already？
pause>nul
git add -A
git commit -m "auto update"
git push origin main