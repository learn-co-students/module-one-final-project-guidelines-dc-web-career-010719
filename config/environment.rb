ENV['RAILS_ENV'] ||="development"
require 'bundler'


Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: "db/#{ENV['RAILS_ENV']}.sqlite"
)
require_all 'lib'

ActiveRecord::Base.logger = nil

# to run tests type RAILS_ENV="test" rspec
