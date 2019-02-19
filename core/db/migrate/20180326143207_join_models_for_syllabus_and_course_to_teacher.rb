class JoinModelsForSyllabusAndCourseToTeacher < ActiveRecord::Migration[5.1]
  def change
    create_table(:gaku_syllabus_teachers) do |t|
      t.references :syllabus
      t.references :teacher
    end

    create_table(:gaku_course_teachers) do |t|
      t.references :course
      t.references :teacher
    end
  end
end
