# frozen_string_literal: true

class CreateInvoiceServices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoice_services do |t|
      ## Fields
      t.integer :price_cents, limit: 8

      ## References
      t.references :invoice, foreign_key: true

      ## Timestamps
      t.timestamps

      ## Archived
      t.datetime :archived_at

      ## Discard
      t.datetime :deleted_at
    end
    add_index :invoice_services, :deleted_at
  end
end
