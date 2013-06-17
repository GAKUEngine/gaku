class AddMiddleNameReadingToStudents < ActiveRecord::Migration
  def change
    add_column :gaku_students, :middle_name_reading, :string
  end
end
