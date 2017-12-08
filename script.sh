#!/bin/bash

mkdir hh_repo

# init
python -c "import hhgit; hhgit.to_text(['img/init.png'], 'hh_repo/main.data')"
cd hh_repo
git init
git add main.data
git commit -m "init [init.png] -> main.data"

# bugfix
git checkout -b bugfix
cd ..
python -c "import hhgit; hhgit.to_text(['img/bugfix.png', 'img/init.png'], 'hh_repo/main.data')"
cd hh_repo
git add main.data
git commit -m "bugfix [bugfix.png, init.png] -> main.data"

# feature1
git checkout master
git checkout -b feature1
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png'], 'hh_repo/main.data')"
cd hh_repo
git add main.data
git commit -m "feature1 [refactoring.png, init.png] -> main.data"

# feature1-refactoring
git checkout -b feature1-refactoring
cd ..
python -c "import hhgit; hhgit.to_text(['img/init.png'], 'hh_repo/main.data')"
python -c "import hhgit; hhgit.to_text(['img/refactoring.png'], 'hh_repo/background.data')"
cd hh_repo
git add main.data background.data
git commit -m "feature1-refactoring [init.png] -> main.data, [refactoring.png] -> background.data"

# feature2
git checkout feature1
git checkout -b feature2
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png', 'img/feature2.png'], 'hh_repo/main.data')"
cd hh_repo
git add main.data
git commit -m "feature2 [refactoring.png, init.png, feature2.png] -> main.data"

# rc1
git checkout master
git checkout -b rc
git merge bugfix -m "rc [bugfix.png, init.png] -> main.data"

# rc2
git merge feature1-refactoring -m "rc [bugfix.png, init.png] -> main.data, [refactoring.png] -> background.data"

# rc3
git merge feature2 -m "rc [bugfix.png, init.png, feature2.png] -> main.data, [refactoring.png] -> background.data"
