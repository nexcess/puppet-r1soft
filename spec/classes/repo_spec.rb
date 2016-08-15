require 'spec_helper'

describe 'r1soft::repo' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        context 'with defaults for all parameters' do
          it { should contain_class('r1soft::repo') }
          describe 'r1soft::repo' do
            it { should contain_yumrepo('r1soft').with_enabled('1') }
            it { should contain_yumrepo('r1soft').with_baseurl('http://repo.r1soft.com/yum/stable/$basearch/') }
            it { should contain_yumrepo('r1soft').with_gpgcheck('0') }
            it { should contain_yumrepo('r1soft').with_descr('r1soft') }
          end
        end
        context 'custom parameters' do
          describe 'r1soft::repo allow custom basurl' do
            let(:params) { {:baseurl => 'http://example.com/yum/' } }
            it { should contain_yumrepo('r1soft').with_baseurl('http://example.com/yum/') }
          end
          describe 'r1soft::repo allow custom enabled' do
            let(:params) { {:enabled => false } }
            it { should contain_yumrepo('r1soft').with_enabled('0') }
          end
          describe 'r1soft::repo allow custom gpgcheck' do
            let(:params) { {:gpgcheck => true } }
            it { should contain_yumrepo('r1soft').with_gpgcheck('1') }
          end
        end
      end
    end
  end
end
