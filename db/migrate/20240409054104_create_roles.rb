# frozen_string_literal: true

class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      ## Fields
      t.string :name

      ## Discard
      t.datetime :deleted_at

      ## Timestamps
      t.timestamps
    end
    add_index :roles, :deleted_at
  end
end
