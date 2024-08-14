# frozen_string_literal: true

class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      ## Fields
      t.string :vin
      t.string :make_model
      t.string :unit_number
      t.integer :year
      t.string :licence_number
      t.string :po_number

      ## References
      t.references :customer, foreign_key: true

      ## Timestamps
      t.timestamps

      ## Archived
      t.datetime :archived_at

      ## Discard
      t.datetime :deleted_at
    end
    add_index :vehicles, :deleted_at
  end
end
