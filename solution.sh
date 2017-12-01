#!/bin/bash

REPO=solution

rm -rf $REPO

git init $REPO
python -c "import hhgit; hhgit.to_text(['img/init.png'], '$REPO/logo.data')"
cd $REPO
git add logo.data
git commit -m "init"

git checkout -b bugfix
cd ..
python -c "import hhgit; hhgit.to_text(['img/bugfix.png', 'img/init.png'], '$REPO/logo.data')"
cd $REPO
git commit -am "bugfix"

git checkout master
git checkout -b feature1
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png'], '$REPO/logo.data')"
cd $REPO
git commit -am "feature1"

git checkout -b feature2
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png', 'img/feature2.png'], '$REPO/logo.data')"
cd $REPO
git commit -am "feature2"

git checkout feature1
git checkout -b refactoring
cd ..
python -c "import hhgit; hhgit.to_text(['img/init.png'], '$REPO/logo.data')"
python -c "import hhgit; hhgit.to_text(['img/refactoring.png'], '$REPO/back.data')"
cd $REPO
git add --all
git commit -am "feature2"

git checkout master
git checkout -b rc
git merge bugfix -m "rc0" --no-ff
git merge refactoring -m "rc1" --no-ff
git merge feature2 -m "rc2" --no-ff

git checkout master
git merge rc

cd ..
python -c "import hhgit; hhgit.from_text(['$REPO/logo.data'], 'logo.png')"
python -c "import hhgit; hhgit.from_text(['$REPO/back.data'], 'back.png')"

cd $REPO
git filter-branch -f --tree-filter "find * -name '*.data' -type f -exec sed -i '1i\4 hours' {} +" HEAD --all
cd ..

echo "All done."
