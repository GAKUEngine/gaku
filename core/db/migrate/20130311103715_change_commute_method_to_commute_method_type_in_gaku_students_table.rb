class ChangeCommuteMethodToCommuteMethodTypeInGakuStudentsTable < ActiveRecord::Migration
  def change
    rename_column :gaku_students, :commute_method_id, :commute_method_type_id
  end
end
