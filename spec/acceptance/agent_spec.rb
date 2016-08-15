require 'spec_helper_acceptance'

describe 'Applying the r1soft::agent class' do
  describe 'running r1soft::agent with two keys ensured present' do
    it 'should work with no errors' do
    # we run tests on docker. the docker image will have whatever kernel version
    # the host is running. therefore our kernel-devel package will fail and the
    # hcpdriver module won't be built but we can still test for some simple
    # stuff
      pp = <<-EOS
         class {'::r1soft::agent':
           kernel_devel_install => false,
           keys => {'198.51.100.2' => {ensure => 'present', key => 'foo',},
                    '198.51.100.3' => {ensure => 'present', key => 'bar',}}
         }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe package('serverbackup-agent') do
      it { should be_installed }
    end

    describe service('cdp-agent') do
      it { should be_enabled }
      it { should be_running }
    end

    describe file('/usr/sbin/r1soft/conf/server.allow/198.51.100.2') do
      its(:content) { should match /foo/ }
    end

    describe file('/usr/sbin/r1soft/conf/server.allow/198.51.100.3') do
      its(:content) { should match /bar/ }
    end
  end

  describe 'running r1soft::agent with one key ensure present and one key ensure absent' do
    it 'should work with no errors' do
      pp = <<-EOS
         class {'::r1soft::agent':
           kernel_devel_install => false,
           keys => {'198.51.100.2' => {ensure => 'present', key => 'foo',},
                    '198.51.100.3' => {ensure => 'absent'}}
         }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe file('/usr/sbin/r1soft/conf/server.allow/198.51.100.2') do
      its(:content) { should match /foo/ }
    end
    describe file('/usr/sbin/r1soft/conf/server.allow/198.51.100.3') do
      it { should_not exist }
    end
  end

  describe 'running r1soft::agent with one key ensure present and keys_purge_unmanaged true' do

    # create file outside of the normal manifest so we can make sure it gets
    # purged later
    it 'should work with no errors' do
      unmanaged_file = <<-EOS
           exec{'/bin/mkdir -p /usr/sbin/r1soft/conf/server.allow/':}
           file{'/usr/sbin/r1soft/conf/server.allow/198.51.100.3':
             ensure => 'present',
             content => 'bar',
           }
      EOS
      apply_manifest(unmanaged_file, :catch_failures => true)

      pp = <<-EOS
         class {'::r1soft::agent':
           kernel_devel_install => false,
           keys => {'198.51.100.2' => {ensure => 'present', key => 'foo',}},
           keys_purge_unmanaged => true,
         }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe file('/usr/sbin/r1soft/conf/server.allow/198.51.100.2') do
      its(:content) { should match /foo/ }
    end
    describe file('/usr/sbin/r1soft/conf/server.allow/198.51.100.3') do
      it { should_not exist }
    end
  end

end
