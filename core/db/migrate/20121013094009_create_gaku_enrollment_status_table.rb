class CreateGakuEnrollmentStatusTable < ActiveRecord::Migration
  def change
  	create_table :gaku_enrollment_status do |t|
      t.string  :name
      t.boolean :is_active
      t.boolean :immutable

      t.timestamps
  	end
  end
end
