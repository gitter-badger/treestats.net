require 'bundler/setup'
Bundler.require(:default)

require 'sinatra/asset_pipeline/task'
require './app'
require 'resque/tasks'

task default: :test

# Sinatra Asset Pipeline
Sinatra::AssetPipeline::Task.define! TreeStats

# Resque
task "resque:setup" do
  ENV['QUEUE'] = '*'
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"

# Testing
task :test do
  Dir['./test/**/*spec.rb'].each { |f| load f }
end

# Other
task :github do
  puts '>> git branch github'
  `git branch github`

  branches = `git branch -v`
  puts branches

  puts '>> git filter-branch'
  `git filter-branch --index-filter 'git rm --cached --ignore-unmatch helpers/encryption_helper.rb' -f github`

  puts '>> git push --force github github'
  `git push --force github github:master`

  puts '>> git branch -D github'
  `git branch -D github`

  branches = `git branch -v`
  puts branches
end
