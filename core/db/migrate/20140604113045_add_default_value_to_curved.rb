class AddDefaultValueToCurved < ActiveRecord::Migration[4.2]
  def change
    change_column :gaku_grading_methods, :curved, :boolean, default: false
  end
end
