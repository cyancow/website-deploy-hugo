#!/usr/bin/env bash

declare -A repos=( \
  ["https://github.com/imroc/assets.git"]="/var/www/assets" \
  ["https://github.com/imroc/imroc.io.git"]="/var/www/imroc.io" \
  ["https://github.com/imroc/learning-istio.git"]="/var/www/learning-istio" \
  ["https://github.com/imroc/learning-hugo.git"]="/var/www/learning-hugo" \
  ["https://github.com/imroc/learning-kubernetes.git"]="/var/www/learning-kubernetes" \
  ["https://github.com/imroc/learning-tke.git"]="/var/www/learning-tke" \
  ["https://github.com/imroc/learning-docker.git"]="/var/www/learning-docker" \
  ["https://github.com/yongdongchen/yongdongchen.github.io.git"]="/var/www/yongdongchen.github.io" \
)


function clone() {
  for repo in ${!repos[*]};do
    git clone --depth 1 $repo ${repos[$repo]}
    echo $repo
    echo ${repos[$repo]}
  done
}

function sync() {
  while true
  do
    sleep 10
    for path in "${repos[@]}";do
      cd $path
      echo "Pulling $path"
      git pull
    done
  done
}


if [ "$1" == "clone" ]; then
  clone
elif [ "$1" == "sync" ]; then
  sync
fi