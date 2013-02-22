class selinux::disable::redhat {
    service{restorecond:
        ensure => stopped,
        enable => false,
    }

    service{mcstrans:
        ensure => stopped,
        enable => false,
    }

    exec{disable_selinux_sysconfig:
        command => 'sed -i "s@^\(SELINUX=\).*@\1disabled@" /etc/sysconfig/selinux',
        unless => 'grep -q "SELINUX=disabled" /etc/sysconfig/selinux',
    }

    # Put selinux into permissive mode until the system can be rebooted
    if $::selinux_enforced {
        exec{disable_selinux_runtime:
            command  => '/usr/sbin/setenforce Permissive',
        }
    }
}
