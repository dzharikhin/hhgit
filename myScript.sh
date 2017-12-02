dirName="myRepo"
rm -rf "$dirName"
mkdir -p "$dirName"
cd "$dirName"
git init
git config user.name "your name"
git config user.email "you@example.com"
#python -B -c "import hhgit; hhgit.to_text(['img/init.png'],'$dirName/init.data')"
cp ../img/init.png ./
git add "init.png"
git commit -m "initial commit [init.png] -> init.png"

git branch rc
git branch feature1
git checkout -b bugfix
#bugfix init
cd ..
python -B -c "import hhgit; hhgit.to_text(['img/init.png', 'img/bugfix.png'],'$dirName/logo.data')"
cd "$dirName"
rm init.png
git add logo.data
git add init.png
git commit -m "bugfix [init.png bugfix.png] -> logo.data"
git checkout rc
git merge bugfix -m "merge bugfix to rc" --no-ff
git branch -d bugfix

#feature1 init
git checkout feature1
cd ..
python -B -c "import hhgit; hhgit.to_text(['img/refactoring.png','img/init.png'],'$dirName/logo.data')"
cd "$dirName"
rm init.png
git add logo.data
git add init.png
git commit -m "feature1 [refactoring.png init.png] -> logo.data"
git branch feature2
#feature1_refact
cd ..
python -B -c "import hhgit; hhgit.to_text(['img/init.png'],'$dirName/logo.data')"
python -B -c "import hhgit; hhgit.to_text(['img/refactoring.png'],'$dirName/backGround.data')"
cd "$dirName"
git add logo.data
git add backGround.data
git commit -m "feature1_refactoring [init.png] -> logo.data, [refactoring.png] -> backGround.data"
git checkout rc
git merge -Xours feature1 -m "merge feature1 to rc"
git branch -d feature1

#feature2
git checkout feature2
cd ..
python -B -c "import hhgit; hhgit.to_text(['img/refactoring.png','img/init.png','img/feature2.png'],'$dirName/logo.data')"
cd "$dirName"
git add logo.data
git commit -m "feature2 ['refactoring.png','init.png','feature2.png'] -> logo.data"

#final merge
git checkout rc
git merge feature2
cd ..
python -B -c "import hhgit; hhgit.to_text(['img/init.png','img/bugfix.png','img/feature2.png'],'$dirName/logo.data')"
cd "$dirName"
git add logo.data
git commit -m "merge feature2 to rc"
git branch -d feature2


#cd ..
#python -B -c "import hhgit; hhgit.from_text(['myRepo/logo.data'],'myRepo/test.png')"
#cd "$dirName"

git log --graph --full-history --all --pretty=format:"%h%x09%d%x20%s"

#advanced
#Is it right?
git filter-branch -f --tree-filter 'for file in *
do
echo "#5+4 hours" | cat - $file > temp && mv temp $file
done' HEAD --all


git log --graph --full-history --pretty=format:"%h%x09%d%x20%s"

#BUT
#echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
#git log --graph --full-history --all --pretty=format:"%h%x09%d%x20%s"

cd ..
