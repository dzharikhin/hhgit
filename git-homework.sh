#!/bin/bash

REPO="hh-2-git"

# Delete directory with same name
[ -d $REPO ] && rm -Rf $REPO

# Create new repository
mkdir $REPO
git -C $REPO init

# Init
python -c "import hhgit; hhgit.to_text(['img/init.png'], '$REPO/hh-logo.txt')"
cd $REPO
git add -A
git commit -m "init [init.png] -> hh-logo.txt"

# Creating bugfix from master
git checkout -b bugfix

# Applying bugfix
cd ..
python -c "import hhgit; hhgit.to_text(['img/bugfix.png', 'img/init.png'], '$REPO/hh-logo.txt')"
cd $REPO
git commit -a -m "bugfix [bugfix.png init.png] -> hh-logo.txt"

# Creating feature1 from master
git checkout master
git checkout -b feature1

# Applying feature1 (red background)
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png'], '$REPO/hh-logo.txt')"
cd $REPO
git commit -a -m "feature1 [refactoring.png init.png] -> hh-logo.txt"

# Creating feature2 from feature1
git checkout -b feature2

# Append feature2 (rounded corners)
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png', 'img/feature2.png'], '$REPO/hh-logo.txt')"
cd $REPO
git commit -a -m "feature2 [refactoring.png init.png feature2.png] -> hh-logo.txt"

# Creating feature1-refactoring from feature1
git checkout feature1
git checkout -b feature1-refactoring

# Creating background file
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png'], '$REPO/hh-background.txt')"
cd $REPO
git add hh-background.txt

# Reverting logo to master
git checkout master -- hh-logo.txt

# Commiting feature1-refactoring
git commit -a -m "feature1-refactoring [refactoring.png] -> hh-background.txt, [init.png] -> hh-logo.txt"

# Creating RC from master
git checkout master
git checkout -b RC

# Merging all to RC
git merge bugfix --no-ff -m "bugfix => RC"
git merge feature1-refactoring --no-ff -m "feature1-refactoring => RC"
git merge feature2 --no-ff -m "feature2 => RC"

# Bonus
cd $REPO
git filter-branch --tree-filter '
COMMENT_TO_ADD="# By Gooverdian at gmail dot com"
for file in * ; do
	test -f "$file" && echo "$COMMENT_TO_ADD"|cat - "$file" > /tmp/out && mv /tmp/out "$file"
done' -- --all
