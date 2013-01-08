class AddAdmissionPeriodIdToGakuSchedulesTable < ActiveRecord::Migration
  def change
    change_table :gaku_schedules do |t|
      t.references :admission_period
    end
  end
end
