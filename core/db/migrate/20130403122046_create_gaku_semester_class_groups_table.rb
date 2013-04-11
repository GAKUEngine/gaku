class CreateGakuSemesterClassGroupsTable < ActiveRecord::Migration
  def change
    create_table :gaku_semester_class_groups do |t|
      t.references :semester
      t.references :class_group

      t.timestamps
    end

    add_index :gaku_semester_class_groups, :semester_id
    add_index :gaku_semester_class_groups, :class_group_id
  end
end
