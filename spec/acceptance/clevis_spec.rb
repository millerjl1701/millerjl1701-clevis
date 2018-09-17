require 'spec_helper_acceptance'

describe 'clevis class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'clevis': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('clevis') do
      it { should be_installed }
    end

    describe package('clevis-dracut') do
      it { should be_installed }
    end

    describe package('clevis-luks') do
      it { should be_installed }
    end

    describe package('clevis-systemd') do
      it { should be_installed }
    end

    describe package('jose') do
      it { should be_installed }
    end

    describe package('luksmeta') do
      it { should be_installed }
    end

    describe service('clevis-luks-askpass.path') do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
