class CreateGakuClassGroupEnrollments < ActiveRecord::Migration
  def change
    create_table :gaku_class_group_enrollments do |t|
      t.integer    :seat_number

      t.references :class_group
      t.references :student

      t.timestamps
    end
  end
end
