#/bin/bash
git init hh
python -c "import hhgit; hhgit.to_text(['img/init.png'],'hh/main.data')"
git -C hh add --all
git -C hh commit -m "init [init.png] -> main.data"

python -c "import hhgit; hhgit.to_text(['img/refactoring.png','img/init.png'],'hh/main.data')"
git -C hh add --all
git -C hh checkout -b feature1
git -C hh commit -m "feature1 [refactoring.png init.png] -> main.data"

python -c "import hhgit; hhgit.to_text(['img/refactoring.png','img/init.png','img/feature2.png'],'hh/main.data')"
git -C hh add --all
git -C hh checkout -b feature2

git -C hh commit -m "feature2 [refactoring.png init.png feature2.png] -> hh/main.data"

git -C hh checkout feature1
git -C hh checkout -b feature1-refactoring
python -c "import hhgit; hhgit.to_text(['img/refactoring.png'],'hh/main-bg.data')"
python -c "import hhgit; hhgit.to_text(['img/init.png'],'hh/main.data')"
git -C hh add --all
git -C hh commit -m "feature1-refactoring [refactoring.png] -> main-bg.data; [init.png] -> main.data"

git -C hh checkout master
git -C hh checkout -b bugfix
python -c "import hhgit; hhgit.to_text(['img/bugfix.png','img/init.png'],'hh/main.data')"
git -C hh add --all
git -C hh commit -m "bugfix [init.png bugfix.png] -> main.data"

git -C hh checkout master
git -C hh checkout -b rc
git -C hh merge bugfix -m "merge rc and bugfix"

git -C hh merge feature1-refactoring -m "merge rc and feature1"
git -C hh merge feature2 -m "merge rc and feature2"



