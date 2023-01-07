#!/bin/bash

sudo yum install -y tmux wget docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker root
sudo usermod -aG docker ec2-user
