#!/usr/bin/env bash
echo "You are connecting with User ${MYUSERNAME}"

ID=$(id -u)
#If we are root and we have give a MYUID different from default
if [ "$ID" -eq "0" ] && [ $MYUID != "" ]; then
    echo "Creating user $MYUSERNAME"
    groupadd -g $MYGID $MYUSERNAME || true
    useradd --uid $MYUID --gid $MYGID -s /bin/zsh --home /home/$MYUSERNAME $MYUSERNAME
    echo "${MYUSERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${MYUSERNAME}
    sudo chmod 0440 /etc/sudoers.d/${MYUSERNAME}

    echo "reset default env"
    export HOME=/home/${MYUSERNAME}
    su $MYUSERNAME
fi
echo "end of script"
