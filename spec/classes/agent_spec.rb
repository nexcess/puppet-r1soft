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
            it { should contain_yumrepo('r1soft').with_baseurl('http://repo.r1soft.com/yum/stable/x86_64/') }
            it { should contain_yumrepo('r1soft').with_ensure('present') }
            it { should contain_yumrepo('r1soft').with_gpgcheck('1') }
            it { should contain_yumrepo('r1soft').with_gpgkey('https://www.ksplice.com/yum/RPM-GPG-KEY-ksplice') }
          end

          describe 'r1soft::agent::install' do
            it { should contain_package('serverbackup-agent').with_ensure('present') }
          end

          describe 'r1soft::agent::kernel_package' do
            it { should contain_package('kernel-devel').with_ensure('present') }
            # it { should contain_package('kernel-devel-${kernelrelease}').with_ensure('present') }
          end

          describe 'r1soft::agent::kernel_module' do
            it { should contain_exec('hcp-driver --get-module') }
          end

          describe 'r1soft::agent::service' do
            it { should contain_service('cdp-agent').with_ensure('running') }
            it { should contain_service('cdp-agent').with_enable('true') }
          end
        end
      end
    end
  end
end
