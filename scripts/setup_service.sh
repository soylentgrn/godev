mkdir -p /home/vagrant/work/src/github.com/OVHUS
cd ~/work/src/github.com/OVHUS/
git config --global url."https://${GH_USER}:${GH_PASS}@github.com/".insteadOf "https://github.com/"

if [ ! -d /home/vagrant/work/src/github.com/OVHUS/bender ]; then
  echo 'performing a git clone on github.com/OVHUS/bender since /home/vagrant/work/src/github.com/OVHUS/bender does not exist'
  git clone https://${GH_USER}:${GH_PASS}@github.com/OVHUS/bender /home/vagrant/work/src/github.com/OVHUS/bender
fi
go get -u github.com/OVHUS/bender

if [ ! -d /home/vagrant/work/src/github.com/OVHUS/servicetemplate ]; then
  echo 'performing a git clone on github.com/OVHUS/servicetemplate since /home/vagrant/work/src/github.com/OVHUS/servicetemplate does not exist'
  git clone https://${GH_USER}:${GH_PASS}@github.com/OVHUS/servicetemplate /home/vagrant/work/src/github.com/OVHUS/servicetemplate
fi
go get -u github.com/OVHUS/servicetemplate

echo 'executing /home/vagrant/work/src/github.com/OVHUS/servicetemplate/eventstore.sql to create database tables, views and functions'
psql vagrant -a -f /home/vagrant/work/src/github.com/OVHUS/servicetemplate/eventstore.sql

if [ ! -d /home/vagrant/work/src/github.com/OVHUS/rest ]; then
  echo 'performing a git clone of github.com/OVHUS/rest since /home/vagrant/work/src/github.com/OVHUS/rest does not exist'
  git clone https://${GH_USER}:${GH_PASS}@github.com/OVHUS/rest /home/vagrant/work/src/github.com/OVHUS/rest
fi
go get -u github.com/OVHUS/rest

cd /home/vagrant/work/src/github.com/OVHUS/rest
go build

echo 'performing a copy of rest plugin to /automation/plugins/rest'
cp /home/vagrant/work/src/github.com/OVHUS/rest/rest /automation/plugins/
