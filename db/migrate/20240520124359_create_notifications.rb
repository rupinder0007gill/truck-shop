# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      ## Fields
      t.integer :to_user_id, limit: 8
      t.boolean :is_read_by_sender, default: false
      t.boolean :is_read_by_receiver, default: false

      ## References
      t.references :customer, foreign_key: true
      t.references :user, foreign_key: true

      ## Timestamps
      t.timestamps

      ## Discard
      t.datetime :deleted_at
    end
    add_index :notifications, :deleted_at
  end
end
