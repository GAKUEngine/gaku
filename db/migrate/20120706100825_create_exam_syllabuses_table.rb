class CreateExamSyllabusesTable < ActiveRecord::Migration
  def change
    create_table :exam_syllabuses do |t|
      t.references :exam
      t.references :syllabus

      t.timestamps
    end 
  end
end