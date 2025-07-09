# Instruction

A Docker image is prepared to run the Geant4 examples. 
For your convenience, it is uploaded to Docker Hub: https://hub.docker.com/r/baikalschool/geant4

Please make sure you have setup Docker environment already. 
As a reference, installation of Docker in AlmaLinux 9 will be shown. 

If you are using Windows, you can consider to use WSL2 or VirtualBox. 

## Install Docker Engine in AlmaLinux9

If you have already installed the official Docker, please skip this section.

In some Linux distributions, some unofficial Docker could be installed. Please remove them first:
```bash
sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  podman \
                  runc
```

Then, add the YUM repo of Docker:
```bash
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
```

Install Docker:
```
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Start Docker:
```
sudo systemctl enable --now docker
```

Run hello-world in Docker:
```
sudo docker run hello-world
```

## Pull and start geant4 Docker container

Pull Docker image:
```
sudo docker pull baikalschool/geant4:el9
```

Start an instance:
```
sudo docker run -it baikalschool/geant4:el9 /bin/bash
```

If you have a slow network, you can consider to get a tarball from other people.

Save and load:
```
docker save -o baikalschool-geant4-el9.tar baikalschool/geant4:el9
docker load -i baikalschool-geant4-el9.tar
```

## Geant4 visualization with Docker container

If your system already setup X11 server, then you can configure your machine with following:
```
xhost +local:docker
```

Then create a container named baikal, with X11 configured:
```
docker run -it --name baikal -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix baikalschool/geant4:el9 /bin/bash
```

After the container is created, you can start it with following commands in the next time:
```
docker start baikal # if the container does not start. 
docker exec -it baikal /bin/bash
```
