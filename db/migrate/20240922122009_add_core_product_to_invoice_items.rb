# frozen_string_literal: true

class AddCoreProductToInvoiceItems < ActiveRecord::Migration[7.1]
  def change
    add_column :invoice_items, :core_product_id, :integer, limit: 8
  end
end
