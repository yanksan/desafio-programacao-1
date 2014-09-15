class AddSaleRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :sale, index: true
  end
end
