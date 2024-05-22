FROM alpine:latest
ARG SSH_VNC_PASSWORD
ARG WINBOX_ARCH
WORKDIR /
COPY ./docker-entrypoint.sh /

RUN <<EOF
chmod a+x /docker-entrypoint.sh
apk add --no-cache xfce4 firefox wine xterm tigervnc openssh-server
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
echo -n "root:${SSH_VNC_PASSWORD}" | chpasswd
mkdir -p /root/.vnc /root/Desktop /root/.config/xfce4/desktop /root/.config/xfce4/panel /root/.config/xfce4/xfconf/xfce-perchannel-xml
rm -rf /root/.config/xfce4/desktop/* /root/.config/xfce4/panel/* /root/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml /root/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
echo -n "${SSH_VNC_PASSWORD}" | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd
EOF

COPY ./application-$WINBOX_ARCH/ /root/
COPY ./shortcut-$WINBOX_ARCH/ /root/Desktop/
COPY ./config/ /root/.config/
ENTRYPOINT /docker-entrypoint.sh
LABEL org.opencontainers.image.title="alpine_xfce_vnc_firefox_winbox" org.opencontainers.image.version="1" org.opencontainers.image.authors="Growtopia Jaw growtopiajaw@gmail.com" org.opencontainers.image.description="linux/$WINBOX_ARCH"
EXPOSE 22/tcp
EXPOSE 5901/tcp
