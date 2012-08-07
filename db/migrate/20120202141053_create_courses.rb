class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string   :code

      t.references :faculty
      t.references :syllabus
      t.references :class_group
      
      t.timestamps
    end
  end
end
