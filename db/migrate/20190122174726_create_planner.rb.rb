class CreatePlanner < ActiveRecord::Migration[4.2]
  def change
    create_table :planners do |t|
      t.string :name
      t.integer :user_id
      t.integer :festival_id
    end
  end
end
