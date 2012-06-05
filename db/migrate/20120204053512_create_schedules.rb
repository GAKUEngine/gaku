class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :start
      t.datetime :stop
      t.string :repeat

      t.timestamps
    end
  end
end
