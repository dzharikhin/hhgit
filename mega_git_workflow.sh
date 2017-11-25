#!/bin/bash
REPO_PATH="repo_`date +%s`"

mkdir $REPO_PATH
cd $REPO_PATH
git init
cd ..
python -c "from hhgit import *; to_text(['img/init.png'], '$REPO_PATH/main.data')"
cd $REPO_PATH
git add main.data
git commit -m "{Create repository} ['img/init.png']->{main.data}"
git checkout -b init master
git branch -d master
git checkout -b rc

git checkout -b bugfix
cd ..
python -c "from hhgit import *; to_text(['img/init.png', 'img/bugfix.png'], '$REPO_PATH/main.data')"
cd $REPO_PATH
git commit -am "{Make hotfix} ['img/init.png', 'img/bugfix.png']->{'$REPO_PATH/main.data'}"
git checkout rc
git merge bugfix

git checkout -b feature1
cd ..
python -c "from hhgit import *; to_text(['img/refactoring.png', 'img/init.png', 'img/bugfix.png'], '$REPO_PATH/main.data')"
cd $REPO_PATH
git commit -am "{Make feature1} ['img/refactoring.png', 'img/init.png', 'img/bugfix.png']->{'$REPO_PATH/main.data'}"

git checkout -b feature1-refactoring
cd ..
python -c "from hhgit import *; to_text(['img/refactoring.png'], '$REPO_PATH/background.data')"
python -c "from hhgit import *; to_text(['img/init.png', 'img/bugfix.png'], '$REPO_PATH/main.data')"
cd $REPO_PATH
git add background.data
git commit -am "{Make refactoring} ['img/refactoring.png']->{'$REPO_PATH/backgroung.data'}, ['img/init.png', 'img/bugfix.png']->{'$REPO_PATH/main.data'}"
git checkout rc
git merge feature1-refactoring
git checkout feature1

git checkout -b feature2
cd ..
python -c "from hhgit import *; to_text(['img/refactoring.png', 'img/init.png', 'img/bugfix.png', 'img/feature2.png'], '$REPO_PATH/main.data')"
cd $REPO_PATH
git commit -am "{Make feature2} ['img/refactoring.png', 'img/init.png', 'img/bugfix.png', 'img/feature2.png']->{'$REPO_PATH/main.data'}"
git checkout rc
git merge -m "{Merge all feature to RC}" feature2

git filter-branch -f --tree-filter "find * -name '*.data' -type f -exec sed -i '1i #OhShhhICanRewriteHistory' {} \;" HEAD --all
