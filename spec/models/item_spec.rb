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

    it 'returns first item alphabetically equal to or above a given price' do
      merch = create(:merchant)
      item1 = create(:item, name: 'cheese corp', unit_price: 3.99, merchant_id: merch.id)
      item2 = create(:item, name: 'turkey town', unit_price: 16.88, merchant_id: merch.id)
      item3 = create(:item, name: 'my dog skeeter', unit_price: 4.99, merchant_id: merch.id)
      item4 = create(:item, name: 'Arbys', unit_price: 2.11, merchant_id: merch.id)
    
    expect(Item.items_above_price(4.99)).to eq(item3)

    end 

    it 'returns first item alphabetically equal to or under a given price' do
      merch = create(:merchant)
      item1 = create(:item, name: 'ham and cheese inc', unit_price: 3.99, merchant_id: merch.id)
      item2 = create(:item, name: 'also arbys', unit_price: 162.88, merchant_id: merch.id)
      item3 = create(:item, name: 'dog den', unit_price: 99.99, merchant_id: merch.id)
      item4 = create(:item, name: 'eldens rings', unit_price: 452.11, merchant_id: merch.id)
    
    expect(Item.items_under_price(99.99)).to eq(item3)

    end 
    
  end 
end 