#!/bin/bash

REPO_NAME=testrepo

git init $REPO_NAME
python -c "import hhgit; hhgit.to_text(['img/init.png'], '$REPO_NAME/main.data')"
cd $REPO_NAME
git add main.data
git commit -m "init [init.png] -> main.data"

# bugfix
git checkout -b bugfix
cd ..
python -c "import hhgit; hhgit.to_text(['img/bugfix.png', 'img/init.png'], '$REPO_NAME/main.data')"
cd $REPO_NAME
git add main.data
git commit -m "bugfix [bugfix.png init.png] -> main.data"

# merge bugfix into rc
git checkout master
git checkout -b rc
git merge bugfix --no-ff -m "merge bugfix into rc"

# feature1
git checkout master
git checkout -b feature1
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png'], '$REPO_NAME/main.data')"
cd $REPO_NAME
git add main.data
git commit -m "feature1 [refactoring.png, init.png] -> main.data"

# feature1-refactoring
git checkout -b feature1-refactoring
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png'], '$REPO_NAME/ground.data')"
python -c "import hhgit; hhgit.to_text(['img/init.png'], '$REPO_NAME/main.data')"
cd $REPO_NAME
git add main.data ground.data
git commit -m "feature1-refactoring [refactoring.png] -> ground.data, [init.png] -> main.data"

# merge feature1-refactoring into rc
git checkout rc
git merge feature1-refactoring --no-ff -m "merge feature1-refactoring into rc"

# feature2
git checkout feature1
git checkout -b feature2
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png', 'img/feature2.png'], '$REPO_NAME/main.data')"
cd $REPO_NAME
git add main.data
git commit -m "feature2 [refactoring.png, init.png, feature2.png] -> main.data"

# merge feature2 into rc
git checkout rc
git merge feature2 --no-ff -m "merge feature2 into rc"
