class selinux::setroubleshoot::disable {
  case $::osfamily {
    RedHat: { include selinux::setroubleshoot::disable::redhat }
  }
}
