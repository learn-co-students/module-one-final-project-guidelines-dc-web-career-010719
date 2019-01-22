class Festival < ActiveRecord::Base [4.2]
has_many :users, through: :planners
end
