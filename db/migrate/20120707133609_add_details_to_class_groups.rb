class AddDetailsToClassGroups < ActiveRecord::Migration
  def change
    add_column :class_groups, :grade, :integer
    add_column :class_groups, :home_room, :string
  end
end
