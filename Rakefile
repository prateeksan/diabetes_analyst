require 'rake'
require 'csv'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  touch 'db/db.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/db.sqlite3'
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc 'Import food table'
task "get_food" do
  require './db/import/import_food.rb'
end

desc 'Import food table'
task "get_drugs" do
  require './db/import/import_drugs.rb'
end

desc 'Create fake data'
task "populate" do
  require './db/fake_data/fake_measurements.rb'
end