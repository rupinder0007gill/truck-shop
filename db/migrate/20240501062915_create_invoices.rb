# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      ## Fields
      t.integer :status, default: 0, null: false
      t.integer :payment_method, default: 0, null: false
      t.string :transaction_id
      t.integer :price_cents, limit: 8
      t.integer :tax_cents, limit: 8
      t.integer :total_price_cents, limit: 8
      t.integer :discount_cents, limit: 8

      ## References
      t.references :user, foreign_key: true

      ## Timestamps
      t.timestamps

      ## Archived
      t.datetime :archived_at

      ## Discard
      t.datetime :deleted_at
    end
    add_index :invoices, :deleted_at
  end
end
