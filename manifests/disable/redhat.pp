class selinux::disable::redhat {
  service { 'restorecond': ensure => 'stopped', enable => false }
  service { 'mcstrans'   : ensure => 'stopped', enable => false }

  exec { 'disable_selinux_sysconfig':
    command => 'sed -i "s@^\(SELINUX=\).*@\1disabled@" /etc/sysconfig/selinux',
    unless  => 'grep -q "SELINUX=disabled" /etc/sysconfig/selinux',
    path    => ['/bin','/usr/bin','/sbin','/usr/sbin'],
  }

  # Put selinux into permissive mode until the system can be rebooted
  if str2bool($::selinux_enforced) {
    exec { 'disable_selinux_runtime' :
      command => 'setenforce Permissive',
      path    => ['/bin','/usr/bin','/sbin','/usr/sbin'],
    }
  }
}
