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

          describe 'r1soft::service::config' do
            it { should contain_file('/usr/sbin/r1soft/conf/.puppet_admin_pass').with_ensure('present') }
            it { should_not contain_file('/usr/sbin/r1soft/conf/.puppet_max_mem').with_ensure('present') }
            it { should contain_exec('setting http_port 80') }
            it { should contain_exec('setting https_port 443') }
          end
        end
        context 'custom parameters' do
          describe 'r1soft::server::install allow custom ensure/version' do
            let(:params) { {:admin_pass => 'secure_password',
                            :package_version => '1.0.0'} }
            it { should contain_package('serverbackup-enterprise').with_ensure('1.0.0') }
          end
          describe 'r1soft::server::install allow custom name' do
            let(:params) { {:admin_pass => 'secure_password',
                            :package_name => 'r1soft-server' } }
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
          describe 'r1soft::server::config with custom max_mem' do
            let(:params) { {:admin_pass => 'secure_password',
                            :max_mem => '4g'} }
            it { should contain_file('/usr/sbin/r1soft/conf/.puppet_max_mem').with_ensure('present') }         
          end

          describe 'r1soft::server::config with custom http and https ports' do
            let(:params) { {:admin_pass => 'secure_password',
                            :http_port  => '8080',
                            :https_port => '8443'} }
            it { should contain_exec('setting http_port 8080') }
            it { should contain_exec('setting https_port 8443') }
          end
        end
      end
    end
  end
end
