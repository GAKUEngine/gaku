class ChangeGradingMethodsArgumentsField < ActiveRecord::Migration[4.2]
  def change
    rename_column :gaku_grading_methods, :arguments, :criteria
  end
end
