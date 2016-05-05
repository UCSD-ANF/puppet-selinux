class selinux::setroubleshoot {
  case $::osfamily {
    'RedHat': { include selinux::setroubleshoot::redhat }
  }
}
