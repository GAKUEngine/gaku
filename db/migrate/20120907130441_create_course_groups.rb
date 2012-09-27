class CreateCourseGroups < ActiveRecord::Migration
  def change
    create_table :course_groups do |t|
      t.string 	:name
      t.boolean :is_deleted, :default => false
      t.timestamps
    end
  end
end
