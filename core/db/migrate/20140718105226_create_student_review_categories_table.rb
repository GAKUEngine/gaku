class CreateStudentReviewCategoriesTable < ActiveRecord::Migration[4.2]
  def up
    create_table :gaku_student_review_categories do |t|
      t.string :name
      t.timestamps
    end
    Gaku::StudentReviewCategory.create_translation_table! name: :string
  end
  def down
    drop_table :gaku_student_review_categories
    Gaku::StudentReviewCategory.drop_translation_table!
  end
end
