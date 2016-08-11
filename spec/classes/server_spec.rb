require 'spec_helper'

describe 'r1soft::server' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'with defaults for all parameters' do
          it { is_expected.to raise_error(/false is not a string/) }
        end

        context 'with defaults for all parameters except admin_pass' do
          let(:params) { {:admin_pass => 'secure_password' } }
          it { should contain_class('r1soft::server') }
          it { should contain_class('r1soft::repo') }
          it { should contain_class('r1soft::server::install') }
          it { should contain_class('r1soft::server::config') }
          it { should contain_class('r1soft::server::service') }

          describe 'r1soft::service::install' do
            it { should contain_package('serverbackup-enterprise').with_ensure('present') }
          end

          describe 'r1soft::service::service' do
            it { should contain_service('cdp-server').with_ensure('running') }
            it { should contain_service('cdp-server').with_enable('true') }
          end
        end
        context 'custom parameters' do
          describe 'r1soft::server::install allow custom ensure/version' do
            let(:params) { {:admin_pass => 'secure_password',
                            :cdp_server_package_version => '1.0.0'} }
            it { should contain_package('serverbackup-enterprise').with_ensure('1.0.0') }
          end
          describe 'r1soft::server::install allow custom name' do
            let(:params) { {:admin_pass => 'secure_password',
                            :cdp_server_package_name => 'r1soft-server' } }
            it { should contain_package('r1soft-server') }
          end
          describe 'r1soft::server::service with custom service name' do
            let(:params) { {:admin_pass => 'secure_password',
                            :service_name => 'backup-server'} }
            it { should contain_service('backup-server') }
          end
          describe 'r1soft::server::service with custom ensure' do
            let(:params) { {:admin_pass => 'secure_password',
                            :service_ensure => 'stopped'} }
            it { should contain_service('cdp-server').with_ensure('stopped') }
          end
        end
      end
    end
  end
end
