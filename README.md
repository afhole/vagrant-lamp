vagrant-lamp
============

Vagrantfile and Chef recipes for setting up a LAMP (Ubuntu Precise64) development environment (including Oracle OCI8 support and mod_vhost_alias for easy virtual host setup, especially combined with local DNS wilcards via dnsmasq)

Usage
=====
clone the repo, cd into it and run 'sudo true && vagrant up'
Check Vangrantfile defaults - change guest IP address to be unique
New vhosts are created automatically by adding folders to 'vhosts' with the folder name matching the DNS name. 
Document root is 'www' inside each vhost. Add vhosts names to your hosts file, or setup dnsmasq with a wildcard, e.g. *.vm