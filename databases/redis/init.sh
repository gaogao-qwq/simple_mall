#!/bin/sh
docker run -d -p 6379:6379 --name redis-stack-server redis/redis-stack-server:latest
