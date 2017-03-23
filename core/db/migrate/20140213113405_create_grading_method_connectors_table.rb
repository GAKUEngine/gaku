class CreateGradingMethodConnectorsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :gaku_grading_method_connectors do |t|
      t.references :grading_method
      t.references :gradable, polymorphic: true
      t.integer    :position
    end
  end
end
