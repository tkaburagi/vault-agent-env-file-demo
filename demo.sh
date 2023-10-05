#!/bin/sh

while true; do

echo
echo "==== KV DEMO APP ===="
echo "HELLO_KEY     = ${HELLO_KEY}"

ps -ef | grep demo.sh | grep -v grep
ps -ef | grep "vault agent" | grep -v grep

sleep 10

done