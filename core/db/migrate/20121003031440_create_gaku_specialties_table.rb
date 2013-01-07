class CreateGakuSpecialtiesTable < ActiveRecord::Migration
  def change
    create_table :gaku_specialties do |t|
    	t.string   :name
    	t.text     :description
    	t.boolean  :major_only, :default => false

      t.timestamps
    end
  end
end
