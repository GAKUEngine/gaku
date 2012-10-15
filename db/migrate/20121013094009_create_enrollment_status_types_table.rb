class CreateEnrollmentStatusTypesTable < ActiveRecord::Migration
  def change
  	create_table :enrollment_status_types do |t|
      t.string  :name
      t.boolean :is_active

      t.timestamps
  	end
  end
end
