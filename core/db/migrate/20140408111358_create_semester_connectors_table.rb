class CreateSemesterConnectorsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :gaku_semester_connectors do |t|
      t.references :semester
      t.references :semesterable, polymorphic: true
    end
  end
end
