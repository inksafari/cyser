#!/usr/bin/env bash

# Install Golang on Ubuntu Linux
# ----------------------------------------------------------------------
# or https://gist.github.com/jacoelho/fb989f8c25c3ca7d5db5
# copied and modified from https://gist.github.com/jniltinho/8758e15a9ef80a189fce
#
# usage:
# sudo chmod u+x ~/bin/gosrc.sh && bash ~/bin/gosrc.sh && go version && go env

GO_URL="https://storage.googleapis.com/golang"
GO_VERSION=${1:-"1.7.1"}                         # https://golang.org/dl/
GO_FILE="go$GO_VERSION.linux-amd64.tar.gz"
GO_ROOT=$HOME/.local/share/golang                # source code of Golang
GO_PATH=$HOME/.local/lib/go                      # Go packages

#DISTRO=`lsb_release -ds | awk -F ' ' '{printf $1}' | tr A-Z a-z`
#DISTRO_VERSION=`lsb_release -cs`

rm -rf ${GO_ROOT} && mkdir ${GO_ROOT}

if [ ! -d ${GO_PATH} ]; then
    mkdir ${GO_PATH}
fi

cd $HOME
wget --no-check-certificate ${GO_URL}/${GO_FILE}
tar -xzf ${GO_FILE} -C ${GO_ROOT}
rm ${GO_FILE}
echo 'Done!'

