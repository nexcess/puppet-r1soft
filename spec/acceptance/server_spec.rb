require 'spec_helper_acceptance'

describe 'Applying the r1soft::server class' do
  describe 'running r1soft::server with a password parameter' do
    it 'should work with no errors' do
      pp = <<-EOS
         class {'::r1soft::server':
           admin_pass => 'secure_password',
         }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe package('serverbackup-enterprise') do
      it { should be_installed }
    end
    describe service('sbm-server') do
      it { should be_enabled }
      it { should be_running }
    end

  end
end
