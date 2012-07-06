class CreateExamsSyllabusesTable < ActiveRecord::Migration
  def change
    create_table :exams_syllabuses do |t|
      t.references :exam
      t.references :syllabus
    end 
  end
end