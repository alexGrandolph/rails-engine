require 'rails_helper'

RSpec.describe Item, type: :model do 

  describe 'validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end 

  describe 'relationships' do
    it { should belong_to :merchant }
  end 

  describe 'class methods' do
    it 'returns the first item that matches a search term' do
      merch = create(:merchant)    
      item1 = create(:item, name: 'brisket', merchant_id: merch.id)
      item2 = create(:item, name: 'just some cheese', merchant_id: merch.id)
      item3 = create(:item, name: 'pork belly', merchant_id: merch.id)
      item4 = create(:item, name: 'a lot of cheese', merchant_id: merch.id)
      
      expect(Item.find_one_by_search_term('cheese')).to eq(item2)
    end 

    it 'returns the first item that matches a search term' do
      merch = create(:merchant)    
      item1 = create(:item, name: 'brisket', merchant_id: merch.id)
      item2 = create(:item, name: 'just some cheesebelly', merchant_id: merch.id)
      item4 = create(:item, name: 'a lot of cheese', merchant_id: merch.id)
      item3 = create(:item, name: 'just some cheese', merchant_id: merch.id)
     
      expect(Item.find_all_by_search_term('cheese')).to eq([item2, item4, item3])
    end 

    it 'returns items equal to or above a given price' do
      merch = create(:merchant)
      item1 = create(:item, unit_price: 3.99, merchant_id: merch.id)
      item2 = create(:item, unit_price: 16.88, merchant_id: merch.id)
      item3 = create(:item, unit_price: 4.99, merchant_id: merch.id)
      item4 = create(:item, unit_price: 2.11, merchant_id: merch.id)
    
    expect(Item.items_above_price(4.99)).to eq([item2, item3])

    end 
    
  end 
end 