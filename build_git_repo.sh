#!/usr/bin/env bash

# dont ask for commit message on merge
export GIT_MERGE_AUTOEDIT=no

# start git hw
git init task
python -c 'import hhgit; hhgit.to_text(["img/init.png"], "task/main.data")'
git -C task add main.data
git -C task commit -m "init [init.png] -> main.data"

git -C task checkout -b bugfix
python -c 'import hhgit; hhgit.to_text(["img/init.png", "img/bugfix.png"], "task/main.data")'
git -C task add main.data
git -C task commit -m "bugfix [init.png bugfix.png] -> main.data"

git -C task checkout master

git -C task checkout -b feature1
python -c 'import hhgit; hhgit.to_text(["img/refactoring.png", "img/init.png"], "task/main.data")'
git -C task add main.data
git -C task commit -m "feature1 [refactoring.png init.png] -> main.data"

git -C task checkout -b feature1-refactoring
python -c 'import hhgit; hhgit.to_text(["img/init.png"], "task/main.data")'
python -c 'import hhgit; hhgit.to_text(["img/refactoring.png"], "task/background.data")'
git -C task add main.data background.data
git -C task commit -m "feature1-refactoring [init.png] -> main.data, [refactoring.png] -> background.data"

git -C task checkout feature1

git -C task checkout -b feature2
python -c 'import hhgit; hhgit.to_text(["img/refactoring.png", "img/feature2.png", "img/init.png"], "task/main.data")'
git -C task add main.data
git -C task commit -m "feature2 [refactoring.png feature2.png init.png] -> main.data"

git -C task checkout master

git -C task checkout -b rc
git -C task merge --no-ff bugfix
git -C task merge --no-ff feature1
git -C task merge --no-ff feature1-refactoring
git -C task merge --no-ff -X theirs feature2

# end git hh
