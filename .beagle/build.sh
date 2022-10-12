#!/bin/sh

set -ex

# export ARTIFACT_PLATFORMS="linux-amd64 linux-arm64 linux-ppc64le linux-mips64le"
# export TEST_PLATFORMS="linux/amd64,linux/arm64,linux/ppc64le,linux/mips64le"

make artifacts
