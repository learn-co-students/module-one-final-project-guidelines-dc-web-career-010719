class Festival < ActiveRecord::Base
has_many :users, through: :planners
end
