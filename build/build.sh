#!/bin/bash

docker build -t php-builder:8.2.10 -f php-builder.Dockerfile .
docker build -t symfony-cli:latest -f symfony-builder.Dockerfile .
docker build -t phpstorm-downloader:latest -f phpstorm-downloader.Dockerfile .
docker build -t phpstorm:latest .
