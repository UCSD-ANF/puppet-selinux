require 'spec_helper'

describe 'selinux', :type => 'class' do

  context "On a RedHat OS" do
    let :facts do
      {
        :osfamily => 'RedHat'
      }
    end

    it do
      should contain_package('setroubleshoot-server').with( {
        'ensure' => 'present'
      } )

      should contain_service('setroubleshoot').with( {
        'ensure'  => 'running',
        'enable'  => true,
      } )
    end

  end

  context "On a non-RedHat OS" do
    let :facts do
      {
        :osfamily => 'Solaris'
      }
    end

    it do
      should_not contain_package('setroubleshoot-server')
      should_not contain_service('setroubleshoot')
    end
  end

  context "With manage_munin specified" do
    let :params do
      {
        :manage_munin => true
      }
    end

    it {
      should contain_class('munin::plugins::selinux')
    }
  end

end
