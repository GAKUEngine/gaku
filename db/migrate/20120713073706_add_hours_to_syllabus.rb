class AddHoursToSyllabus < ActiveRecord::Migration
  def change
    add_column :syllabuses, :hours, :integer
  end
end
