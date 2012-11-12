class CreateGakuAdmissionPeriods < ActiveRecord::Migration
  def change
    create_table :gaku_admission_periods do |t|
      t.string      :name
      t.boolean     :rolling
      t.integer     :seat_limit
      t.date        :admitted_on

      t.timestamps
    end
  end
end
