#!/usr/bin/env rake

require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require "bundler/gem_tasks"

require 'rake/testtask'

desc 'Run test suite'
task 'test' do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.test_files = FileList['test/*_test.rb']
    t.verbose = true
  end
end

if ENV['TRAVIS']
  Rake::Task["test"].invoke
end
