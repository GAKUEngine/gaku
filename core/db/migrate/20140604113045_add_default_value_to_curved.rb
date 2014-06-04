class AddDefaultValueToCurved < ActiveRecord::Migration
  def change
    change_column :gaku_grading_methods, :curved, :boolean, default: false
  end
end
