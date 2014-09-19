# Class: mule
#
# This module manages the Mule ESB community runtime.
#
# Parameters:
#
# $mule_install_dir::        Where mule will be installed
#
# $mule_version::            The version of mule to install.
#
# $mule_mirror::             The mirror to download from.
#
# $java_home::               Java installation.
#
# $user::                    The system user the mule process will run as.
#
# $group::                   The system group the mule process will run as.
#
# Actions:
#
#   Installs and manages the Mule ESB community runtime.
#
# Requires:
#   Module['Archive']
#   Class['java']
#
# Sample Usage:
#
# node default {
#   class { 'mule': }
# }
#
class mule(
# need to change to remote TODO
  $mule_mirror = 'http://192.168.0.16:8000',
#  $mule_version = '3.5.1',
  $mule_install_dir = '/opt',
  $java_home = '/usr/lib/jvm/default-java',
  $user = 'root',
  $group = 'root') {

  $basedir = "${mule_install_dir}/mule"
#  $dist = "mule-standalone-${mule_version}"
  $dist = 'AnypointStudio-for-linux-64bit-JUL14-201407180556'
  $dist_install_dir = 'AnypointStudio'
  $archive = "${dist}.tar.gz"

  archive { $dist:
    ensure   => present,
    url      => "${mule_mirror}/${archive}",
    target   => $mule_install_dir,
    checksum => false,
    timeout  => 0
#    strip_components => 1
  }

  file { $basedir:
    ensure  => 'link',
    target  => "${mule_install_dir}/${dist_install_dir}",
    require => Archive[$dist]
  }

  file { "${mule_install_dir}/${dist_install_dir}":
    ensure  => directory,
    owner   => $user,
    group   => $group,
    require => Archive[$dist]
  }

  file { '/etc/profile.d/mule.sh':
    mode    => '0755',
    content => "export MULE_HOME=${basedir}",
    require => File[$basedir]
  }

  file { '/etc/init.d/mule':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => template('mule/mule.init.erb'),
    require => File[$basedir]
  }

  file { "${mule_install_dir}/${dist_install_dir}/apps":
    ensure  => directory,
    owner   => $user,
    group   => $group,
    require => File[$basedir]
  }

  file { 'hello-world.zip':
    ensure  => file,
    path    => "${mule_install_dir}/${dist_install_dir}/apps/hello-world.zip",
    owner   => $user,
    group   => $group,
    mode    => '0755',
    require => File[$basedir],
    content => "puppet:///modules/mule/${conf_file}"
  }

  service { 'mule':
    ensure    => running,
    enable    => true,
    require   => File['/etc/init.d/mule'],
    hasstatus => false
  }

}
