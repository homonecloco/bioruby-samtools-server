# encoding: utf-8

require 'rubygems'
require 'bundler'

version = File.exist?('VERSION') ? File.read('VERSION') : ""

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "bio-samtools-server"
  gem.homepage = "http://github.com/homonecloco/bioruby-samtools-server"
  gem.license = "MIT"
  gem.summary = %Q{Web server for bio-samtools}
  gem.description = %Q{A minimal web service on the top of sinatra to query bam files}
  gem.email = "ricardo.ramirez-gonzalez@tgac.ac.uk"
  gem.authors = ["homonecloco"]
  gem.version = version
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['test'].execute
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bio-samtools-server #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
