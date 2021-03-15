#!bin/bash
docker rmi -f ft_server
docker rm $(docker ps -a -f status=exited -q)