@rem old method , if files are in WSL, path will be C:\Windows , aka %cd%
@rem So if files are in WSL, it will fail to copy because of wrong source path
@rem xcopy /Y bin_for_win\*.* C:\Users\%UserName%\AppData\Local\Microsoft\WindowsApps
@rem xcopy /Y git_script_for_win\*.* C:\Users\%UserName%\AppData\Local\Microsoft\WindowsApps

@rem below method works if files are in WSL too.
@set currdir=%~dp0
@xcopy /Y %currdir%\script_win\*.* C:\Users\%UserName%\AppData\Local\Microsoft\WindowsApps

git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global color.log auto

@rem pause
