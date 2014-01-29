class ChangeGradingMethodsArgumentsField < ActiveRecord::Migration
  def change
    rename_column :gaku_grading_methods, :arguments, :criteria
  end
end
