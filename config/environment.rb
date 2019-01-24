require 'bundler'
Bundler.require

ENV['RAIlS_ENV'] ||= "development"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: "db/#{ENV['RAILS_ENV']}.sqlite")

require_all 'lib'
require_all 'app'
# binding.pry
# DBRegistry[ENV["SINATRA_ENV"]].connect!
# DB = ActiveRecord::Base.connection

if ENV["SINATRA_ENV"] == "test"
  ActiveRecord::Migration.verbose = false
end

ActiveRecord::Base.logger = nil
