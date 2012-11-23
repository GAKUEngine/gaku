class CreatePeriodMethodAssociationsTable < ActiveRecord::Migration
  def change
    create_table :gaku_period_method_associations do |t|
      t.references  :admission_period
      t.references  :admission_method

      t.timestamps
    end
  end
end
