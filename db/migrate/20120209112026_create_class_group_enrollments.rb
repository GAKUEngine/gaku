class CreateClassGroupEnrollments < ActiveRecord::Migration
  def change
    create_table :class_group_enrollments do |t|
      t.references :class_group
      t.references :student

      t.timestamps
    end
    add_index :class_group_enrollments, :class_group_id
    add_index :class_group_enrollments, :student_id
  end
end
