require 'rails_helper'

RSpec.describe "items API Requests" do

  describe 'Sends a List of items' do
    it 'sends a list of all items' do
      
      merchant = create(:merchant)
      create_list(:item, 5, merchant_id: merchant.id)
      
      get '/api/v1/items'

      expect(response).to be_successful
      items = JSON.parse(response.body,symbolize_names: true)[:data]
      
      expect(items).to be_a(Array)
      items.each do |item|
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

    it 'can return an item when given its id' do
      merch_id = create(:merchant).id 
      id = create(:item, merchant_id: merch_id).id 

      get "/api/v1/items/#{id}"

      expect(response).to be_successful
      item = JSON.parse(response.body, symbolize_names: true)[:data]
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

    it 'can create an item when given attributes and a merchant id' do
      merch_id = create(:merchant).id 
      item_params = {
                      "name": "Cheese",
                      "description": "Just a bunch of cheese",
                      "unit_price": 88.88,
                      "merchant_id": merch_id
                    }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
      expect(response).to be_successful

    end 

  end 
end 