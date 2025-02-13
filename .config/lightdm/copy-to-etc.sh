#!/bin/bash

# creates an empty directory in /etc (removes the existing directory if it exists)
sudo rm -rf /etc/lightdm
sudo mkdir /etc/lightdm

# copies the config files to /etc with root permissions

sudo cp -R /home/sully_vian/.config/lightdm/* /etc/lightdm
