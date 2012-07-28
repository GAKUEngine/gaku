class RemoveFieldsFromExamPortionScore < ActiveRecord::Migration
  def up
    remove_column :exam_portion_scores, :division
    remove_column :exam_portion_scores, :comment
  end

  def down
    add_column :exam_portion_scores, :division, :integer
    add_column :exam_portion_scores, :comment, :text
  end
end
