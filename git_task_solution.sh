#!/bin/bash

REPO_NAME='task2_hh'
git init $REPO_NAME
python -c "import hhgit; hhgit.to_text(['img/init.png'], '$REPO_NAME/main.data')"
cd $REPO_NAME
git add --all
git commit -m '{initial commit} [img/init.png] -> {main.data}'

git checkout -b bugfix
cd ../
python -c "import hhgit; hhgit.to_text(['img/init.png', 'img/bugfix.png'], '$REPO_NAME/main.data')"
cd $REPO_NAME
git add --all
git commit -m '{bugfix commit} [img/init.png, img/bugfix.png] -> {main.data}'
git checkout master

git checkout -b feature1
cd ../
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png'], '$REPO_NAME/main.data')"
cd $REPO_NAME
git add --all
git commit -m '{feature1 commit} [img/refactoring.png, img/init.png] -> {main.data}'

git checkout -b feature1-refactoring
cd ../
python -c "import hhgit; hhgit.to_text(['img/init.png'], '$REPO_NAME/main.data')"
python -c "import hhgit; hhgit.to_text(['img/refactoring.png'], '$REPO_NAME/color.data')"
cd $REPO_NAME
git add --all
git commit -m '{feature1-refactoring commit} [img/init.png, img/refactoring.png] -> {main.data, color.data}'

git checkout feature1
git checkout -b feature2
cd ../
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png', 'img/feature2.png'], '$REPO_NAME/main.data')"
cd $REPO_NAME
git add --all
git commit -m '{feature2 commit} [img/refactoring.png, img/init.png, img/feature2.png] -> {main.data}'

git checkout master
git merge bugfix -m 'master and bugfix' --no-ff
git merge feature1-refactoring -m 'master and feature1-refactoring' --no-ff

#git merge feature2 -m 'master and feature2' --no-ff
#python -c "data = [line for line in open('main.data') if not line.strip()[:7] in ['<<<<<<<', '=======', '>>>>>>>']]; res = ''.join(data); fout = open('main.data', 'w'); fout.write(res); fout.close()"
#git add --all
#git commit -m 'master and feature2'

#printf 'main.data\tmerge=union\n' > .gitattributes
#git merge feature2 -m 'master and feature2' --no-ff
#rm -- .gitattributes

git merge feature2 -m 'master and feature2' --no-ff
git show :1:main.data > main.data.base
git show :2:main.data > main.data.ours
git show :3:main.data > main.data.theirs
mv main.data.ours main.data
git merge-file --union main.data main.data.base main.data.theirs
rm main.data.theirs main.data.base
git add main.data
git commit -m 'master and feature2'


