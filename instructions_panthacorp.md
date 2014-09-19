Instructions
------------

Using puppet playground, have forked and modified. Has modules set up, end users will need to add VM's as appropriate.

  $ git clone https://github.com/example42/puppet-playground.git puppet-playground



Optional Info
-------------

Base System
-----------

Base System Linux Mint Debian Edition [LMDE](http://www.linuxmint.com/download_lmde.php)

Newer [Vagrant](https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5_x86_64.deb)
  $ sudo dpkg -i /var/cache/apt/archives/vagrant_1.6.5_x86_64.deb

Newer [Puppet](https://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#for-debian-and-ubuntu)
NB: tweaked /etc/apt/preferences to preference the Pupplabs version.
  $ sudo dpkg -i puppetlabs-release-wheezy.deb
  $ sudo aptitude update
  $ sudo reinstall puppet

Installed [Puppet-Playground](https://puppetlabs.com/blog/testing-puppet-code-in-the-puppet-playground)

  $ cd src
  $ git clone https://github.com/example42/puppet-playground.git puppet-playground


Vargant Cache Error
-------------------

Bringing machine 'Ubuntu1404_64' up with 'virtualbox' provider...
There are errors in the configuration of this machine. Please fix
the following errors and try again:

Vagrant:
\* Unknown configuration section 'cache'.

https://github.com/computerminds/parrot/issues/33

    $ vagrant plugin install vagrant-cachier

Vagrantfile Changes
-------------------

Had to change some of the boxes to vagrantcloud because of timeouts in downloads.

Michael Tomkins 20140919
