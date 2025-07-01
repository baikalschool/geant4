# Instruction

A docker container is used to run the Geant4 examples. Please make sure you have setup Docker environment already. 

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
