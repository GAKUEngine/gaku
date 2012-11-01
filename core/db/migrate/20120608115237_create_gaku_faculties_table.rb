class CreateGakuFacultiesTable < ActiveRecord::Migration
  def change
    create_table :gaku_faculties do |t|

    	t.references :user

    end
  end
end
