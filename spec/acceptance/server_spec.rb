require 'spec_helper_acceptance'

describe 'Applying the r1soft::server class' do
  describe 'running r1soft::server with no parameters' do
    it 'should work with no errors' do
      pp = <<-EOS
         class {'::r1soft::server':}
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe package('serverbackup-manager') do
      it { should be_installed }
    end
  end
end
