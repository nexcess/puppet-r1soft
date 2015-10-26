require 'spec_helper_acceptance'

describe 'Applying the r1soft::agent class' do
  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
         class { 'r1soft::agent': }
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
  end
end
