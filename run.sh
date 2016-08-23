#!/bin/bash

ACCESS_KEY=
SECRET_KEY=
USER_NAME=

ARG_E=""
[ "${ACCESS_KEY}" != "" ] && ARG_E="${ARG_E} -e ACCESS_KEY=${ACCESS_KEY} "
[ "${SECRET_KEY}" != "" ] && ARG_E="${ARG_E} -e SECRET_KEY=${SECRET_KEY} "
[ "${USER_NAME}" != "" ] && ARG_E="${ARG_E} -e USER_NAME=${USER_NAME} "

CID=$(docker run -d ${ARG_E} -p 3000 xjimmyshcn/ttyjs)

CPORT=$(docker port $CID | awk -F":" '{print $NF}')
echo http://127.0.0.1:$CPORT

docker logs $CID
