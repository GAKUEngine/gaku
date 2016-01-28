class AddGradableToExamPortionScore < ActiveRecord::Migration
  def change
    add_reference :gaku_exam_portion_scores, :gradable, polymorphic: true,  index: true
  end
end
