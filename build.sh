#! /bin/bash

source ./.env

# For linux/amd64
docker build -f Dockerfile --push -t ghcr.io/growtopiajaw/alpine_xfce_vnc_firefox_winbox:latest --build-arg WINBOX_ARCH="amd64" --build-arg SSH_VNC_PASSWORD="${SSH_VNC_PASSWORD}" --platform linux/amd64 .
docker tag ghcr.io/growtopiajaw/alpine_xfce_vnc_firefox_winbox:latest ghcr.io/growtopiajaw/alpine_xfce_vnc_firefox_winbox:latest-amd64
docker push ghcr.io/growtopiajaw/alpine_xfce_vnc_firefox_winbox:latest-amd64

# For linux/i386
./buildx-binary/buildx build -f Dockerfile --push -t ghcr.io/growtopiajaw/alpine_xfce_vnc_firefox_winbox:latest-i386 --build-arg WINBOX_ARCH="i386" --build-arg SSH_VNC_PASSWORD="${SSH_VNC_PASSWORD}" --platform linux/i386 .
