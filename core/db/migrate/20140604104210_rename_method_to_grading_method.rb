class RenameMethodToGradingMethod < ActiveRecord::Migration
  def change
    rename_column :gaku_grading_methods, :method, :grading_type
  end
end
