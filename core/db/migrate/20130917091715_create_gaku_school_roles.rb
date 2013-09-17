class CreateGakuSchoolRoles < ActiveRecord::Migration
  def change
    create_table :gaku_school_roles do |t|
      t.string :name

      t.references :school_rolable, polymorphic: true
      t.references :school_role_type

      t.timestamps
    end
  end
end
