class CreateGakuExams < ActiveRecord::Migration
  def change
    create_table :gaku_exams do |t|
      t.string   :name
      t.text     :description, :adjustments
      t.float    :weight
      t.boolean  :use_weighting, :default => false
      t.boolean  :is_standalone, :default => false 

      t.references :grading_method
      t.references :admission_phase

      t.timestamps
    end
  end
end
