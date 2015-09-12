FROM armv7/armhf-ubuntu

LABEL "kapolos.docker.image.name"="armhf-x2go-xfce-ubuntu" "kapolos.docker.image.desc"="Armhf x2go server on Ubuntu 14.04 with xfce 4" "kapolos.docker.image.version"="1.0" "kapolos.docker.image.x2go-version"="4.0.1.9" "kapolos.docker.image.ubuntu-version"="14.04"

# Add ssh keys
ADD authorized_keys /root/.ssh/authorized_keys

RUN mkdir /opt/prep
WORKDIR /opt/prep

# Install initial deps
RUN  apt-get install  --yes debhelper libpng-dev libjpeg-dev zlib1g-dev quilt libfontconfig1-dev libfontenc-dev libfreetype6-dev libxmltok1-dev libxml2-dev autoconf pkg-config x11proto-core-dev man2html-base expat nano 

# Install x2go binaries
ADD https://github.com/kapolos/armhf-x2go/archive/4.0.1.19.tar.gz /opt/prep/
RUN tar zxf 4.0.1.19.tar.gz
RUN dpkg -i /opt/prep/armhf-x2go-4.0.1.19/*.deb; exit 0
RUN apt-get -f install --yes
RUN dpkg -i /opt/prep/armhf-x2go-4.0.1.19/*.deb; exit 0

# Some tweaks for the next step
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8    
RUN locale-gen en_US.UTF-8  

# Install XFCE 4
RUN echo 29 | apt-get install --yes xfce4 xfce4-goodies xfce4-artwork xubuntu-icon-theme 

# Prepare for sshd
RUN mkdir -p /var/run/sshd

#Clean up
WORKDIR /tmp
RUN rm -rf /opt/prep
RUN apt-get clean

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
