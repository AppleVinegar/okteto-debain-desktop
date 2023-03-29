FROM centos:7.8
RUN yum update -y && \
    yum install firefox xorg-x11-server-Xvfb mate-system-monitor git lxde tigervnc-server wget -y && \
    curl -L https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz | tar zxvf -
RUN mkdir /root/.vnc
RUN echo 'mrmy' | vncpasswd -f > /root/.vnc/passwd
RUN chmod 600 /root/.vnc/passwd
COPY noVNC-1.2.0/vnc_lite.html noVNC-1.2.0/index.html
COPY noVNC-1.2.0/utils/launch.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/launch.sh
ADD start-vncserver.sh /
RUN chmod +x start-vncserver.sh
EXPOSE 80/tcp
CMD ["/start-vncserver.sh"]
