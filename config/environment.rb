require 'bundler'
Bundler.require

<<<<<<< HEAD
ENV['RAIlS_ENV'] ||= "development"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: "db/#{ENV['RAILS_ENV']}.sqlite")

=======
>>>>>>> 3455890ee3f2ec3726c379a0d3828c0621069ffb
require_all 'lib'
require_all 'app'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

# if ENV["RAILS_ENV"] == "test"
#   ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/test.db')
#   ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# else
#   ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# end

# binding.pry
# DBRegistry[ENV["SINATRA_ENV"]].connect!
# DB = ActiveRecord::Base.connection

# if ENV["SINATRA_ENV"] == "test"
#   ActiveRecord::Migration.verbose = false
# end

ActiveRecord::Base.logger = nil
