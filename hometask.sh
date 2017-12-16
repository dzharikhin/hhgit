#!/bin/bash
# clear out previous evidences
rm -rf structured_repo

# echo "Start to construct the repo!"
converter="./../proxy.py"
bugfix="./../img/bugfix.png"
feature2="./../img/feature2.png"
init="./../img/init.png"
refactoring="./../img/refactoring.png"

# rm -r structured_repo
git init structured_repo
cd structured_repo

# create init node
python3 "$converter" "$init" "brand.data"
git add "brand.data"
git commit -m "initial state, [init.png] to brand.data"

# construct expanding pathes
git branch feature1
git branch bugfix
git branch rc

# fix cutted letter
git checkout bugfix
python3	"$converter" "$init" "$bugfix" "brand.data"
git add "brand.data"
git commit -m "bugfix, [init.png, bugfix.png] to brand.data"

# merge with explicit node creating
git checkout rc
git merge bugfix --no-ff -m "merged: bugfix to rc"

# fill background with red
git checkout feature1
python3 "$converter" "$refactoring" "$init" "brand.data"
git add "brand.data"
git commit -m "feature1, [refactoring.png, init.png] to brand.data"

# prepare for future feature2
git branch feature2

# split feature1 into 2 files
python3 "$converter" "$init" "brand.data"
python3 "$converter" "$refactoring" "bg.data"
git add "brand.data"
git add "bg.data"
git commit -m "feature1-refactoring, [init.png] to brand.data, [refactoring.png] to bg.data"

# merge splitting with rc
git checkout rc
python3	"$converter" "$init" "$bugfix" "brand.data"
python3 "$converter" "$refactoring" "bg.data"
git add "brand.data"
git add "bg.data"
git merge feature1 --no-ff -m "merge feature1 to rc"



git checkout feature2
python3	"$converter" "$refactoring" "$init" "$feature2" "brand.data"
git add "brand.data"
git commit -m "feature2, [refactoring.png, init.png, feature2.png] to brand.data"

git checkout rc
python3	"$converter" "$init" "$feature2" "brand.data"
git add "brand.data"
git commit -m "merge feature2 to rc"

git merge feature2 --ff -m "merge feature2 to rc"

git filter-branch --tree-filter 'sed -i "1i # it took me 8 hours" *' HEAD --all
