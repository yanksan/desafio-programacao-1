class CreateJoinTableSaleUser < ActiveRecord::Migration
  def change
    create_join_table :sales, :users do |t|
      t.index [:sale_id, :user_id]
    end
  end
end
