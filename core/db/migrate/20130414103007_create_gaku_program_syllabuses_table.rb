class CreateGakuProgramSyllabusesTable < ActiveRecord::Migration
  def change
    create_table :gaku_program_syllabuses do |t|
      t.references :program
      t.references :syllabus
      t.references :level
    end
  end
end
