# frozen_string_literal: true

class AddPartsRejectionCommentToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :parts_rejection_comment, :text
  end
end
