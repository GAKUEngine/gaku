class AddSurnameReadingToStudents < ActiveRecord::Migration
  def change
    add_column :students, :surname_reading, :string
  end
end
