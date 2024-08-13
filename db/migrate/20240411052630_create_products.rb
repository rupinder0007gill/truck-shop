# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      ## Fields
      t.string :product_number
      t.string :name
      t.string :slug
      t.integer :base_price_cents, limit: 8
      t.integer :selling_price_cents, limit: 8
      t.integer :core_price_cents, limit: 8
      t.integer :total_stocks, limit: 8, default: 0
      t.integer :available_stocks, limit: 8, default: 0
      t.integer :used_stocks, limit: 8, default: 0

      ## Timestamps
      t.timestamps

      ## Archived
      t.datetime :archived_at

      ## Discard
      t.datetime :deleted_at
    end
    add_index :products, :deleted_at
  end
end
