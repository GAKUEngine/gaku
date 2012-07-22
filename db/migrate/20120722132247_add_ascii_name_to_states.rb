class AddAsciiNameToStates < ActiveRecord::Migration
  def change
    add_column :states, :name_ascii, :string
  end
end
