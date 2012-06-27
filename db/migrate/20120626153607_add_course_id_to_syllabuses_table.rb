class AddCourseIdToSyllabusesTable < ActiveRecord::Migration
  def change
    change_table :syllabuses do |t|
      t.references :course 
    end
  end
end
