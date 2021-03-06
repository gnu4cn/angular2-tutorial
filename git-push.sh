#!/usr/bin/env bash
TRIES=4

push () {
    git add *.md
    git add git-push.sh
    git add images/*.png
    git add images/*.gif
    git commit -m "$1"
    push_success=0
    push_tries=0
    until [ ${push_success} -eq 1 ] || [ ${push_tries} -gt ${TRIES} ]
    do
        git push
        if [ $? -eq 0 ]; then
            push_success=1
        fi;
        push_tries=$((push_tries+1))
    done
}

commit_msg=""

if [ "$1" == "" ]; then
    echo "No commit -m string."
    commit_msg="Daily update. `date "+%F %H:%M:%S"`"
    push "${commit_msg}"
else
    push "$1"
fi;
