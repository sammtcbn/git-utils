#!/bin/bash
ME=$(basename $0)

ip=
id=
pw=
destpath=

function interactive_question ()
{
    if [ "${ip}" == "localhost" ]; then
        echo install to remote ssh ip: localhost
    elif [ -z "${ip}" ]; then
        read -p "install to remote ssh ip: [localhost] " ip
    else
        echo install to remote ssh ip: ${ip}
    fi

    if [ -z "${ip}" ]; then
        ip=localhost
    else
        read -p "login id: " id
        if [ -z "${id}" ]; then
            exit 1
        fi
        printf "login password: "
        read -s pw
        if [ -z "${pw}" ]; then
            printf "\n"
            exit 1
        fi
        printf "*\n"
    fi

    if [ "${ip}" == "localhost" ]; then
        destpath=~/bin
    else
        destpath=/home/${id}/bin
    fi

    read -p "install path ? [${destpath}] " tmppath

    if [ ! -z "${tmppath}" ]; then
        destpath=tmppath
    fi

    if [ "${ip}" == "localhost" ]; then
        read -p "Are you sure you want to install to ${destpath} ? [y/N] " ins
    else
        read -p "Are you sure you want to install to ${id}@${ip}:${destpath} ? [y/N] " ins
    fi

    if [ "${ins}" != "y" ] && [ "${ins}" != "Y" ]; then
        exit 1
    fi
}

function cmd_exists ()
{
    if ! type $1> /dev/null 2>&1; then
        return 1
    else
        return 0
    fi
}

function remote_exec ()
{
    if cmd_exists sshpass ; then
        sshpass -p ${pw} ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${id}@${ip} ${@}
    else
        ssh ${id}@${ip} ${@}
    fi
}

function install_to_local ()
{
    local src=$1
    mkdir -p ${destpath} || exit 1
    cp -rf ${src}/* ${destpath} || exit 1
}


function install_to_remote ()
{
    local src=$1
    remote_exec mkdir -p ${destpath}

    for f in ${src}/*; do
        echo ${f}

        if [[ -d ${f} ]]; then
            if cmd_exists sshpass ; then
                sshpass -p ${pw} scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r $f ${id}@${ip}:${destpath}
            else
                scp -r $f ${id}@${ip}:${destpath}
            fi
        elif [[ -f ${f} ]]; then
            if cmd_exists sshpass ; then
                sshpass -p ${pw} scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $f ${id}@${ip}:${destpath}
            else
                scp $f ${id}@${ip}:${destpath}
            fi
        else
            echo "$f not found"
        fi
      done
}

if [ $# -eq 1 ]; then
    ip=${1}
    if [ "${ip}" == "localhost" ]; then
        destpath=~/bin
    else
        interactive_question
    fi
elif [ $# -eq 3 ]; then
    ip=${1}
    id=${2}
    pw=${3}
    destpath=/home/${id}/bin
elif [ $# -eq 4 ]; then
    ip=${1}
    id=${2}
    pw=${3}
    destpath=${4}
else
    interactive_question
fi

if [ "${ip}" == "localhost" ]; then
    echo install to ${destpath} ...
    install_to_local script_linux
    git config --global color.diff auto
    git config --global color.status auto
    git config --global color.branch auto
    git config --global color.log auto
else
    echo install to ${id}@${ip}:${destpath} ...
    install_to_remote script_linux
    remote_exec git config --global color.diff auto
    remote_exec git config --global color.status auto
    remote_exec git config --global color.branch auto
    remote_exec git config --global color.log auto
fi

echo "done"
