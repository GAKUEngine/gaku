class CreateSpecialtiesTable < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
    	t.string   :name
    	t.text     :description
    	t.boolean  :mayor_only, :default => false
    end 
  end
end
