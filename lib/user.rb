class User < ActiveRecord::Base
has_many :festivals, through: :planners
end
