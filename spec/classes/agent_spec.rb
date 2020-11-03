require 'spec_helper'

describe 'r1soft::agent' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        context 'with defaults for all parameters' do
          it { should contain_class('r1soft::agent') }
          it { should contain_class('r1soft::repo') }
          it { should contain_class('r1soft::agent::kernel_package') }
          it { should contain_class('r1soft::agent::install') }
          it { should contain_class('r1soft::agent::service') }
          it { should contain_class('r1soft::agent::keys') }

          describe 'r1soft::agent::install' do
            it { should contain_package('serverbackup-agent').with_ensure('present') }
          end

          describe 'r1soft::agent::kernel_package' do
            it { should contain_package("kernel-devel-#{facts[:kernelrelease]}").with_ensure('present') }
          end

          describe 'r1soft::agent::service' do
            it { should contain_service('sbm-agent').with_ensure('running') }
            it { should contain_service('sbm-agent').with_enable('true') }
          end

          describe 'r1soft::agent::keys' do
            it { should_not contain_file('/usr/sbin/r1soft/conf/server.allow/') }
          end

        end
        context 'custom parameters' do
          describe 'r1soft::agent::install allow custom ensure/version' do
            let(:params) { {:package_version => '1.0.0' } }
            it { should contain_package('serverbackup-agent').with_ensure('1.0.0') }
          end
          describe 'r1soft::agent::install allow custom name' do
            let(:params) { {:package_name => 'r1soft-agent' } }
            it { should contain_package('r1soft-agent') }
          end

          describe 'r1soft::agent::kernel_package allow custom packagename' do
            let(:params) { {:kernel_devel_package_names => 'custom-kernel-devel' } }
            it { should contain_package('custom-kernel-devel') }
          end

          describe 'r1soft::agent::service with custom service name' do
            let(:params) { {:service_name => 'backup-agent' } }
            it { should contain_service('backup-agent') }
          end
          describe 'r1soft::agent::service with custom ensure' do
            let(:params) { {:service_ensure => 'stopped' } }
            it { should contain_service('sbm-agent').with_ensure('stopped') }
          end
          describe 'r1soft::agent::service with custom ensure' do
            let(:params) { {:service_enable => false } }
            it { should contain_service('sbm-agent').with_enable(false) }
          end

          describe 'r1soft::agent with repo_install = false' do
            let(:params) { {:repo_install => false } }
            it { should_not contain_yumrepo('r1soft') }
          end
          describe 'r1soft::agent with kernel_devel_install = false' do
            let(:params) { {:kernel_devel_install => false } }
            it { should_not contain_package("kernel-devel-#{facts[:kernelrelease]}").with_ensure('present') }
          end
          describe 'r1soft::agent with service_manage = false' do
            let(:params) { {:service_manage => false } }
            it { should_not contain_service('sbm-agent') }
          end
          describe 'r1soft::agent with keys_purge_unmanaged = true' do
            let(:params) { {:keys_purge_unmanaged => true } }
            it { should contain_file('/usr/sbin/r1soft/conf/server.allow/').with_purge(true) }
          end

        end
      end
    end
  end
end
