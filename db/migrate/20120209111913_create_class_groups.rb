class CreateClassGroups < ActiveRecord::Migration
  def change
    create_table :class_groups do |t|
      t.string   :name
      t.integer  :grade
      t.string   :homeroom

      t.timestamps
    end
  end
end
