class RemoveOldClassGroupEnrollmentTable < ActiveRecord::Migration
  def change
    drop_table :gaku_class_group_enrollments
  end
end
