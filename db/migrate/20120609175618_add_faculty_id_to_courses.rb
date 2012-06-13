class AddFacultyIdToCourses < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.references :faculty
    end
  end
end
