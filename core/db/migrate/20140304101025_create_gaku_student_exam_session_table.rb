class CreateGakuStudentExamSessionTable < ActiveRecord::Migration
  def change
    create_table :gaku_student_exam_sessions do |t|
      t.references :student
      t.references :exam_session
    end
  end
end
