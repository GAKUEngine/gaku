class CreateStudentReviewTable < ActiveRecord::Migration
  def change
    create_table :gaku_student_reviews do |t|
      t.references :student
      t.references :student_review_category
      t.references :student_reviewable, polymorphic: true
      t.text :content

      t.timestamps
    end
  end
end
