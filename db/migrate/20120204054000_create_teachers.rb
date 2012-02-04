class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :email
      t.date :birth

      t.timestamps
    end
  end
end
