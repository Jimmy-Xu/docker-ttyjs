#!/bin/bash

CID=$(docker run -d -p 3000 xjimmyshcn/ttyjs)

CPORT=$(docker port $CID | awk -F":" '{print $NF}')
echo http://127.0.0.1:$CPORT

docker logs $CID
