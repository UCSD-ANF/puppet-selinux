class selinux::setroubleshoot::disable::redhat
inherits selinux::setroubleshoot::redhat {
  Service['setroubleshoot']{
    ensure => stopped,
    enable => false,
  }
}
