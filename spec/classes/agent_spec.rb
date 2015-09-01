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
        end
      end
    end
  end
end
