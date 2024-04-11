# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      ## Fields
      t.string :name
      t.string :slug
      t.string :manufacturar_name
      t.string :product_identification_number
      t.string :product_summary
      t.datetime :release_date
      t.string :warranty_length
      t.string :warranty_policy
      t.integer :discount_percentage
      t.integer :price_cents, limit: 8
      t.integer :selling_price_cents, limit: 8
      t.integer :total_stocks, limit: 8, default: 0
      t.integer :available_stocks, limit: 8, default: 0
      t.integer :used_stocks, limit: 8, default: 0
      t.integer :status, default: 0, null: false

      ## References
      t.references :user, foreign_key: true

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
