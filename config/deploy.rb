# config valid only for Capistrano 3.1
lock '3.9'

############################################
# Setup WordPress
############################################

config = YAML::load_file('./config/config.yml')

set :local_domain, config['development_url']

############################################
# Setup project
############################################

set :application, "chappress"
set :repo_url, "git@github.com:spence-man/blogsCapMix.git"
set :scm, :git

set :git_strategy, SubmoduleStrategy

############################################
# Setup Capistrano
############################################

set :log_level, :debug
set :use_sudo, false
set :pty, true

set :ssh_options, {
  forward_agent: true
}

set :keep_releases, 5

############################################
# Linked files and directories (symlinks)
############################################

set :linked_files, %w{wp-config.php}
set :linked_dirs, %w{content/uploads}

namespace :deploy do

  after 'starting', 'check_changes'

  desc "create WordPress files for symlinking"
  task :create_wp_files do
    on roles(:app) do
      execute :touch, "#{shared_path}/wp-config.php"
    end
  end

  after 'check:make_linked_dirs', :create_wp_files

  desc "Creates robots.txt for non-production envs"
  task :create_robots do
  	on roles(:app) do
  		if fetch(:stage) != :production then

		    io = StringIO.new('User-agent: *
Disallow: /')
		    upload! io, File.join(release_path, "public/robots.txt")
        execute :chmod, "644 #{release_path}/public/robots.txt"
      end
  	end
  end

  # desc "Restart services"
  # task :restart_services do
  #   on roles(:app) do
  #     execute "sudo systemctl restart php-fpm.service"
  #     execute "sudo systemctl restart nginx.service"
  #   end
  # end
  
  desc "Wp Core Install"
  task :core_install do
    on roles(:app) do
      execute "cd '#{release_path}/current/public'; wp core install --url=http://localhost:5555/ --title=chap-press --admin_user=chappress --admin_password=password --admin_email=chappress@gmail.com"
    end
  end

  after :finished, :create_robots
  #after :finished, :restart_services
  after :finished, :core_install
  after :finished, :clear_cache
  after :finishing, "deploy:cleanup"

  after :finished, 'prompt:complete' do 
    print_success("Deployment to #{fetch(:stage_domain)} complete!")
  end

  # Does not work for some reason
  # after :finished, 'prompt:clone' do
  #   invoke 'clone' if (fetch(:stage) != :production && confirm('Would you like to also re-clone production server data at this time?'))
  # end

end
