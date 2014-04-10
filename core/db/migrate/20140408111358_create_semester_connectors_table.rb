class CreateSemesterConnectorsTable < ActiveRecord::Migration
  def change
    create_table :gaku_semester_connectors do |t|
      t.references :semester
      t.references :semesterable, polymorphic: true
    end
  end
end
