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
          it { should contain_class('r1soft::agent::kernel_module') }
          it { should contain_class('r1soft::agent::service') }

          describe 'r1soft::repo' do
            it { should contain_yumrepo('r1soft').with_enabled('1') }
            it { should contain_yumrepo('r1soft').with_baseurl('http://repo.r1soft.com/yum/stable/$basearch/') }
            it { should contain_yumrepo('r1soft').with_gpgcheck('0') }
            it { should contain_yumrepo('r1soft').with_descr('r1soft') }
          end

          describe 'r1soft::agent::install' do
            it { should contain_package('serverbackup-agent').with_ensure('present') }
          end

          describe 'r1soft::agent::kernel_package' do
            it { should contain_package('kernel-devel').with_ensure('present') }
            # it { should contain_package('kernel-devel-${kernelrelease}').with_ensure('present') }
          end

          describe 'r1soft::agent::kernel_module' do
            it { should contain_exec('hcp-setup --get-module') }
          end

          describe 'r1soft::agent::service' do
            it { should contain_service('cdp-agent').with_ensure('running') }
            it { should contain_service('cdp-agent').with_enable('true') }
          end
        end
        context 'custom parameters' do

          describe 'r1soft::repo allow custom basurl' do
            let(:params) { {:repo_baseurl => 'http://example.com/yum/' } }
            it { should contain_yumrepo('r1soft').with_baseurl('http://example.com/yum/') }
          end
          describe 'r1soft::repo allow custom enabled' do
            let(:params) { {:repo_enabled => false } }
            it { should contain_yumrepo('r1soft').with_enabled('0') }
          end
          describe 'r1soft::repo allow custom gpgcheck' do
            let(:params) { {:repo_gpgcheck => true } }
            it { should contain_yumrepo('r1soft').with_gpgcheck('1') }
          end

          describe 'r1soft::agent::install allow custom ensure/version' do
            let(:params) { {:cdp_agent_package_version => '1.0.0' } }
            it { should contain_package('serverbackup-agent').with_ensure('1.0.0') }
          end
          describe 'r1soft::agent::install allow custom name' do
            let(:params) { {:cdp_agent_package_name => 'r1soft-agent' } }
            it { should contain_package('r1soft-agent') }
          end

          describe 'r1soft::agent::kernel_package allow custom packagename' do
            let(:params) { {:kernel_devel_package_names => ['custom-kernel-devel'] } }
            it { should contain_package('custom-kernel-devel') }
          end

          describe 'r1soft::agent::service with custom service name' do
            let(:params) { {:service_name => 'backup-agent' } }
            it { should contain_service('backup-agent') }
          end
          describe 'r1soft::agent::service with custom ensure' do
            let(:params) { {:service_ensure => 'stopped' } }
            it { should contain_service('cdp-agent').with_ensure('stopped') }
          end
          describe 'r1soft::agent::service with custom ensure' do
            let(:params) { {:service_enable => false } }
            it { should contain_service('cdp-agent').with_enable(false) }
          end

        end
      end
    end
  end
end
