class CreateGakuGradingMethodSetItemsTable < ActiveRecord::Migration
  def change
    create_table :gaku_grading_method_set_items do |t|
      t.references :grading_method
      t.references :grading_method_set
      t.integer :order

      t.timestamps
    end
    add_index :gaku_grading_method_set_items, :grading_method_id
    add_index :gaku_grading_method_set_items, :grading_method_set_id
  end
end
