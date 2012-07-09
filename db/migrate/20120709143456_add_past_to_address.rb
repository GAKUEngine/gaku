class AddPastToAddress < ActiveRecord::Migration
  def change
  	change_table :addresses do |t|
      t.boolean :past, :default => false
    end
  end
end
