class CreateGradingMethods < ActiveRecord::Migration
  def change
    create_table :grading_methods do |t|
      t.string :name
      t.text :description
      t.text :method

      t.timestamps
    end
  end
end
