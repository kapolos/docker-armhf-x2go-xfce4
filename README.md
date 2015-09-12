# docker-armhf-x2go-xfce4
Dockerfile for x2go/xfce4 on Ubuntu 14 armhf (ARMv7)

## Usage

Put your public key in the authorized_keys file

Build the docker file as usual

#### Example Execution

`docker run -d -p 0.0.0.0:2222:22 --name armhfx2go myimagename`
