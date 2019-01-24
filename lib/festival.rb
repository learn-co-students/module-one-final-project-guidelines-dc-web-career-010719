class Festival < ActiveRecord::Base
has_many :planners
has_many :users, through: :planners
end
