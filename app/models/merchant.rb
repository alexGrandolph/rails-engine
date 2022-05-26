class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoice_items, through: :invoice_items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.find_one_by_search_term(search_term) 
    Merchant.where("name ILIKE ?", "%#{search_term}%").order(:name).first
  end 

  def self.find_all_by_search_term(search_term)
    Merchant.where("name ILIKE ?", "%#{search_term}%")
  end

  def self.top_revenue_by_merchants(quantity)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as REVENUE')
    .joins(invoices: [:invoice_items, :transactions])
    .group(:id)
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .order('revenue desc')
    .limit(quantity)

  end 


end 