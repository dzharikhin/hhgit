git init

# init
python -c "import hhgit; hhgit.to_text(['img/init.png'], 'main.data')"
git add -f main.data
git commit main.data -m "init [init.png] -> main.data"
python -c "import hhgit; hhgit.from_text(['main.data'], 'main.png')"

# sleep 4

# bug fix
git checkout -b bugfix
python -c "import hhgit; hhgit.to_text(['img/init.png', 'img/bugfix.png'], 'main.data')"
git add -f main.data
git commit main.data -m "bugfix [init.png, bugfix.png] -> main.data"
python -c "import hhgit; hhgit.from_text(['main.data'], 'main.png')"
git checkout master

# sleep 4

# feature1
git checkout -b feature1
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png'], 'main.data')"
git add -f main.data
git commit main.data -m "feature1 [refactoring.png, init.png] -> main.data"
python -c "import hhgit; hhgit.from_text(['main.data'], 'main.png')"

# sleep 4

# refactoring
git checkout -b refactoring
python -c "import hhgit; hhgit.to_text(['img/init.png'], 'main.data')"
python -c "import hhgit; hhgit.to_text(['img/refactoring.png'], 'background.data')"
git add -f main.data
git add -f background.data
git commit -m "refactoring [init.png] -> main.data, [refactoring.png] -> background.data"
python -c "import hhgit; hhgit.from_text(['main.data'], 'main.png')"
python -c "import hhgit; hhgit.from_text(['background.data'], 'background.png')"

# sleep 4

# feature2
git checkout feature1
git checkout -b feature2
python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png', 'img/feature2.png'], 'main.data')"
git add -f main.data
git commit -m "feature2 [refactoring.png, init.png, feature2.png] -> main.data"
python -c "import hhgit; hhgit.from_text(['main.data'], 'main.png')"

# sleep 4

# rc1
git checkout master
git checkout -b rc
git merge bugfix -m "rc 1"
python -c "import hhgit; hhgit.from_text(['main.data'], 'main.png')"

# rc1.5
git merge feature1 -m "rc 1.5"
python -c "import hhgit; hhgit.from_text(['main.data'], 'main.png')"

# rc2
git merge refactoring -m "rc 2"
python -c "import hhgit; hhgit.from_text(['main.data'], 'main.png')"
python -c "import hhgit; hhgit.from_text(['background.data'], 'background.png')"

# rc3
git merge feature2 -m "rc 3"
python -c "import hhgit; hhgit.to_text(['img/init.png', 'img/bugfix.png', 'img/feature2.png'], 'main.data')"
git add -f main.data
git commit -m "rc 3"
python -c "import hhgit; hhgit.from_text(['main.data'], 'main.png')"
python -c "import hhgit; hhgit.from_text(['background.data'], 'background.png')"
