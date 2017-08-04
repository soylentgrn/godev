# go-dev-box
Vagrant machine for golang development using Chef Bento maintained CentOS 7.3 image. Other Bento box files can be located here:
https://atlas.hashicorp.com/bento/

## To build

***PREREQS***
* VMware Fusion >= 6.0
* Vagrant with Fusion Plugin

***Components Installed***
* Zookeeper 3.4.5
* PostgreSQL 9.4
* RabbitMQ 3.3.5
* Golang 1.8.1
* Delve debugger for golang

***Getting up and running***

1. Create local environment variables for your GitHub credentials (these will also be added to ~/.bashrc inside the go-dev-box)

   `export GH_USER=user%40domain.com`
   `export GH_PASS=github_password`   

2. Install Gem Dependencies

    `bundle install`

3. Download puppet module described in Puppetfile

    `bundle exec rake modules`

4. Create and start the vagrant virtual machine

   `vagrant up`

5. Run serverspec tests to make sure all the components properly installed and are running

   `bundle exec rake spec`

6. Simplify downloading modules, creating the virtual machine and running serverspec tests into one easy step?

   `bundle exec rake go`

7. See `rake -T` for all available tasks

```
rake go               # go-dev-box first time install
rake modules          # downloads puppet module dependencies
rake psql             # open psql prompt within the go-dev-box vm
rake spec:go-dev-box  # run serverspec tests to go-dev-box
```
