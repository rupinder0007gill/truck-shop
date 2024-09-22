# frozen_string_literal: true

class AddInvoiceNumberToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :invoice_number, :string
    add_index :invoices, :invoice_number, unique: true
  end
end
