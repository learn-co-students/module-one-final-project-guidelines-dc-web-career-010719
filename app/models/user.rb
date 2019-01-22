class User < ActiveRecord::Base [4.2]
has_many :festivals, through: :planners
end
