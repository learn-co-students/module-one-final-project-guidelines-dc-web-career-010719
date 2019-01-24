class CreatePlanners < ActiveRecord::Migration[5.0]
  def change
    create_table :planners do |t|
      t.integer :user_id
      t.integer :festival_id
    end
  end
end
