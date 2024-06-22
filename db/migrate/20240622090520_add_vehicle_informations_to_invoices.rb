# frozen_string_literal: true

class AddVehicleInformationsToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :vin_number, :string
    add_column :invoices, :make_model, :string
    add_column :invoices, :unit_number, :string
    add_column :invoices, :year, :string
    add_column :invoices, :odometer, :string
    add_column :invoices, :licence_number, :string
  end
end
