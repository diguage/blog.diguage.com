#!/bin/bash
#
# 构建脚本

base_dir=`pwd`

docker run -u $UID --privileged -v `pwd`:/antora --rm -t antora/antora --cache-dir=./.cache/antora --pull site.yml

echo ''
echo ''
echo "`date '+%Y-%m-%d %H:%M:%S'` build"
echo ''
echo ''

if [ -n "$1" ]; then
    cd ${base_dir}/public
    rsync -avz . deployer@notes.diguage.com:/home/deployer/diguage.com/blog
    echo "`date '+%Y-%m-%d %H:%M:%S'` deploy"
    echo ''
    echo ''
fi

cd ${base_dir}/public

python3 -m http.server $((1024 + RANDOM % 64511)) --bind 127.0.0.1
