class AddFieldsToExamPortion < ActiveRecord::Migration
  def change
    add_column :exam_portions, :problem_count, :integer
    add_column :exam_portions, :description, :text
    add_column :exam_portions, :execution_date, :datetime
    add_column :exam_portions, :adjustments, :text
    add_column :exam_portions, :dynamic_scoring, :boolean
  end
end
