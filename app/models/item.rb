class Item < ApplicationRecord
  validates_presence_of :name, :description
  validates_presence_of :unit_price
  
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy

end 