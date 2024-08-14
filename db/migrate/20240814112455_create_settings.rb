# frozen_string_literal: true

class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      ## Fields
      t.integer :hourly_rate
      t.float :tax_percentage
      t.string :tax_name

      ## Timestamps
      t.timestamps

      ## Archived
      t.datetime :archived_at

      ## Discard
      t.datetime :deleted_at
    end
    add_index :settings, :deleted_at
  end
end
