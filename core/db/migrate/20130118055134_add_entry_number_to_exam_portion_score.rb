class AddEntryNumberToExamPortionScore < ActiveRecord::Migration
  def change
    add_column :gaku_exam_portion_scores, :entry_number, :string
  end
end
