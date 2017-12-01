#!/bin/bash
#
# Typical git-flow repository generator

# New repository name
REPO_NAME="$1"
[ -z "${REPO_NAME}" ] && REPO_NAME="train_repo"

# Directory where script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Directory of input images
IMG_DIR="${SCRIPT_DIR}/img"

###############################################################################
# Simplified call of functions from hhgit.py module
# Arguments:
#   First  - function name
#   Second - directory of input files
#   Third  - output file
#   Others - set of input files (without full path)
###############################################################################
call_hhgit_func() {
    local func="$1"
    local input_dir="$2"
    local output_file="'$3'"
    local input_files
    while [ $# -gt 3 ]; do
        input_files="${input_files}, '${input_dir}/$4'"
        shift
    done
    input_files="${input_files:2}"
    PYTHONPATH="${SCRIPT_DIR}" python -c \
        "import hhgit; hhgit.${func}([${input_files}], ${output_file})"
}

###############################################################################
# Call to_text function from hhgit.py
###############################################################################
to_text() {
    call_hhgit_func to_text "${IMG_DIR}" "$@"
}

###############################################################################
# Call from_text function from hhgit.py
###############################################################################
from_text() {
    call_hhgit_func from_text "." "$@"
}

###############################################################################
# Generate data file from images and create/append appropriate COMMIT_MESSAGE
# Arguments:
#   First  - output data file
#   Others - set of images
###############################################################################
gen_data() {
    [ -z "$(git status --porcelain)" ] && COMMIT_MESSAGE="" \
                                       || COMMIT_MESSAGE="${COMMIT_MESSAGE}, "
    COMMIT_MESSAGE="${COMMIT_MESSAGE}[${@:2}] -> $1"
    to_text "$@"
}

# Do main logic
git init "${REPO_NAME}"
cd "${REPO_NAME}"
gen_data main.data init.png
git add main.data
git commit -m "init ${COMMIT_MESSAGE}"

git branch rc

git checkout -b bugfix
gen_data main.data init.png bugfix.png
git commit -am "bugfix ${COMMIT_MESSAGE}"

git checkout rc
git merge bugfix

git checkout master
git checkout -b feature1
gen_data main.data refactoring.png init.png init.png
git commit -am "feature1 ${COMMIT_MESSAGE}"

git branch feature2

git checkout rc
git merge feature1 -m "merge feature1"

git checkout feature1
gen_data ground.data refactoring.png
gen_data main.data init.png init.png
git add ground.data
git commit -am "feature1-refactoring ${COMMIT_MESSAGE}"

git checkout rc
git merge feature1 -m "merge feature1"

git checkout feature2
gen_data main.data refactoring.png init.png feature2.png init.png
git commit -am "feature2 ${COMMIT_MESSAGE}"

git checkout rc
git merge feature2 -m "merge feature2"

git checkout master
git merge rc

# Rewrite all commits
git filter-branch --tree-filter '
    for data_file in *.data; do
        echo "# 16\n$(cat $data_file)" > $data_file
    done
' -- --all

git log --graph --decorate --oneline
