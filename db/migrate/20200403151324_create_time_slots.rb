class CreateTimeSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :time_slots do |t|
      t.string :weekday
      t.integer :start_hour
      t.integer :start_min
      t.integer :end_hour
      t.integer :end_min
      t.integer :role_id
      t.boolean :daily
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
