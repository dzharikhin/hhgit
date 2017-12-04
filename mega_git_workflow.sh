#!/bin/bash
set -e
shopt -s extglob

DIR_PATH=`pwd`
REPO_NAME="my_repo"
REPO_PATH="${DIR_PATH}/${REPO_NAME}"

function create_img() {
    cd ${DIR_PATH}
    num_args=$#
    out_file=${@:num_args:1}
    in_files=""
    for file in ${@:2:((num_args-2))}
    do
        in_files="${in_files} '${file}'"
    done
    # trim whitspaces
    in_files="${in_files##*( )}"
    # split by comma
    in_files="${in_files// /, }"

    case "$1" in
        text)
            python -c "from hhgit import *; to_text([${in_files}], '${REPO_PATH}/${out_file}')"
        ;;
        png)
            python -c "from hhgit import *; from_text([${in_files}], '${REPO_PATH}/${out_file}')"
        ;;
    esac
    cd ${REPO_PATH}
}
    
function main_git() {
    mkdir -p ${REPO_PATH}
    git init ${REPO_PATH}
    create_img text img/init.png main.data

    git add .
    git commit -m "{Init repository} [${in_files}]->{${out_file}}"
    git branch -m init

    git checkout -b rc
    git checkout -b bugfix
    create_img text img/init.png img/bugfix.png main.data
    git commit -am "{Make hotfix} [${in_files}]->{${out_file}}"
    git checkout rc
    git merge --no-ff bugfix -m "Merge hotfix to RC"

    git checkout init
    git checkout -b feature1
    create_img text img/refactoring.png img/init.png main.data
    git commit -am "{Make feature1} [${in_files}]->{${out_file}}"

    git checkout -b feature1-refactoring
    create_img text img/refactoring.png background.data
    t_in_files=${in_files}
    t_out_file=${out_file}
    create_img text img/init.png main.data
    git add .
    git commit -am "{Make refactoring} [${t_in_files}]->{${t_out_file}}, [${in_files}]->{${out_file}}"

    git checkout rc
    create_img text img/refactoring.png img/init.png main.data
    git add .
    git commit -am "{Make no conflict} [${in_files}]->{${out_file}}"
    git merge --no-ff feature1-refactoring -m "Merge refactoring to RC"
    git checkout feature1

    git checkout -b feature2
    create_img text img/refactoring.png img/init.png img/feature2.png main.data
    git commit -am "{Make feature2} [${in_files}]->{${out_file}}"
    git checkout rc
    git merge --no-ff -m "{Merge feature2 to RC}" feature2

    git filter-branch -f --tree-filter "find * -name '*.data' -type f -exec sed -i '1i #OhShhhICanRewriteHistory' {} \;" HEAD --all
}

################################################################
#   Usage:                                                     #
# Create png file from text file(s)                            #
# ./mega_git_workflow.sh to_text [input_files] output_file     #
#                                                              #
# Create text file from png file(s)                            #
# ./mega_git_workflow.sh from_text [input_files] output_file   #
#                                                              #
# Main script                                                  #
# ./mega_git_workflow.sh                                       #
################################################################

case "$1" in
    to_text)
        create_img text "${@:2:$#}"
        ;;
    from_text)
        create_img png "${@:2:$#}"
        ;;
    *)
        main_git
esac

shopt -u extglob
