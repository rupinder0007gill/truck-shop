# frozen_string_literal: true

class CreateInvoiceItems < ActiveRecord::Migration[7.1]
  def change
    create_table :invoice_items do |t|
      ## Fields
      t.text :description
      t.boolean :is_core_product, default: false
      t.integer :invoice_type
      t.integer :qty
      t.integer :price_cents, limit: 8
      t.integer :final_price_cents, limit: 8

      ## References
      t.references :invoice, foreign_key: true
      t.references :product, foreign_key: true

      ## Timestamps
      t.timestamps

      ## Archived
      t.datetime :archived_at

      ## Discard
      t.datetime :deleted_at
    end
    add_index :invoice_items, :deleted_at
  end
end
