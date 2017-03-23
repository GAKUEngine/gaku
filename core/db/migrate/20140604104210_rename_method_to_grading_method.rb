class RenameMethodToGradingMethod < ActiveRecord::Migration[4.2]
  def change
    rename_column :gaku_grading_methods, :method, :grading_type
  end
end
