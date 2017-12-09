#!/bin/bash

# Create new repository
git init new_repo;

# Create initial image in master branch
python -c "import hhgit; hhgit.to_text(['img/init.png'], 'new_repo/main.data')";
git -C new_repo add main.data;
git -C new_repo commit -m 'init [init.png] -> main.data';

# Create two new branches (bugfix and feature1) from master branch
git -C new_repo branch bugfix;
git -C new_repo branch feature1;

# Create bugfix image in bugfix branch
git -C new_repo checkout bugfix;
python -c "import hhgit; hhgit.to_text(['img/bugfix.png', 'img/init.png'], 'new_repo/main.data')";
git -C new_repo add main.data;
git -C new_repo commit -m 'bugfix [bugfix.png, init.png] -> main.data';

# Merge bugfix branch with master branch
git -C new_repo checkout master;
git -C new_repo merge --no-ff bugfix;
git -C new_repo commit -m 'release candidate with bugfix';

# Create feature1 image in feature1 branch
git -C new_repo checkout feature1;
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png'], 'new_repo/main.data')";
git -C new_repo add main.data;
git -C new_repo commit -m 'feature1 [refactoring.png, init.png] -> main.data';

# Create two new branches (feature1-refactoring and feature2) from feature1 branch
git -C new_repo branch feature1-refactoring;
git -C new_repo branch feature2;

# Create feature1-refactoring images in feature1-refactoring branch
git -C new_repo checkout feature1-refactoring;
python -c "import hhgit; hhgit.to_text(['img/refactoring.png'], 'new_repo/ground.data')";
python -c "import hhgit; hhgit.to_text(['img/init.png'], 'new_repo/main.data')";
git -C new_repo add ground.data;
git -C new_repo add main.data;
git -C new_repo commit -m 'feature1-refactoring [refactoring.png, init.png] -> ground.data, main.data';

# Merge feature1-refactoring branch with master branch
git -C new_repo checkout master;
git -C new_repo merge --no-ff feature1-refactoring;
git -C new_repo commit -m 'release candidate with bugfix and feature1-refactoring';

# Create feature2 image in feature2 branch
git -C new_repo checkout feature2;
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png', 'img/feature2.png'], 'new_repo/main.data')";
git -C new_repo add main.data;
git -C new_repo commit -m 'feature2 [refactoring.png, init.png, feature2.png] -> main.data';

# Octopus merge feature2 branch and feature1-refactoring branch with master branch
git -C new_repo checkout master;
git -C new_repo merge --no-ff feature2 feature1-refactoring;
git -C new_repo commit -m 'release candidate with bugfix, feature1-refactoring and feature2';

echo "Done!";