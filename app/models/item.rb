class Item < ApplicationRecord
  validates_presence_of :name, :description
  validates_presence_of :unit_price
  before_destroy :delete_invoice
  
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items


  def self.find_one_by_search_term(search_term)
    # term = search_term.downcase
    Item.where("name ILIKE ?", "%#{search_term}%").first
  end 

  def self.find_all_by_search_term(search_term)
    Item.where("name ILIKE ?", "%#{search_term}%")
  end

  def self.items_above_price(price)
    Item.where("unit_price >= ?", price).order(:name).first
  end

  def self.items_under_price(price)
    Item.where("unit_price <= ?", price).order(:name).first
  end


  private

    def delete_invoice
      invoices.map {|invoice| invoice.destroy if invoice.items.count==1}
    end
end 