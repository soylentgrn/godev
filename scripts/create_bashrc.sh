#! /bin/bash
if grep -q "GH_USER" /home/vagrant/.bashrc; then
  echo "GH_USER already set in /home/vagrant/.bashrc"
else
  echo "exporting GH_USER in /home/vagrant/.bashrc"
  echo "export GH_USER=${GH_USER}" >> ~/.bashrc
fi

if grep -q "GH_PASS" /home/vagrant/.bashrc; then
  echo "GH_PASS already set in /home/vagrant/.bashrc"
else
  echo "exporting GH_PASS in /home/vagrant/.bashrc"
  echo "export GH_PASS=${GH_PASS}" >> ~/.bashrc
fi
