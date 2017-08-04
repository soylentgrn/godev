if [ ! -d /automation/plugins ]; then
  echo 'creating directory /automation/plugins since it does not exist'
  mkdir -p /automation/plugins
else
  echo '/automation/plugins directory already exists'
fi

chmod 777 /automation
chmod 777 /automation/plugins
