require 'rake/testtask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the flow_grid plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end
