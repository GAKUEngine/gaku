class DropStudentConfigs < ActiveRecord::Migration[4.2]
  def change
    drop_table :gaku_student_configs
  end
end
