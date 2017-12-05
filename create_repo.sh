#!/bin/bash


IMPORT='import hhgit;';
TO_TEXT='hhgit.to_text'
 
LOGO='logo.data';
REPO='solution';
LOGO_PATH="'${REPO}/${LOGO}'";
 
git init $REPO;

python -c "$IMPORT $TO_TEXT(['img/init.png'], $LOGO_PATH)"

git -C $REPO add $LOGO
git -C $REPO commit -m "init [init.png] => $LOGO"
git -C $REPO branch -m init

git -C $REPO checkout -b bugfix init
python -c "$IMPORT $TO_TEXT(['img/bugfix.png', 'img/init.png',], $LOGO_PATH)"
git -C $REPO add $LOGO
git -C $REPO commit -m "bugfix [bugfix.png init.png] => $LOGO"

git -C $REPO checkout -b feature1 init
python -c "$IMPORT $TO_TEXT(['img/refactoring.png', 'img/init.png'], $LOGO_PATH)"
git -C $REPO add $LOGO
git -C $REPO commit -m "feature1 [refactoring.png init] => $LOGO"

git -C $REPO checkout -b feature2 feature1
python -c "$IMPORT $TO_TEXT(['img/refactoring.png','img/init.png', 'img/feature2.png'], $LOGO_PATH)"
git -C $REPO add $LOGO
git -C $REPO commit -m "feature2 [refactoring.png init feature2.png] => $LOGO"

git -C $REPO checkout -b refactoring-feature1 feature1
python -c "$IMPORT $TO_TEXT(['img/init.png'], $LOGO_PATH)"
python -c "$IMPORT $TO_TEXT(['img/refactoring.png'], '${REPO}/bg.data')"
git -C $REPO add $LOGO
git -C $REPO add bg.data
git -C $REPO commit -m "refactoring [init.png] => $LOGO [refactoring.png] => bg.data"

git -C $REPO checkout -b rc init

git -C $REPO merge --no-ff -m "feature1 to rc" feature1

git -C $REPO merge --no-ff -m "refactoring-feature1 to rc" refactoring-feature1

git -C $REPO merge --no-ff -m "feature2 to rc" feature2

git -C $REPO merge --no-ff -m "bugfix to rc" bugfix

cd $REPO

git filter-branch -f --tree-filter "find * -name '*.data' -type f -exec sed -i '1i #3hours!' {} \;"  HEAD --all
