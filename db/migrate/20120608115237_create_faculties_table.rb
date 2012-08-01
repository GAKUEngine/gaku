class CreateFacultiesTable < ActiveRecord::Migration
  def change
    create_table :faculties do |t|

    	t.references :user

    end
  end
end
