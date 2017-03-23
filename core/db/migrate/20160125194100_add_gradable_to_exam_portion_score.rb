class AddGradableToExamPortionScore < ActiveRecord::Migration[4.2]
  def change
    add_reference :gaku_exam_portion_scores, :gradable, polymorphic: true,  index: true
  end
end
