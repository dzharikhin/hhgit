#!/usr/bin/env bash

# dont ask for commit message on merge
export GIT_MERGE_AUTOEDIT=no

# start git hw
git init
python -c 'import hhgit; hhgit.to_text(["img/init.png"], "main.data")'
git add -f main.data
git commit -m "init [init.png] -> main.data"

git checkout -b bugfix
python -c 'import hhgit; hhgit.to_text(["img/init.png", "img/bugfix.png"], "main.data")'
git add -f main.data
git commit -m "bugfix [init.png bugfix.png] -> main.data"

git checkout master

git checkout -b feature1
python -c 'import hhgit; hhgit.to_text(["img/refactoring.png", "img/init.png"], "main.data")'
git add -f main.data
git commit -m "feature1 [refactoring.png init.png] -> main.data"

git checkout -b feature1-refactoring
python -c 'import hhgit; hhgit.to_text(["img/init.png"], "main.data")'
python -c 'import hhgit; hhgit.to_text(["img/refactoring.png"], "background.data")'
git add -f main.data background.data
git commit -m "feature1-refactoring [init.png] -> main.data, [refactoring.png] -> background.data"

git checkout feature1

git checkout -b feature2
python -c 'import hhgit; hhgit.to_text(["img/refactoring.png", "img/feature2.png", "img/init.png"], "main.data")'
git add -f main.data
git commit -m "feature2 [refactoring.png feature2.png init.png] -> main.data"

git checkout master

git checkout -b rc
git merge --no-ff bugfix
git merge --no-ff feature1
git merge --no-ff feature1-refactoring
git merge --no-ff -X theirs feature2

# end git hh
