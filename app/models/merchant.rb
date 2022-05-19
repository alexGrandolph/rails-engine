class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items

  def self.find_one_by_search_term(search_term) 
    Merchant.where("name ILIKE ?", "%#{search_term}%").order(:name).first
  end 

  def self.find_all_by_search_term(search_term)
    Merchant.where("name ILIKE ?", "%#{search_term}%")
  end
end 