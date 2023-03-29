FROM centos:7.8.2003
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y groupinstall "X Window System" && \
    yum -y install firefox mate-system-monitor git lxde-common tightvnc-server wget && \
    yum clean all
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz
RUN tar -xvf v1.2.0.tar.gz
RUN mkdir  /root/.vnc
RUN echo 'mrmy' | vncpasswd -f > /root/.vnc/passwd
RUN chmod 600 /root/.vnc/passwd
RUN cp /noVNC-1.2.0/vnc.html /noVNC-1.2.0/index.html
RUN echo 'cd /root' >>/luo.sh
RUN echo "su root -l -c 'vncserver :2000 ' "  >>/luo.sh
RUN echo 'cd /noVNC-1.2.0' >>/luo.sh
RUN echo './utils/launch.sh  --vnc localhost:7900 --listen 80 ' >>/luo.sh
RUN echo root:laoluoshushu|chpasswd
RUN chmod 755 /luo.sh
EXPOSE 80
CMD  /luo.sh
