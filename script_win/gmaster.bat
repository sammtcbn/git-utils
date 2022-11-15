git checkout master
IF ERRORLEVEL 1 (
    git checkout main
)
git branch -l
