require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require 'rdoc/task'
Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  rd.title = 'RPG-Simulator'
end

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.libs << "acceptation"
  t.test_files = FileList['test/*_test.rb', "test_acceptation/*_test.rb"]
end

task :default => [:test, :acceptation]