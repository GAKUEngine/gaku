class AddLocaleToUserTable < ActiveRecord::Migration
  def change
    change_table :users do |t|
    	t.string :locale
    end 
  end
end
