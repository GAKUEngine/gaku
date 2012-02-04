class CreateClassEnrollements < ActiveRecord::Migration
  def change
    create_table :class_enrollements do |t|
      t.references :student
      t.references :school_class

      t.timestamps
    end
    add_index :class_enrollements, :student_id
    add_index :class_enrollements, :school_class_id
  end
end
