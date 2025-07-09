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

By default, the container is cached. If you want to auto-delete the container after it finishes, add option `--rm`.  

If it is hard to download the image in your network, you can consider to get a tarball from other people.

Save and load an image:
```
docker save -o baikalschool-geant4-el9.tar baikalschool/geant4:el9
docker load -i baikalschool-geant4-el9.tar
```

## Geant4 visualization with Docker container

If your system (host) already setup X11 server, then you can configure your machine with following:
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

## Build and run the first example B1
If you are not inside the container yet, please run:
```bash
docker exec -it baikal /bin/bash
```

If there is no error, you will be inside a new shell, such as:
```bash
[root@4dd0a1204699 build]# 
```

If it is the first time you start the container, you will see nothing inside the `/build` directory:
```
[root@4dd0a1204699 build]# ls
```

You can copy the example B1 from following directory:
```
[root@4dd0a1204699 build]# cp -r /opt/geant4/share/Geant4/examples/basic/B1 .
```

Then build this example with following command:
```bash
[root@4dd0a1204699 build]# cmake -S B1 -B B1-build # configure
[root@4dd0a1204699 build]# cmake --build B1-build  # build
```

If you see following output, that means the example is built successfully:
```
[ 12%] Building CXX object CMakeFiles/exampleB1.dir/exampleB1.cc.o
[ 25%] Building CXX object CMakeFiles/exampleB1.dir/src/ActionInitialization.cc.o
[ 37%] Building CXX object CMakeFiles/exampleB1.dir/src/DetectorConstruction.cc.o
[ 50%] Building CXX object CMakeFiles/exampleB1.dir/src/EventAction.cc.o
[ 62%] Building CXX object CMakeFiles/exampleB1.dir/src/PrimaryGeneratorAction.cc.o
[ 75%] Building CXX object CMakeFiles/exampleB1.dir/src/RunAction.cc.o
[ 87%] Building CXX object CMakeFiles/exampleB1.dir/src/SteppingAction.cc.o
[100%] Linking CXX executable exampleB1
[100%] Built target exampleB1
```