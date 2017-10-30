class ChangeEnrollmentableToEnrollable < ActiveRecord::Migration[5.0]
  def change
    rename_column :gaku_enrollments, :enrollmentable_id, :enrollable_id
    rename_column :gaku_enrollments, :enrollmentable_type, :enrollable_type
  end
end
