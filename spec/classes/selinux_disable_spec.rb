require 'spec_helper'

describe 'selinux::disable' do

  context "On a RedHat OS" do
    let :facts do
      {
        :osfamily => 'RedHat'
      }
    end

    it {
      should contain_service('restorecond').with( {
        'ensure' => 'stopped',
        'enable' => false,
      } )

      should contain_service('mcstrans').with( {
        'ensure' => 'stopped',
        'enable' => false,
      } )

      should contain_exec('disable_selinux_sysconfig')
    }

    context "with SELinux enabled and enforcing" do
      # These are from facter, so true/false is presented as a string,
      # not a boolean
      let :facts do
        {
          :osfamily               => 'RedHat',
          'selinux'               => 'true',
          'selinux_config_mode'   => 'enforcing',
          'selinux_config_policy' => 'targeted',
          'selinux_current_mode'  => 'enforcing',
          'selinux_enforced'      => 'true',
          'selinux_mode'          => 'targeted',
          'selinux_policyversion' => '24',
        }
      end

      it { should contain_exec('disable_selinux_runtime') }
    end

    context "with SELinux enabled and permissive" do
      # These are from facter, so true/false is presented as a string,
      # not a boolean
      let :facts do
        {
          :osfamily               => 'RedHat',
          'selinux'               => 'true',
          'selinux_config_mode'   => 'enforcing',
          'selinux_config_policy' => 'targeted',
          'selinux_current_mode'  => 'permissive',
          'selinux_enforced'      => 'false',
          'selinux_mode'          => 'targeted',
          'selinux_policyversion' => '24',
        }
      end

      it { should_not contain_exec('disable_selinux_runtime') }
    end

    context "with SELinux disabled" do
      # These are from facter, so true/false is presented as a string,
      # not a boolean
      let :facts do
        {
          :osfamily               => 'RedHat',
          'selinux'               => 'false',
        }
      end

      it { should_not contain_exec('disable_selinux_runtime') }
    end

  end

end
