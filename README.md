vagrant-lamp
============

Vagrantfile and Chef recipes for setting up a LAMP (Ubuntu Precise64) development environment.
Includes Oracle OCI8 support and mod_vhost_alias for easy virtual host setup.

Requirements
============
- Git
- VirtualBox
- Vagrant
- NFS:

  Shared folders are configured with NFS for easy permissions management and performance reasons.
  This seems to 'just work' on Mac OS X 10.8 Mountain Lion, on Debian/Ubuntu run `sudo apt-get install nfs-kernel-server`

Usage
=====
1. Clone
2. Check Vagrantfile defaults (Guest VM IP address, MySQL root password)
3. Run `vagrant up` inside project folder

```
$ git clone https://github.com/afhole/vagrant-lamp.git
$ cd vagrant-lamp
$ sudo true && vagrant up
```
New vhosts are created automatically by adding folders to 'vhosts' with the folder name matching the DNS name. 
Document root is 'www' inside each vhost. Add vhosts names to your hosts file, or setup dnsmasq with a wildcard, e.g. *.vm