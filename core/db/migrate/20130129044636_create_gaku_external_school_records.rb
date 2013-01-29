class CreateGakuExternalSchoolRecords < ActiveRecord::Migration
  def change
    create_table :gaku_external_school_records do |t|
      t.date :beginning
      t.date :ending
      t.string :student_id_number
      t.integer :absences
      t.float :attendance_rate
      t.boolean :graduated
      t.text :data

      t.timestamps
    end
  end
end
