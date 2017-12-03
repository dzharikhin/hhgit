#!/bin/bash

Green='\033[0;32m'
Color_Off='\033[0m'

git init logo
printf "${Green}Create init${Color_Off}\n"
python -c "import hhgit; hhgit.to_text(['img/init.png'], 'logo/logo.data')"
git -C logo add logo.data
git -C logo commit -m "init [init.png] => logo.data"
git -C logo branch -m init

printf "${Green}Create bugfix${Color_Off}\n"
git -C logo checkout -b bugfix init
python -c "import hhgit; hhgit.to_text(['img/bugfix.png', 'img/init.png',], 'logo/logo.data')"
git -C logo add logo.data
git -C logo commit -m "bugfix [bugfix.png init.png] => logo.data"

printf "${Green}Create feature1${Color_Off}\n"
git -C logo checkout -b feature1 init
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png'], 'logo/logo.data')"
git -C logo add logo.data
git -C logo commit -m "feature1 [refactoring.png init] => logo.data"


printf "${Green}Create feature2${Color_Off}\n"
git -C logo checkout -b feature2 feature1
python -c "import hhgit; hhgit.to_text(['img/refactoring.png','img/init.png', 'img/feature2.png'], 'logo/logo.data')"
git -C logo add logo.data
git -C logo commit -m "feature2 [refactoring.png init feature2.png] => logo.data"

printf "${Green}Create refactoring-feature1${Color_Off}\n"
git -C logo checkout -b refactoring-feature1 feature1
python -c "import hhgit; hhgit.to_text(['img/init.png'], 'logo/logo.data')"
python -c "import hhgit; hhgit.to_text(['img/refactoring.png'], 'logo/bg.data')"
git -C logo add logo.data
git -C logo add bg.data
git -C logo commit -m "refactoring [init.png] => logo.data [refactoring.png] => bg.data"

printf "${Green}Create rc${Color_Off}\n"
git -C logo checkout -b rc init

printf "${Green}Merge feature1 to rc${Color_Off}\n"
git -C logo merge --no-ff -m "feature1 to rc" feature1

printf "${Green}Merge refactoring-feature1 to rc${Color_Off}\n"
git -C logo merge --no-ff -m "refactoring-feature1 to rc" refactoring-feature1

printf "${Green}Merge feature2 to rc${Color_Off}\n"
git -C logo merge --no-ff -m "feature2 to rc" feature2

printf "${Green}Merge bugfix to rc${Color_Off}\n"
git -C logo merge --no-ff -m "bugfix to rc" bugfix


