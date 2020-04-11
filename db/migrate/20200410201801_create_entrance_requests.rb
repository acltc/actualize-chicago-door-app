class CreateEntranceRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :entrance_requests do |t|
      t.integer :user_id
      t.string :close_door_status
      t.string :close_elevator_status

      t.timestamps
    end
  end
end
