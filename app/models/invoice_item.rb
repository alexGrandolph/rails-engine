class InvoiceItem < ApplicationRecord
  belongs_to :invoice #, dependent: :delete
  belongs_to :item
  # belongs_to :merchant, through: :item

end