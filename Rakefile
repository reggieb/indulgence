
require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
end

require 'standalone_migrations'
StandaloneMigrations::Tasks.load_tasks

task :console do
  require 'irb'
  require 'irb/completion'
  require 'indulgence' 
  ARGV.clear
  IRB.start
end