class CreateGakuSemesterCoursesTable < ActiveRecord::Migration
  def change
    create_table :gaku_semester_courses do |t|
      t.references :semester
      t.references :course

      t.timestamps
    end
    add_index :gaku_semester_courses, :semester_id
    add_index :gaku_semester_courses, :course_id
  end
end
