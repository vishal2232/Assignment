#!/bin/bash
read -p "Enter link to capture screenshot:" URL

docker run -it vishal2232/webscreenshot:latest $URL
