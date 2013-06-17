namespace :assets do
  desc "Install all assets with Bowery"
  task :install do
    sh 'bowery install'
  end

  desc "Compile and install all the assets named in config.assets.precompile"
  task :precompile => ['assets:install', 'assets:precompile:all']
end
