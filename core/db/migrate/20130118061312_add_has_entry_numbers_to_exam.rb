class AddHasEntryNumbersToExam < ActiveRecord::Migration
  def change
    add_column :gaku_exams, :has_entry_numbers, :boolean
  end
end
