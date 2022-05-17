class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  # belongs_to :merchant, through: :item

end