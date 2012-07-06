class CreateContactsTable < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string   :data
      t.text     :details

      t.timestamps
    end
  end
end