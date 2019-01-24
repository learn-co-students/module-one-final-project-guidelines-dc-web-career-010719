class User < ActiveRecord::Base
has_many :planners
has_many :festivals, through: :planners
end
