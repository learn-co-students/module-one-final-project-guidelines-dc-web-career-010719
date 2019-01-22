class CreateFestival < ActiveRecord::Migration[4.2]
  def change
    create_table :festivals do |t|
      t.string :name
      t.string :location
      t.date :start_date
      t.date :end_date
      t.float :cost
    end
  end
end
