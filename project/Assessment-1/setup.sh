#!/usr/bin/bash
set -e

####### Install virtual env
virtualenv --clear venv -p=python3.6
#sleep 2

source venv/bin/activate

#Dependent Packages installation
pip install -r requirements.txt -q

#Setting up at background/ We can make a service for same
nohup python metrics-collector.py &

#Getting metrics

curl localhost:4444/metrics
