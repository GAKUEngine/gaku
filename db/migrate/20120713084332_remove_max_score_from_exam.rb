class RemoveMaxScoreFromExam < ActiveRecord::Migration
  def up
    remove_column :exams, :max_score
    add_column :exams, :adjustments, :text
  end

  def down
    add_column :exams, :max_score, :interger
    remove_column :exams, :adjustments
  end
end
