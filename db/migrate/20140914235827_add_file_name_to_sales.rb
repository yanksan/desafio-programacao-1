class AddFileNameToSales < ActiveRecord::Migration
  def change
    add_column :sales, :file_name, :string
  end
end
