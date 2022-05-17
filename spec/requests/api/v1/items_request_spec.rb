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
      
      created_item = Item.last

      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
      
      json_result = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(json_result).to have_key(:attributes)
      expect(json_result[:attributes][:name]).to be_a(String)

      expect(json_result[:attributes]).to have_key(:name)
      expect(json_result[:attributes][:name]).to be_a(String)
      
      expect(json_result[:attributes]).to have_key(:description)
      expect(json_result[:attributes][:description]).to be_a(String)
      
      expect(json_result[:attributes]).to have_key(:unit_price)
      expect(json_result[:attributes][:unit_price]).to be_a Float

      expect(json_result[:attributes]).to have_key(:merchant_id)
      expect(json_result[:attributes][:merchant_id]).to be_an Integer     
    end 

    it 'retuns an error if any attributes are missing' do
      merch_id = create(:merchant).id 
      item_params = {
                      "name": "Cheese",
                      "unit_price": 88.88,
                      "merchant_id": merch_id
                    }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
      
      expect(response.status).to eq(404)
    end 

    it 'ignores any attributes sent that are not allowed' do
      merch_id = create(:merchant).id 
      item_params = {
                      "name": "Cheese",
                      "description": "Just a bunch of cheese",
                      "unit_price": 88.88,
                      "is_it_cheese": true,
                      "merchant_id": merch_id
                    }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
      json_result = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(json_result[:attributes]).to_not have_key(:is_it_cheese)
    end 

    it 'can update an item' do
      merch_id = create(:merchant).id 
      og_item = create(:item, merchant_id: merch_id)
      updated_params = {
                        "name": "Not Cheese",
                        "description": "Sadly, No Longer Cheese",
                        "unit_price":  9.50,
                        "merchant_id": merch_id
                      }
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/items/#{og_item.id}", headers: headers, params: JSON.generate(item: updated_params)
      
      item = Item.find_by(id: og_item.id)
      expect(response).to be_successful
      expect(item.name).to_not eq(og_item.name)
      expect(item.description).to_not eq(og_item.description)
      expect(item.unit_price).to_not eq(og_item.unit_price)
    end 

    it 'can delete an item' do
      
      merch_id = create(:merchant).id 
      merch_id2 = create(:merchant).id 
      create_list(:item, 3, merchant_id: merch_id2)
      item = create(:item, merchant_id: merch_id)

      delete "/api/v1/items/#{item.id}"
      expect(response).to be_successful
      expect(response.status).to eq(204)

      expect(Item.all.last).to_not eq(item)
    end 

    it 'deleting item also destroys invoice where its item was only item on invoice' do
      merch1 = create(:merchant)
      cust1 = create(:customer)
      
      item1 = create(:item, merchant_id: merch1.id)
      item2 = create(:item, merchant_id: merch1.id)
      
      invoice = create(:invoice, customer_id: cust1.id, merchant_id: merch1.id)
      invoice2 = create(:invoice, customer_id: cust1.id, merchant_id: merch1.id)
      #making invoice 1 have only the item to be deleted on it. this invoice should get deleted also
      invoice_item = create(:invoice_item, item_id: item1.id, invoice_id: invoice.id)
      #making invoice with one to be deleted item and another item. this invoice should stay
      invoice_item2 = create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id)
      invoice_item3 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)

      expect(Invoice.all.count).to eq(2)
      
      delete "/api/v1/items/#{item1.id}"
      
      expect(response).to be_successful
      expect(Invoice.all.count).to eq(1)
    end
  end 
end 