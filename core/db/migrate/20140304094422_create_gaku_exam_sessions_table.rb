class CreateGakuExamSessionsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :gaku_exam_sessions do |t|
      t.integer    :session_time
      t.string     :name
      t.references :exam
      t.datetime :session_start
    end
  end
end
