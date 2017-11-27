class AddFieldsToExamPortionScore < ActiveRecord::Migration
  def change
    add_column :gaku_exam_portion_scores, :score_text, :string
    add_column :gaku_exam_portion_scores, :score_selection, :string
  end
end
