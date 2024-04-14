# frozen_string_literal: true

class CreateOrderProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :order_products do |t|
      ## Fields
      t.integer :quantity, limit: 8
      t.integer :price_cents, limit: 8
      t.integer :final_price_cents, limit: 8

      ## References
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true

      ## Timestamps
      t.timestamps

      ## Archived
      t.datetime :archived_at

      ## Discard
      t.datetime :deleted_at
    end
    add_index :order_products, :deleted_at
  end
end
