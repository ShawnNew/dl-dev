## dl-dev (deep learning image and development support)
Support deep-learning platform list:

| Platform Name | Version | Language |
|---------------| :------:| --------:|
| Caffe    | 1.0.0   | C++, Python |
| Tensorflow | 1.12.0 | Python |

### Prerequesties
* GNU/Linux x86_64 with kernel version > 3.10
* Docker >= 1.12
* NVIDIA GPU with Architecture > Fermi (2.1)
* [NVIDIA](https://www.nvidia.com/object/unix.html) drivers ~= 361.93 (untested on older versions)


### How to use
* First, you should download docker yourself :). Check the following infomation:
    * For [Mac](https://docs.docker.com/docker-for-mac/install/#what-to-know-before-you-install).
    * For [Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/).
    * For [Windows](https://docs.docker.com/docker-for-windows/install/#install-docker-for-windows-desktop-app).
    
    However, I highly recommend you use unix-like system since docker is well-supported on such OS.
* After successfully installed docker, run command `sudo usermod -aG docker ${USER}` to add your self into user-group within system wide.
* Reboot.
* Then `cd scripts/` into scripts directory.
* Run `./start_working.sh` and wait until `zsh` shows up.
	![login](docs/docker-login.png)
* Run `bash /tmp/setup.sh` in the docker environment to create user for yourself.
* Then you can walk around, the docker environment is the same as outside the environment.

### About the docker container
* `zsh`: Use oh-my-zsh theme for shell, and support zsh functionalities. Kindly check this [websit](https://www.jianshu.com/p/d194d29e488c?open_source=weibo_search).
* `VS Code`： You can issue `code` in zsh, then the container will open IDE in host machine.
* `tmux`: The configuration of tmux is as default, you can check useful information in this [page](http://louiszhai.github.io/2017/09/30/tmux/).

### To build the docker image
To build customized docker iamge yourself, please check [build reference](dockerfile/README.md).

### Issues
Please contact `niuc@mcmaster.ca` for any issue.

