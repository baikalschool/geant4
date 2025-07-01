# Description
# 
# Create an image:
#
#   $ docker build -t baikalschool/geant4:el9 .
#
# Push an image to dockerhub
#
#   $ docker push baikalschool/geant4:el9
#
# Pull an image from dockerhub
#
#   $ docker pull baikalschool/geant4:el9
#
# Save an image to tarball:
#
#   $ docker save -o baikalschool-geant4-el9.tar baikalschool/geant4:el9
#
# Load an image from tarball:
#
#   $ docker load -i baikalschool-geant4-el9.tar
#

FROM almalinux:9

ENV GEANT4_VERSION=11.3.2
ENV DEBIAN_FRONTEND=noninteractive
ENV CMAKE_PREFIX_PATH=/opt/geant4
ENV GEANT4_DIR=/opt/geant4/lib/Geant4-${GEANT4_VERSION}

# Install required tools and libraries
RUN dnf -y install epel-release && \
    dnf -y groupinstall "Development Tools" && \
    dnf -y install \
        cmake \
        wget \
        git \
        qt5-qtbase-devel \
        mesa-libGL-devel \
        mesa-libGLU-devel \
        libXmu-devel \
        libXi-devel \
        glew-devel \
        expat-devel \
        xerces-c-devel \
        zlib-devel \
        boost-devel \
        python3 \
        python3-pip \
        which \
        && dnf clean all

# Create build directory
WORKDIR /build

# Download and extract Geant4
RUN wget https://gitlab.cern.ch/geant4/geant4/-/archive/v${GEANT4_VERSION}/geant4-v${GEANT4_VERSION}.tar.gz && \
    tar -xzf geant4-v${GEANT4_VERSION}.tar.gz && \
    rm geant4-v${GEANT4_VERSION}.tar.gz

# Configure and build Geant4
RUN mkdir geant4-v${GEANT4_VERSION}-build && cd geant4-v${GEANT4_VERSION}-build && \
    cmake \
        -DCMAKE_INSTALL_PREFIX=/opt/geant4 \
        -DGEANT4_USE_QT=ON \
        -DGEANT4_USE_OPENGL_X11=ON \
        -DGEANT4_INSTALL_DATA=ON \
        -DGEANT4_BUILD_MULTITHREADED=ON \
        -DGEANT4_USE_GDML=ON \
        -DGEANT4_USE_SYSTEM_EXPAT=ON \
        ../geant4-v${GEANT4_VERSION} && \
    make -j"$(nproc)" && \
    make install && \
    rm -rf /build

# Set Geant4 environment variables
RUN echo "source /opt/geant4/bin/geant4.sh" >> /etc/profile.d/geant4.sh

# Default to bash shell
CMD ["/bin/bash"]

