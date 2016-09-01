#!/bin/bash

export GOPATH=/go
NATS_HOST=${NATS_HOST:-nats}

echo -n "test NATS Availability... "
r=1
i=0
while [[ $r -ne 0 ]]; do
  sleep 1
  curl -sI $NATS_HOST:8222 2>/dev/null | grep -q "HTTP/1.1 200 OK"
  r=$?
  ((i++))
  if [[ $i -gt 10 ]]; then break; fi
  echo -n "+"
done
if [[ $r -ne 0 ]]; then
  echo
  echo "$NATS_HOST:8222 failed"
  curl -I $NATS_HOST:8822
  exit 1
fi
echo " [OK]"

echo -n "run a subscriber... "
nohup go run /bin/nats-sub.go -s nats://$NATS_HOST:4222 msg.test &
r=1
i=0
while [[ $r -ne 0 ]]; do
  sleep 1
  grep -q "Listening on \[msg.test\]" nohup.out
  r=$?
  ((i++))
  if [[ $i -gt 3 ]]; then break; fi
  echo -n "+"
done
if [[ $r -ne 0 ]]; then
  echo
  echo "failed"
  cat nohup.out
  exit 1
fi
echo "[OK]"


echo -n "publish messages... "
go run /bin/nats-pub.go -s nats://$NATS_HOST:4222 msg.test "test message 1" 2>&1 | grep -q "Published \[msg.test\]"
if [[ $? -ne 0 ]]; then
  echo
  echo "failed"
  exit 1
fi
go run /bin/nats-pub.go -s nats://$NATS_HOST:4222 msg.test "test message 2" 2>&1 | grep -q "Published \[msg.test\]"
if [[ $? -ne 0 ]]; then
  echo
  echo "failed"
  exit 1
fi
echo "[OK]"

echo -n "receive messages... "
egrep -q "Received on \[msg.test\].*:.*'test message 1'" nohup.out
r=$?
if [[ $r -ne 0 ]]; then
  echo
  echo " message 1 failed"
  cat nohup.out
  exit 1
fi
egrep -q "Received on \[msg.test\].*:.*'test message 2'" nohup.out
r=$?
if [[ $r -ne 0 ]]; then
  echo
  echo "message 2 failed"
  cat nohup.out
  exit 1
fi
echo " [OK]"

echo "all tests passed successfully"
