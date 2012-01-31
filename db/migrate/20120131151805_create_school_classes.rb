class CreateSchoolClasses < ActiveRecord::Migration
  def change
    create_table :school_classes do |t|

      t.timestamps
    end
  end
end
