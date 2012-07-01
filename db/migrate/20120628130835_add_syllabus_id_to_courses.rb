class AddSyllabusIdToCourses < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.references :syllabus
    end
  end
end
