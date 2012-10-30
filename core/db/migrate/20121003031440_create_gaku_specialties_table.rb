class CreateGakuSpecialtiesTable < ActiveRecord::Migration
  def change
    create_table :gaku_specialties do |t|
    	t.string   :name
    	t.text     :description
    	t.boolean  :mayor_only, :default => false
    end 
  end
end
