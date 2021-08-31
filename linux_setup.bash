#!/bin/bash
ME=$(basename $0)

ip=
id=
pw=

src=script_linux
localdest=~/bin
remotedest=/home/${id}/bin

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
  mkdir -p ${localdest} || exit 1
  cp -rf ${src}/* ${localdest} || exit 1

  git config --global color.diff auto
  git config --global color.status auto
  git config --global color.branch auto
  git config --global color.log auto
}

function install_to_remote ()
{
  remote_exec mkdir -p ${remotedest}

  for f in ${src}/*; do
    echo ${f}

    if [[ -d ${f} ]]; then
        if cmd_exists sshpass ; then
            sshpass -p ${pw} scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r $f ${id}@${ip}:${remotedest}
        else
            scp -r $f ${id}@${ip}:${remotedest}
        fi
    elif [[ -f ${f} ]]; then
        if cmd_exists sshpass ; then
            sshpass -p ${pw} scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $f ${id}@${ip}:${remotedest}
        else
            scp $f ${id}@${ip}:${remotedest}
        fi
    else
        echo "$f not found"
    fi
  done

  remote_exec git config --global color.diff auto
  remote_exec git config --global color.status auto
  remote_exec git config --global color.branch auto
  remote_exec git config --global color.log auto
}

if [ -z "${ip}" ]; then
    echo install to ${localdest} ...
    install_to_local
else
    echo install to ${id}@${ip}:${remotedest} ...
    install_to_remote
fi

echo "done"
