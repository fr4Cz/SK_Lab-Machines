# Lab-Machines builds

Update 22.06.2022
- New Windows 10 21H2 Image
- New Kali Linux 2022.2 Image
- Windows 10 1909 End Of (Life 11. of May 2021).

This repository contains Windows and Linux templates that can be used to create boxes for
Vagrant using Packer ([Website](https://www.packer.io))
([Github](https://github.com/Stian-Kristoffersen/Lab-Machines)).

This repo contains material and inspiration from https://github.com/StefanScherer/packer-windows and https://github.com/geerlingguy.

## Requirements

The following software must be installed/present on your local machine before you can use Packer to build any of these Vagrant boxes:

  - [Packer](http://www.packer.io/)
  - [Vagrant](http://vagrantup.com/)
  - [VirtualBox](https://www.virtualbox.org/)

  The boxes are testet on a Linux host running:
  - Ubuntu 18.04.5 LTS and Ubuntu 20.04.4 LTS
  - Virtualbox 6.1.34
  - Vagrant 2.2.19 with Virtualbox Extention 6.1.34 and plugin vagrant-reload (0.0.1, global)
  - Packer 1.8.2

  *install vagrant plugin:
  $ vagrant plugin install vagrant-reload

## Trouble with unstable Windows Virtual machines? 

Host machine running Ubuntu 20.04 and a Intel Gen 10 or Gen 11 processor?

Try use kernel parameter:

    split_lock_detect=off

    

## Usage

Make sure all the required software (listed above) is installed, then cd into one of the box directories and run:

    $ packer build box-config.json

    or use preconfigured build scipt 

    $ ./build.sh

After a several minutes - please be patient, Packer should tell you the box was generated successfully

## Testing built boxes

There's an included Vagrantfile that allows quick testing of the built Vagrant boxes. From the same box directory, run the following command after building the box:

Add box to the Vagrant local repository by:
    
    $ vagrant box add {your choosen name of the image} /builds/vagrant.box

    Comment: Make sure to adjust the choosen name in the Vagrantfile

    $ vagrant up

Test that the box works correctly, then tear it down with:

    $ vagrant destroy -f


## Labs

Ex. Labs\ActiveDirectory-Lab

If Private_Network is other than 192.168.56.0/24, remember to change static ip address to the ActiveDirectory DNS-server in the following files:

- /scripts/join-domain.ps1 
- /scripts/provision.ps1



