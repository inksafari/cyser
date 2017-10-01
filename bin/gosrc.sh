#!/usr/bin/env bash
# Install Golang on Linux
# --------------------------------------------------
export GO_VERSION=${1:-"1.9"}           # https://golang.org/dl/
export GO_DOWNLOAD_URL="https://storage.googleapis.com/golang"
export GO_FILE="go$GO_VERSION.linux-amd64.tar.gz"
export GO_ROOT=$HOME/.local/lib/golang  # GOROOT ( source code of Golang )
export GO_PATH=$HOME/.local/lib/go      # GOPATH ( Golang pkgs )

rm -rf $GO_ROOT && mkdir -p $GO_ROOT/$GO_VERSION
test -d $GO_PATH || mkdir -p $GO_PATH

wget -q $GO_DOWNLOAD_URL/$GO_FILE{,.sha256}
echo "$(cat $GO_FILE.sha256) $GO_FILE" | sha256sum -c -

tar -C $GO_ROOT/$GOVERSION -xzf $GO_FILE
rm $GO_FILE{,.sha256}
echo "$(go version)"
echo "go to https://golang.org/doc/code.html and enjoy :D"
