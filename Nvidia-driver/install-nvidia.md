# Documentation - install Nvidia Drivers and CUDA Toolkit
## Lenovo X1 Extreme with Ubuntu 18.04 LTS


## Blacklist Nvidia nouveau driver
$ sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
$ sudo bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf"

Confirm the content of the new modprobe config file:
$ cat /etc/modprobe.d/blacklist-nvidia-nouveau.conf
blacklist nouveau
options nouveau modeset=0

Update kernel initramfs:
Enter the following linux command to regenerate initramfs:
$ sudo update-initramfs -u

Reboot
$ sudo reboot

## Download Nvidia Drivers and Tollkit

$ wget https://developer.download.nvidia.com/compute/cuda/11.1.0/local_installers/cuda_11.1.0_455.23.05_linux.run

RUN the file:
sudo sh cuda_11.1.0_455.23.05_linux.run

"accept" The EULA and select at least drivers and CUDA Toolkit
