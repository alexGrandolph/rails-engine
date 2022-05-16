class Item < ApplicationRecord
  validates_presence_of :name, :description
  validates_presence_of :unit_price

end 