#!/bin/bash

mkdir /var/run/sshd

# cat <<EOF
# ACCESS_KEY：${ACCESS_KEY}
# SECRET_KEY: ${SECRET_KEY}
# USER_NAME ：${USER_NAME}
# EOF

if [ "${USER_NAME}" == "" ];then
  echo "use default USER_NAME 'ubuntu'"
  USER_NAME="ubuntu"
fi

# create an ubuntu user
PASS=$(date +%s |sha256sum |base64 |head -c 32 ;echo)
echo "User: ${USER_NAME} Pass: $PASS"
useradd --create-home --shell /bin/bash --user-group --groups adm,sudo ${USER_NAME}
echo "${USER_NAME}:$PASS" | chpasswd

if [ "${ACCESS_KEY}" != "" ] || [ "${SECRET_KEY}" != "" ];then
  mkdir /home/${USER_NAME}/.hyper
  cat > /home/${USER_NAME}/.hyper/config.json <<EOF
{
	"auths": {
	},
	"clouds": {
		"tcp://us-west-1.hyper.sh:443": {
			"accesskey": "${ACCESS_KEY}",
			"secretkey": "${SECRET_KEY}"
		}
	}
}
EOF
  chown ${USER_NAME}. /home/${USER_NAME} -R
else
  cat <<EOF
Please run 'hyper config' first
If you have not Hyper_ Credential, please create it at https://console.hyper.sh
EOF
fi


/usr/sbin/sshd
cd /tty.js && node ./tty-me.js --daemonize

while [ 1 ]; do
    /bin/bash
done
