require 'spec_helper_acceptance'

describe 'Applying the r1soft::agent class' do
  describe 'running r1soft::agent with two keys ensured present' do
    it 'should work with no errors' do
      pp = <<-EOS
         class {'::r1soft::agent':
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

    describe kernel_module('hcpdriver') do
      it { should be_loaded }
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
end
