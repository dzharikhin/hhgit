#!/bin/bash

if [ -e train_repo ] ; then
  rm -rf train_repo
fi

mkdir train_repo

#init
python -c "import hhgit; hhgit.to_text(['img/init.png'], 'train_repo/main.data')"
cd train_repo
git init
git add main.data
git commit -m "init [init.png]->main.data"

# bugfix
git checkout -b bugfix
cd ..
python -c "import hhgit; hhgit.to_text(['img/bugfix.png', 'img/init.png'], 'train_repo/main.data')"
cd train_repo
git add main.data
git commit -m "bugfix [bugfix.png, init.png]->main.data"

#feature1
git checkout master
git checkout -b feature1
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png'], 'train_repo/main.data')"
cd train_repo
git add main.data
git commit -m "feature1 [refactoring.png, init.png]->main.data"

#refactoring
git checkout -b refactoring
cd ..
python -c "import hhgit; hhgit.to_text(['img/init.png'], 'train_repo/main.data')"
python -c "import hhgit; hhgit.to_text(['img/refactoring.png'], 'train_repo/ground.data')"
cd train_repo
git add main.data ground.data
git commit -m "refactoring [init.png]->main.data, [refactoring.png]->ground.data"

#feature2
git checkout feature1
git checkout -b feature2
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png', 'img/feature2.png'], 'train_repo/main.data')"
cd train_repo
git add main.data
git commit -m "feature2 [refactoring.png, init.png, feature2.png]->main.data"

#rc first step
git checkout master
git checkout -b rc
git merge bugfix --no-ff -m "rc [bugfix.png, init.png]->main.data"

#rc second step
git merge refactoring -m "rc [bugfix.png, init.png]->main.data, [refactoring.png]->ground.data"

#rc third step
git merge feature2 -m "rc [bugfix.png, init.png, feature2.png]->main.data, [refactoring.png]->ground.data"

#advanced
git filter-branch --tree-filter 'for filename in * ; do sed -i -e "1 s/^/# 3 hours\n/;" $filename ; done' HEAD
