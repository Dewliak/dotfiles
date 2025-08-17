#!/bin/bash

sudo dnf install gcc
sudo dnf install python
sudo dnf install geany
sudo dnf install

sudo dnf install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.spotify.Client
flatpak install flathub org.ferdium.Ferdium

sudo dnf copr enable haemka/pycharm-professional
sudo dnf install pycharm-professional

sudo dnf copr enable coder966/intellij-idea-ultimate
sudo dnf install intellij-idea-ultimate

sudo dnf install libreoffice 
sudo dnf install discord

sudo dnf install java-latest-openjdk.x86_64
sudo dnf install java-latest-openjdk-devel.x86_64
flatpak install flathub com.bitwarden.desktop
