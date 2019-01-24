require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

require_all 'lib'
require_all 'app'
# binding.pry
# DBRegistry[ENV["SINATRA_ENV"]].connect!
# DB = ActiveRecord::Base.connection

if ENV["SINATRA_ENV"] == "test"
  ActiveRecord::Migration.verbose = false
end

ActiveRecord::Base.logger = nil
