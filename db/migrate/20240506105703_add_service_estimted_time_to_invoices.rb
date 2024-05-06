# frozen_string_literal: true

class AddServiceEstimtedTimeToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :service_estimted_time, :integer
  end
end
