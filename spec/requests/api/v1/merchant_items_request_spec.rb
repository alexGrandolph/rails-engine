require 'rails_helper'

RSpec.describe "Merchant Items API Requests" do

  it 'returns all items associated with a merchant' do
    merch = create(:merchant)
    merch2 = create(:merchant)
    items = create_list(:item, 3, merchant_id: merch.id)
    items2 = create_list(:item, 2, merchant_id: merch2.id)
    
    get "/api/v1/merchants/#{merch.id}/items"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(result.count).to eq(3)
    result.each do |item|
      expect(item).to have_key(:attributes)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a Float

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an Integer
    end
   
  end 
  
end 

