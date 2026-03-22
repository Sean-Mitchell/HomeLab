1. [Download](https://developer.hashicorp.com/vagrant/downloads)
1. Open cmd in the /Vagrant folder
1. Run `vagrant init bento/ubuntu-24.04`
1. Modify the output Vagrantfile to have 
    - 12GB of RAM
    - 10 CPU cores
    - 40GB Primary disk
    - inits with a GUI
    - custom name of `Homelab-test`
1. Run `vagrant up` from the `/Vagrant/` folder
    - Provisioner will get auto downloaded
    - The `/Vagrant/` folder should get mounted as the default shared drive