# frozen_string_literal: true

class AddVehicleIdToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_reference :invoices, :vehicle, foreign_key: true
  end
end
