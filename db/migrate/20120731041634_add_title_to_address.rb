class AddTitleToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :title, :string
  end
end
