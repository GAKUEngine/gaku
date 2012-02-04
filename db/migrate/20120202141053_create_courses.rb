class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code
      t.references :syllabus
     # t.references :schedule
     # t.references :teacher

      t.timestamps
    end
    add_index :courses, :syllabus_id
    #add_index :courses, :schedule_id
    #add_index :courses, :teacher_id
  end
end
