class CreateGakuSchedules < ActiveRecord::Migration
  def change
    create_table :gaku_schedules do |t|
      t.datetime :starting
      t.datetime :ending
      t.string   :repeat
      t.references :admission_period

      t.timestamps
    end
  end
end
