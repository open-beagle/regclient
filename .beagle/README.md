# version

<https://github.com/regclient/regclient>

```bash
git remote add upstream git@github.com:regclient/regclient.git

git fetch upstream

git merge v0.4.5
```

## debug

```bash
# cache
docker run -it \
--rm \
-v $PWD/:/go/src/github.com/regclient/regclient \
-w /go/src/github.com/regclient/regclient \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.19-alpine \
rm -rf vendor && go mod vendor

# build
docker run -it \
--rm \
-v $PWD/:/go/src/github.com/regclient/regclient \
-w /go/src/github.com/regclient/regclient \
-e VCS_TAG=v0.4.5 \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.19-alpine \
bash .beagle/build.sh

# check
ldd artifacts/regctl-linux-arm64
file artifacts/regctl-linux-arm64
```

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="regclient" \
  -e PLUGIN_MOUNT=".git,vendor" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="regclient" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
