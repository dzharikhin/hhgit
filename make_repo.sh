#!/bin/bash
git init repo
python -c "import hhgit; hhgit.to_text(['img/init.png'], 'repo/logo.data')"
git -C repo add logo.data
git -C repo commit -m "init [init.png] => logo.data"
git -C repo branch -m init

git -C repo checkout -b bugfix
python -c "import hhgit; hhgit.to_text(['img/init.png', 'img/bugfix.png',], 'repo/logo.data')"
git -C repo add logo.data
git -C repo commit -m "bugfix [init.png bugfix.png] => logo.data"

git -C repo checkout init
git -C repo checkout -b feature1
python -c "import hhgit; hhgit.to_text(['img/init.png', 'img/refactoring.png'], 'repo/logo.data')"
git -C repo add logo.data
git -C repo commit -m "feature1 [init.png refactoring.png] => logo.data"

git -C repo checkout init
git -C repo checkout -b rc
git -C repo merge --commit -m "init to rc" init
#Without empty commit merge-commit from bugfix won't created
git -C repo commit --allow-empty -m "rc"
git -C repo merge --commit -m "bugfix to rc" bugfix

git -C repo checkout feature1
git -C repo checkout -b feature2
python -c "import hhgit; hhgit.to_text(['img/feature2.png', 'img/init.png', 'img/refactoring.png'], 'repo/logo.data')"
git -C repo add logo.data
git -C repo commit -m "feature2 [feature2.png init.png refactoring.png] => logo.data"

git -C repo checkout feature1
python -c "import hhgit; hhgit.to_text(['img/init.png'], 'repo/logo.data')"
python -c "import hhgit; hhgit.to_text(['img/refactoring.png'], 'repo/bg.data')"
git -C repo add logo.data
git -C repo add bg.data
git -C repo commit -m "refactoring [init.png] => logo.data [refactoring.png] => bg.data"

git -C repo checkout rc
git -C repo merge --commit -m "refactoring to rc" feature1
git -C repo merge --commit -m "feature2 to rc" feature2
sed -i '/=.*/d' ./repo/logo.data 
sed -i '/<.*/d' ./repo/logo.data 
sed -i '/>.*/d' ./repo/logo.data 
sed -i '/.*214;0;28/d' ./repo/logo.data 
git -C repo commit -m "resolving confilct feature2 to rc"
#Clean empty commits
git -C repo filter-branch --commit-filter 'git_commit_non_empty_tree "$@"' -- --all
#Add message to all data files in all commits
git -C repo filter-branch -f --tree-filter "find * -name '*.data' -exec sed -i '1i #hello! here is {}' {} \;" HEAD --all
