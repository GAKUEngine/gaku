class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :name
      t.integer :problem_count
      t.float :max_score
      t.float :weight
      t.binary :data

      t.timestamps
    end
  end
end
