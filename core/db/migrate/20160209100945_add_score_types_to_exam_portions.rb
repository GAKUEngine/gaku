class AddScoreTypesToExamPortions < ActiveRecord::Migration[4.2]
  def change
    add_column :gaku_exam_portions, :score_type, :integer, default: 0
    add_column :gaku_exam_portions, :score_selection_options, :text, array:true, default: []
  end
end
