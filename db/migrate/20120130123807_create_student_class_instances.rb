class CreateStudentClassInstances < ActiveRecord::Migration
  def change
    create_table :student_class_instances do |t|

      t.timestamps
    end
  end
end
