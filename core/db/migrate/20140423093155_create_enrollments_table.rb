class CreateEnrollmentsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :gaku_enrollments do |t|
      t.references :student
      t.references :enrollmentable, polymorphic: true
    end

    add_index :gaku_enrollments, :student_id
    add_index :gaku_enrollments, [:enrollmentable_id, :enrollmentable_type], name: :gaku_enrollments_enrollmentable
  end
end
