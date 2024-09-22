# frozen_string_literal: true

class ChangeWarrantyPeriodTypeInProducts < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :warranty_period, :text
  end
end
