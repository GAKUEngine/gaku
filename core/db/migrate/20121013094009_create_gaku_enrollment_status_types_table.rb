class CreateGakuEnrollmentStatusTypesTable < ActiveRecord::Migration
  def change
  	create_table :gaku_enrollment_status_types do |t|
      t.string  :name
      t.boolean :is_active

      t.timestamps
  	end
  end
end
