require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

set :domain, '127.0.0.1'
set :user, 'server'
set :deploy_to, '/home/webapp/invest'
#set :repository, 'https://github.com/awesome_user/awesome.git'
#set :branch, 'master'

set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'config/puma.rb', 'log']

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/puma"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/puma"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/secrets.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/puma.rb"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml', 'secrets.yml' and puma.rb."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    #invoke :'rails:db_migrate'
    #invoke :'rails:assets_precompile'
    #invoke :'deploy:cleanup'
  end
end