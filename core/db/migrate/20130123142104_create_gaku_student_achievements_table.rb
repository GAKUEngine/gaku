class CreateGakuStudentAchievementsTable < ActiveRecord::Migration
  def change
    create_table :gaku_student_achievements do |t|
      t.references :student
      t.references :achievement

      t.string     :assertion

      t.timestamps
    end
  end
end