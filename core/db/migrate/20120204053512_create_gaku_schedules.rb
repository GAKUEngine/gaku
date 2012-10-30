class CreateGakuSchedules < ActiveRecord::Migration
  def change
    create_table :gaku_schedules do |t|
      t.datetime :starting
      t.datetime :ending
      t.string   :repeat

      t.timestamps
    end
  end
end
