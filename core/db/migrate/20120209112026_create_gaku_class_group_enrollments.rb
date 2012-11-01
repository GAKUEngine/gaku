class CreateGakuClassGroupEnrollments < ActiveRecord::Migration
  def change
    create_table :gaku_class_group_enrollments do |t|
      t.references :class_group
      t.references :student
      t.integer    :seat_number

      t.timestamps
    end
    add_index :gaku_class_group_enrollments, :class_group_id
    add_index :gaku_class_group_enrollments, :student_id
  end
end
