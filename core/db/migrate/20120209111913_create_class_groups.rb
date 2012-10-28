class CreateClassGroups < ActiveRecord::Migration
  def change
    create_table :gaku_class_groups do |t|
      t.string   :name
      t.integer  :grade
      t.string   :homeroom

      t.references :faculty

      t.timestamps
    end
  end
end
