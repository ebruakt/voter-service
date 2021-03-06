#!/bin/sh

# Checks if ELK is up (last container in stack to start)

HOST_IP=${1:-$(docker-machine ip worker3)}
ATTEMPTS=15
SLEEPTIME=20

until curl -s --head "${HOST_IP}:9200";
do
  echo "Attempt ${ATTEMPTS}..."

  if [ $ATTEMPTS -eq 0 ]
  then
    break
  fi

  echo "Waiting ${SLEEPTIME} more seconds to see if things are working..."

  sleep $SLEEPTIME
  let ATTEMPTS-=1
done

echo "Script completed..."
