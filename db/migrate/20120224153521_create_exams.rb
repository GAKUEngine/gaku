class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string   :name
      t.text     :description, :adjustments
      t.float    :weight
      t.boolean  :dynamic_scoring

      t.timestamps
    end
  end
end
