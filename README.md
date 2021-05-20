# Lab-Machines builds

Update 20.05.2021
- New Windows 10 20H2 Image
- Windows 10 1909 End Of Life 11. of May 2021

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
  - Ubuntu 18.04.5 LTS and Ubuntu 20.04.2 LTS
  - Virtualbox 6.1.22
  - Vagrant 2.2.16 with Virtualbox Extention 6.1.22 and plugin vagrant-reload (0.0.1, global)
  - Packer 1.7.2

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



