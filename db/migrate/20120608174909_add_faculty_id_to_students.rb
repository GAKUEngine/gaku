class AddFacultyIdToStudents < ActiveRecord::Migration
  def change
    change_table :students do |t|
      t.references :faculty
    end
  end
end
