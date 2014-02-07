class DropStudentConfigs < ActiveRecord::Migration
  def change
    drop_table :gaku_student_configs
  end
end
