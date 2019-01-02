# Set the base image
ARG CUDA_VERSION=9.0-cudnn7-devel-ubuntu16.04
FROM nvidia/cuda:${CUDA_VERSION} AS cuda_image
LABEL author="niuchenxiao<niuc@mcmaster.ca>"

# change source
# http://mirrors.tuna.tsinghua.edu.cn/
# http://mirrors.ustc.edu.cn/
FROM cuda_image
RUN bash -c 'sed -i "s#http://archive.ubuntu.com/#http://mirrors.ustc.edu.cn/#" /etc/apt/sources.list; \
             sed -i "s#http://security.ubuntu.com/#http://mirrors.ustc.edu.cn/#" /etc/apt/sources.list;' && \
    bash -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ xenial main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
# base
RUN apt-get update && apt-get upgrade -y  && apt-get install --no-install-recommends -y \
    apt-utils \
    apt-transport-https \
    ca-certificates openssl \
    curl &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*
ADD Montreal /tmp/localtime
# Development
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    curl "https://packages.microsoft.com/keys/microsoft.asc" | gpg --dearmor > microsoft.gpg && \
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
    apt-get update && apt-get install -y \
    # Other developing tools, name them here
    build-essential \
    libatlas-base-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    libleveldb-dev \
    liblmdb-dev \
    libopencv-dev \
    libprotobuf-dev \
    libsnappy-dev \
    protobuf-compiler \
    python-dev \
    python-numpy \
    python-pip \
    python-setuptools \
    python-scipy \
    python-tk \
    ssh htop tmux vim iputils-ping nginx aptitude gitg meld net-tools wget \
    git sudo zsh unzip zip screen \
    gcc gdb cppcheck libboost-all-dev cmake libxss1 \
    code &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Git lfs for large data
RUN apt-get update && apt-get install -y \
    software-properties-common python-software-properties &&\
    add-apt-repository ppa:git-core/ppa &&\
    apt-get update &&\
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash &&\
    apt-get install git-lfs &&\
    git lfs install &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*

# For caffe
ENV CAFFE_ROOT=/opt/caffe
WORKDIR $CAFFE_ROOT
COPY caffe $CAFFE_ROOT
RUN cd ${CAFFE_ROOT} &&\
    pip2 install --upgrade pip && \
    cd python && for req in $(cat requirements.txt) pydot; do pip install $req; done && cd .. && \
    git clone https://github.com/NVIDIA/nccl.git && cd nccl && make -j install && cd .. && rm -rf nccl && \
    mkdir build && cd build && \
    cmake -DUSE_CUDNN=1 -DUSE_NCCL=1 .. && \
    make -j8

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

# For Tensorflow
RUN pip2 install --upgrade tensorflow-gpu \
    opencv-python \
    python-dateutil \
    scikit-learn \
    matplotlib==2.0.2

EXPOSE 6006

# Add user
RUN adduser dl --gecos "" --disabled-password &&\
    echo "abcd\nabcd" | passwd dl &&\
    chsh -s /bin/zsh dl &&\
    adduser dl sudo &&\
    cd /home &&\
    chown -R dl:dl dl &&\
    cd /home/dl &&\
    mkdir -p Codes &&\
    chown -R dl:dl Codes &&\ 
    su dl 

ENV HOME=/home/dl
WORKDIR $HOME
# add oh-my-zsh configuration
COPY .oh-my-zsh $HOME/.oh-my-zsh
COPY .zshrc ${HOME}
USER dl
