#!/bin/bash

#Don't forget to remove 'repo' directory if there is one
#rm -r repo

#Initial commit
git init repo
cd repo
python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.to_text(['../img/init.png'], 'logo.data')"
git add logo.data
git commit -m "init [init.png] -> logo.data"
#Debug image for initial commit 
#python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.from_text(['logo.data'], 'logo_init.png')"

git branch bugfix
git branch feature1
git branch rc

#Apply bugfix to initial
git checkout bugfix
python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.to_text(['../img/init.png', '../img/bugfix.png'], 'logo.data')"
git add logo.data
git commit -m "bugfix [init.png bugfix.png] -> logo.data"
#Debug image for bugfix
#python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.from_text(['logo.data'], 'logo_bugfix.png')"

git checkout rc
git merge bugfix --no-ff -m "merge bugfix to rc"
#Debug image for bugfix merged to rc
#python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.from_text(['logo.data'], 'logo_bugfix_rc.png')"

#Apply feature1 to initial
git checkout feature1
python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.to_text(['../img/refactoring.png', '../img/init.png'], 'logo.data')"
git add logo.data
git commit -m "feature1 [refactoring.png init.png] -> logo.data"
#Debug image for feature1
#python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.from_text(['logo.data'], 'logo_feature1.png')"

git branch feature2

#Apply refactoring to feature1
python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.to_text(['../img/init.png'], 'logo.data')"
python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.to_text(['../img/refactoring.png'], 'back.data')"
git add logo.data
git add back.data
git commit -m "feature1-refactoring [init.png] -> logo.data, [refactoring.png] -> back.data"
#Debug image for refactoring feature1
#python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.from_text(['logo.data'], 'logo_feature1_refactoring.png')"

#Compressing textual representation of rc, for it not cause conflicts and then merge feature1 to rc
git checkout rc
python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.from_text(['logo.data'], 'tmp.png')"
python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.to_text(['tmp.png'], 'logo.data')"
git add logo.data
git commit -m "compressing textual representation [logo.data] -> tmp.png, [tmp.png] -> logo.data"
git merge feature1 --no-ff -m "merge feature1 to rc"
#Debug image feature1 refactored in rc
#python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.from_text(['logo.data'], 'logo_feature1_refactoring_rc.png')"

#Apply feature2 to not refactored feature1
git checkout feature2
python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.to_text(['../img/refactoring.png', '../img/init.png', '../img/feature2.png'], 'logo.data')"
git add logo.data
git commit -m "feature2 [refactoring.png init.png feature2.png] -> logo.data"
#Debug image for feature2
#python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.from_text(['logo.data'], 'logo_feature2.png')"

#Merge feature2 to rc
git checkout rc
git merge feature2 --no-ff -m "merge feature2 to rc"
#Debug image fo feature2 in rc
#python -c "import sys; sys.path.append(\"..\"); import hhgit; hhgit.from_text(['logo.data'], 'logo_feature2_rc.png')"

#Insert comment to whole history
git filter-branch --tree-filter "find . -name '*.data' -exec sed -i '1i#6 hours of fun time\' {} \;" HEAD --all
