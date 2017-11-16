class CreateSemesterAttendanceTable < ActiveRecord::Migration[4.2]

  def change
    create_table :gaku_semester_attendances do |t|
      t.references :semester
      t.references :student

      t.integer :days_present, default: 0
      t.integer :days_absent, default: 0


      t.timestamps
    end
  end

end
