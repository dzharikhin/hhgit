#!/bin/bash
if [[ $# -eq 0 ]]; then
	echo "Enter the name of repo."
else
	if [ -d "$1" ]; then
		echo "repo with this name is allready exists!"
	else
	#_______________________________________________________________________________________________
		git init $1
		python -c "import hhgit; hhgit.to_text(['img/init.png'], '$1/logo.data')"
		git -C $1 checkout -b rc
		git -C $1 add logo.data
		git -C $1 commit -m "{init} [init.png] -> {logo.data}"

		git -C $1 checkout -b bugfix
		python -c "import hhgit; hhgit.to_text(['img/bugfix.png', 'img/init.png'], '$1/logo.data')"
		git -C $1 commit -am "{bugfix} [bugfix.png init.png] -> {logo.data}"

		git -C $1 checkout rc
		git -C $1 checkout -b feature1
		python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png'], '$1/logo.data')"
		git -C $1 commit -am "{feature1} [refactoring.png img/init.png] -> {logo.data}"

		git -C $1 checkout -b feature2
		python -c "import hhgit; hhgit.to_text(['img/refactoring.png', 'img/init.png', 'img/feature2.png'], '$1/logo.data')"
		git -C $1 commit -am "{feature2} [refactoring.png', init.png', feature2.png] -> {logo.data}"

		git -C $1 checkout feature1
		git -C $1 checkout -b feature1-refactoring
		python -c "import hhgit; hhgit.to_text(['img/init.png'], '$1/logo.data')"
		python -c "import hhgit; hhgit.to_text(['img/refactoring.png'], '$1/bg.data')"
		git -C $1 add --all
		git -C $1 commit -am "{feature1-refactoring} [init.png] -> {logo.data}, [refactoring.png] -> {bg.data}"

		git -C $1 checkout rc 
		git -C $1 merge bugfix -m "{rc}" --no-ff 
		git -C $1 merge feature1-refactoring -m "{rc}"
		git -C $1 merge feature2 -m "{rc}" 
		git -C $1 merge rc
	#_______________________________________________________________________________________________
		echo "====================================="
		echo "============ Well done! ============="
		echo "====================================="
	fi
fi
