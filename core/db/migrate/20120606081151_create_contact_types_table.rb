class CreateContactTypesTable < ActiveRecord::Migration
  def change 
    create_table :gaku_contact_types do |t|
      t.string   :name
    end
  end
end
