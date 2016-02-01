# Heroku VM

This is a Heroku ready Vagrant Box on Ubuntu 14.04.

## Installation

    $ vagrant up

You will be promoted for your password, since this box is configured to use NFS
for the /vagrant volume, which is *considerably* faster than the default
vboxfs.

## Usage

    $ vagrant ssh

SSH forwarding is enabled by default.

Put the following line in your `/etc/hosts` file to access in browser at `http://heroku.vm/`.

    192.168.21.12 heroku.vm

### File storage

The symlink in your home directory called ~/projects points into the /vagrant
directory. The /vagrant directory is where the Vagrantfile is stored on your
Mac. Put your projects in here if you want them to persist between rebuilds of
the VM.

### Provisioning

    $ vagrant provision

Or alternatively:

    $ vagrant destroy -f
    $ vagrant up
