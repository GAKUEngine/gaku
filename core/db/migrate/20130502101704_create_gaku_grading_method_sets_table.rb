class CreateGakuGradingMethodSetsTable < ActiveRecord::Migration
  def change
    create_table :gaku_grading_method_sets do |t|
      t.string :name
      t.boolean :primary, :default => false
      t.boolean :display_deviation, :default => false
      t.boolean :display_rank, :default => false
      t.boolean :rank_order, :default => false

      t.timestamps
    end
  end
end
