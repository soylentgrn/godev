require 'rake'
require 'rspec/core/rake_task'

task :spec    => 'spec:all'

namespace :spec do
  targets = []
  Dir.glob('./spec/*').each do |dir|
    next unless File.directory?(dir)
    target = File.basename(dir)
    target = "_#{target}" if target == "default"
    targets << target
  end

  task :all     => targets
  task :default => :all

  targets.each do |target|
    original_target = target == "_default" ? target[1..-1] : target
    desc "Run serverspec tests to #{original_target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = original_target
      t.pattern = "spec/#{original_target}/*_spec.rb"
      t.fail_on_error = false
      t.rspec_opts = "--format documentation"
    end
  end
end

task :default do
  exec('rake -T')
end

def run_vagrant_command(cmd)
  $stdout.puts "Running #{cmd}. Press CTRL-C within 3 seconds if this isn't what you wanted!"
  sleep 3
  IO.popen(cmd).each_line do |line|
    puts line
  end
  rescue Interrupt
    puts "\n"
    Process.kill(9, -Process.getpgrp)
end

def run_ssh_command(cmd)
  system("vagrant ssh -c '#{cmd}'")
end

desc 'go-dev-box first time install'
task :go do
  Rake::Task['modules'].invoke
  run_vagrant_command('vagrant up')
  Rake::Task['spec:all'].invoke
end

desc 'downloads puppet module dependencies'
task :modules do
  $stdout.puts "Downloading Puppet modules for provisioning..."
  `r10k puppetfile install -v`
end

desc 'open psql prompt within the go-dev-box vm'
task :psql do
  run_ssh_command('/usr/bin/psql -h localhost -U postgres')
end
