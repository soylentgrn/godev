require 'spec_helper'

describe "Test zookeeper package successfully installed and service successfully started" do

  describe package('zookeeper') do
    it { should be_installed }
  end

  describe service('zookeeper-server') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(2181) do
    it { should be_listening }
  end
end

describe "Test postgresql-9.4 package successfully installed and service successfully started" do
  describe package('postgresql94-server') do
    it { should be_installed }
  end

  describe package('postgresql94-contrib') do
    it { should be_installed }
  end

  describe service('postgresql-9.4') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(5432) do
    it { should be_listening }
  end
end

describe "Test rabbitmq packages successfully installed and service successfully started" do
  describe package('java-1.8.0-openjdk') do
    it { should be_installed }
  end

  describe package('erlang') do
    it { should be_installed }
  end

  describe package('rabbitmq-server') do
    it { should be_installed }
  end

  describe service('rabbitmq-server') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(15672) do
    it { should be_listening }
  end
end
describe "Test expected golang package version successfully installed" do
  describe command('/usr/local/go/bin/go version') do
    its(:stdout) { should match /go version go1.8.1 linux\/amd64/ }
  end
end

describe "Test that 'go get github.com/derekparker/delve/cmd/dlv' successfully run" do
  describe file('/home/vagrant/work/bin/dlv') do
    it { should exist }
  end
end

describe "Test that yum group 'Development Tools' successfully installed" do
  describe command("yum grouplist | sed '/^Installed Groups:/,$!d;/^Available Groups:/,$d;/^Installed Groups:/d;s/^[[:space:]]*//'") do
    its(:stdout) { should contain('Development Tools') }
  end
end
