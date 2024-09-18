class AddLocationAndWarrantyPeriodToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :location, :text
    add_column :products, :warranty_period, :integer
  end
end
