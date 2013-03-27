class DropGakuGuardiansStudentsTable < ActiveRecord::Migration
  def up
    drop_table :gaku_guardians_students
  end

  def down
    create_table :gaku_guardians_students
  end
end
