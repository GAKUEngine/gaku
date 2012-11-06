class CreateGakuScholarshipStatuses < ActiveRecord::Migration
  def change 
    create_table :gaku_scholarship_statuses do |t|
      t.string     :name
      t.references :student

      t.timestamps
    end
  end
end
