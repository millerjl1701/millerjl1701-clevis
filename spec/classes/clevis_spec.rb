require 'spec_helper'

describe 'clevis' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "clevis class without any parameters changed from defaults" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('clevis::install') }
          it { is_expected.to contain_class('clevis::config') }
          it { is_expected.to contain_class('clevis::service') }
          it { is_expected.to contain_class('clevis::install').that_comes_before('Class[clevis::config]') }
          it { is_expected.to contain_class('clevis::service').that_subscribes_to('Class[clevis::config]') }

          it { is_expected.to contain_package('clevis').with_ensure('present') }
          it { is_expected.to contain_package('clevis-dracut').with_ensure('present') }
          it { is_expected.to contain_package('clevis-luks').with_ensure('present') }

          it { is_expected.to contain_service('clevis-luks-askpass.path').with(
            'ensure'     => 'running',
            'enable'     => 'true',
            'hasstatus'  => 'true',
            'hasrestart' => 'true',
          ) }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'clevis class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('clevis') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
