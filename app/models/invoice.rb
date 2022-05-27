class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions


  def self.range_revenue(first, last)
    
    Invoice.select('invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue').joins(:invoice_items, :transactions).group(:id).where("transactions.result = 'success' AND invoices.status = 'shipped' AND Date(invoices.updated_at) BETWEEN ? AND ?", first, last).sum(&:total_revenue)
    
    
    
    
    #     first = "2012-03-26 22:55:20"
    #     last = "2012-03-25 10:55:32"
    # Invoice.select('invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue').joins(:invoice_items, :transactions).group(:id).where(transactions: {result: 'success'}, invoices: {status: 'shipped'}, invoices: {'created_at BETWEEN ? AND ?', first, last})

# .joins(invoices: [:transactions, :invoice_items])
    # .where("transactions.result = 'success' AND Date(invoices.updated_at) = ?", date)
    # .select('merchants.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    # .group(:id).order('revenue DESC')
  end 
end
