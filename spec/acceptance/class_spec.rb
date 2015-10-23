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
                  
    describe 'Checking the results of r1soft::agent' do
      it 'install the package serverbackup-agent' do
        shell("rpm -q --quiet serverbackup-agent", :acceptable_exit_codes => 0)
      end

      it 'load kernel module hcpdriver' do
        shell("lsmod | grep -q hcpdriver", :acceptable_exit_codes => 0)
      end
    end
  end
end
