#######################################
# selinux module - disable.pp
# Puzzle ITC - haerry+puppet(at)puzzle.ch
# GPLv3
#######################################

# disable selinux stuff
class selinux::disable {
    case $::osfamily {
        RedHat: { include selinux::disable::redhat }
    }
}
