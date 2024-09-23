class AddEtaAndTrackingurlToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :eta, :datetime
    add_column :orders, :trackingurl, :string
  end
end
