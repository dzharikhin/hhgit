#!/bin/bash

TREPO=train_repo
# DEBUG=debug
mkdir $TREPO
if [ ! -z $DEBUG ]
then
	mkdir $DEBUG
fi
python -c "import hhgit; hhgit.to_text(['img/init.png'], '$TREPO/main.data')"
cd $TREPO

# Initialize repo and make the first commit
git init
git add main.data
git commit -m "init [init.png] -> main.data"
if [ ! -z $DEBUG ]
then
	cd ..
	python -c "import hhgit; hhgit.from_text(['$TREPO/main.data'], '$DEBUG/init.png')"
	cd $TREPO
fi

# Bugfix
git checkout -b bugfix
cd ..
python -c "import hhgit; hhgit.to_text(['img/init.png', 'img/bugfix.png'], '$TREPO/main.data')"
cd $TREPO
git add main.data
git commit -m "bugfix [init.png bugfix.png] -> main.data"
if [ ! -z $DEBUG ]
then
	cd ..
	python -c "import hhgit; hhgit.from_text(['$TREPO/main.data'], '$DEBUG/bugfix.png')"
	cd $TREPO
fi

# Merge Bugfix into RC
git checkout master
git checkout -b rc
git merge bugfix --no-ff -m "merge bugfix into rc"
if [ ! -z $DEBUG ]
then
	cd ..
	python -c "import hhgit; hhgit.from_text(['$TREPO/main.data'], '$DEBUG/rc1.png')"
	cd $TREPO
fi

# Feature 1
git checkout master
git checkout -b feature1
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png'], '$TREPO/main.data')"
cd $TREPO
git add main.data
git commit -m "feature1 [refactoring.png, init.png] -> main.data"
if [ ! -z $DEBUG ]
then
	cd ..
	python -c "import hhgit; hhgit.from_text(['$TREPO/main.data'], '$DEBUG/feature1.png')"
	cd $TREPO
fi

Merge Feature 1 into RC
git checkout rc
git merge feature1 -m "merge feature1 into rc"
if [ ! -z $DEBUG ]
then
	cd ..
	python -c "import hhgit; hhgit.from_text(['$TREPO/main.data'], '$DEBUG/rc2.png')"
	cd $TREPO
fi

# Feature 1 - Refactoring
git checkout feature1
git checkout -b feature1-refactoring
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png'], '$TREPO/background.data')"
python -c "import hhgit; hhgit.to_text(['img/init.png'], '$TREPO/main.data')"
cd $TREPO
git add main.data background.data
git commit -m "feature1-refactoring [refactoring.png] -> background.data, [init.png] -> main.data"
if [ ! -z $DEBUG ]
then
	cd ..
	python -c "import hhgit; hhgit.from_text(['$TREPO/background.data'], '$DEBUG/refactoring_background.png')"
	python -c "import hhgit; hhgit.from_text(['$TREPO/main.data'], '$DEBUG/refactoring_main.png')"
	cd $TREPO
fi

# Merge Feature 1 - Refactoring into RC
git checkout rc
git merge feature1-refactoring --no-ff -m "merge feature1-refactoring into rc"
if [ ! -z $DEBUG ]
then
	cd ..
	python -c "import hhgit; hhgit.from_text(['$TREPO/background.data'], '$DEBUG/rc3-background.png')"
	python -c "import hhgit; hhgit.from_text(['$TREPO/main.data'], '$DEBUG/rc3-main.png')"
	cd $TREPO
fi

# Feature 2
git checkout feature1
git checkout -b feature2
cd ..
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png', 'img/feature2.png'], '$TREPO/main.data')"
cd $TREPO
git add main.data
git commit -m "feature 2 [refactoring.png, init.png, feature2.png] -> main.data"
if [ ! -z $DEBUG ]
then
	cd ..
	python -c "import hhgit; hhgit.from_text(['$TREPO/main.data'], '$DEBUG/feature2.png')"
	cd $TREPO
fi

# Merge Feature 2 into RC
git checkout rc
git merge feature2 -m "merge feature2 into rc"
grep -v '<<<' < main.data > main1.data
grep -v '===' < main1.data > main2.data
grep -v '>>>' < main2.data > main.data
rm main1.data main2.data
git add main.data
git commit -m "merge feature2 into rc"
if [ ! -z $DEBUG ]
then
	cd ..
	python -c "import hhgit; hhgit.from_text(['$TREPO/background.data'], '$DEBUG/rc4-background.png')"
	python -c "import hhgit; hhgit.from_text(['$TREPO/main.data'], '$DEBUG/rc4-main.png')"
	cd $TREPO
fi
cd ..
