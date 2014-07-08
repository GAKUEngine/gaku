class ChangeHstoreToStringCriteria < ActiveRecord::Migration
  def change
    change_column :gaku_grading_methods, :criteria, :string
  end
end
