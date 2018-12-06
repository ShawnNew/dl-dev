# Set the base image
ARG CAFFE_VERSION=gpu
FROM bvlc/caffe:${CAFFE_VERSION}
LABEL author="niuchenxiao<niuc@mcmaster.ca>"

# change source
# http://mirrors.tuna.tsinghua.edu.cn/
# http://mirrors.ustc.edu.cn/
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

# Development
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    curl "https://packages.microsoft.com/keys/microsoft.asc" | gpg --dearmor > microsoft.gpg && \
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
    apt-get update && apt-get install -y \
    # Other developing tools, name them here
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

# For user
RUN adduser caffe --gecos "" --disabled-password &&\
    echo "abcd\nabcd" |passwd caffe &&\
    chsh -s /bin/zsh caffe &&\
    adduser caffe sudo &&\
    cd /home &&\
    chown -R caffe:caffe caffe &&\
    cd /home/caffe &&\
    su caffe

# Mount volume for data and codes
ADD README.md /home/caffe
WORKDIR /home/caffe
VOLUME ["/home/caffe/data","/home/caffe/codes"]


# For start the image
WORKDIR /home/caffe
USER caffe
# Configure oh-my-zsh
ENTRYPOINT bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 

