class AddDefaultFieldToScholarshipStatuses < ActiveRecord::Migration
  def change
    change_table :gaku_scholarship_statuses do |t|
      t.boolean  :is_default
    end
  end
end
