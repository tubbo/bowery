
namespace :assets do
  task :install do
    sh 'bowery install'
  end
end

Rake::Task["assets:precompile"].enhance do
  Rake::Task['assets:install'].invoke if defined? Bowery
end
