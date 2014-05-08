class RemoveSemesterJoinTables < ActiveRecord::Migration
  def change
    drop_table :gaku_semester_class_groups
    drop_table :gaku_semester_courses
  end
end
