class DropGakuCommuteMethodsTable < ActiveRecord::Migration
  def change
    drop_table :gaku_commute_methods
  end
end
