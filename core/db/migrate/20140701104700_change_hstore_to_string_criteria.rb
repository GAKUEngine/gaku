class ChangeHstoreToStringCriteria < ActiveRecord::Migration[4.2]
  def change
    change_column :gaku_grading_methods, :criteria, :string
  end
end
