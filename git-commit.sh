#!/usr/bin/env bash

git add ./*.md
git add ./*.sh
commit_time=`date "+%F %H:%M:%S"`
git commit -m "Commit, ${commit_time}"
git push
