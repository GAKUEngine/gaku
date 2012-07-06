class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string   :code
      
      t.timestamps
    end
  end
end
