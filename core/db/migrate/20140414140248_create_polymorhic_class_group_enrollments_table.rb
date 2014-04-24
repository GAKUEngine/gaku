class CreatePolymorhicClassGroupEnrollmentsTable < ActiveRecord::Migration
  def change
    create_table :gaku_class_group_enrollments do |t|
      t.references :class_group
      t.references :enrollmentable, polymorphic: true
    end

    add_index :gaku_class_group_enrollments, :class_group_id
    add_index :gaku_class_group_enrollments, [:enrollmentable_id, :enrollmentable_type], name: :gaku_class_group_enrollments_enrollmentable
  end
end
