# frozen_string_literal: true

class AddCustomerIdToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_reference :invoices, :customer, foreign_key: true
  end
end
