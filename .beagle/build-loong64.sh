#!/bin/sh

git config --global --add safe.directory $PWD

set -ex

BUILD_VERSION="${BUILD_VERSION:-v0.4.8}"

export GOOS=linux
export GOARCH=loong64
go build -trimpath -ldflags "-s -w -extldflags -static -X github.com/regclient/regclient/internal/version.vcsTag=${BUILD_VERSION}" -tags nolegacy -o artifacts/regctl-${BUILD_VERSION}-linux-$GOARCH ./cmd/regctl/
go build -trimpath -ldflags "-s -w -extldflags -static -X github.com/regclient/regclient/internal/version.vcsTag=${BUILD_VERSION}" -tags nolegacy -o artifacts/regbot-${BUILD_VERSION}-linux-$GOARCH ./cmd/regbot/
go build -trimpath -ldflags "-s -w -extldflags -static -X github.com/regclient/regclient/internal/version.vcsTag=${BUILD_VERSION}" -tags nolegacy -o artifacts/regsync-${BUILD_VERSION}-linux-$GOARCH ./cmd/regsync/
