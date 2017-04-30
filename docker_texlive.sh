#!/usr/bin/env bash

    home=/home/lion
work_dir=${home}/${PWD//*\//}
   image=texlive-full
    path=/usr/local/bin:/usr/bin:/usr/local/bin:/usr/local/texlive/2014/bin/x86_64-linux
 command=$(basename $0)

#echo docker run -ti --rm    \
docker run -ti --rm    \
  -v `pwd`:${work_dir} \
  -w ${work_dir}       \
  --name=${command}    \
  -e PATH=${path}      \
  ${image}             \
  ${command} $@

exit 0
