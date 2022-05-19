require 'rails_helper'

RSpec.describe "Search/Find Items API Requests" do

  it 'can find a single item that matches a search term' do
    merch = create(:merchant)
    item1 = create(:item, name: 'brisket', merchant_id: merch.id)
    item2 = create(:item, name: 'just some cheese', merchant_id: merch.id)
    item3 = create(:item, name: 'pork belly', merchant_id: merch.id)
    item4 = create(:item, name: 'a lot of cheese', merchant_id: merch.id)
   
    get '/api/v1/items/find?name=cheese'
    
    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(result).to have_key(:attributes)
    expect(result[:attributes][:name]).to eq(item2.name)

    expect(result[:attributes]).to have_key(:name)
    expect(result[:attributes][:name]).to be_a(String)
    
    expect(result[:attributes]).to have_key(:description)
    expect(result[:attributes][:description]).to be_a(String)
    
    expect(result[:attributes]).to have_key(:unit_price)
    expect(result[:attributes][:unit_price]).to be_a Float

    expect(result[:attributes]).to have_key(:merchant_id)
    expect(result[:attributes][:merchant_id]).to be_an Integer     
  end 

  it 'returns an error if no match for an item was found' do
    merch = create(:merchant)
    item1 = create(:item, name: 'brisket', merchant_id: merch.id)
    item2 = create(:item, name: 'just some cheese', merchant_id: merch.id)
    item3 = create(:item, name: 'pork belly', merchant_id: merch.id)
    item4 = create(:item, name: 'a lot of cheese', merchant_id: merch.id)
   
    get '/api/v1/items/find?name=purple'

    result = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(result[:message]).to eq("No item containing purple was found")
  end 

  it 'returns all items that match a search term' do
    merch = create(:merchant)
    item1 = create(:item, name: 'brisket', merchant_id: merch.id)
    item2 = create(:item, name: 'just some cheese', merchant_id: merch.id)
    item3 = create(:item, name: 'pork cheese', merchant_id: merch.id)
    item4 = create(:item, name: 'a lot of cheese', merchant_id: merch.id)

    get '/api/v1/items/find_all?name=cheese'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]
    # binding.pry
    expect(items).to be_an Array
    expect(items.count).to eq(3)
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

  it 'returns an error if no match for an item was found' do
    merch = create(:merchant)
    item1 = create(:item, name: 'brisket', merchant_id: merch.id)
    item2 = create(:item, name: 'just some cheese', merchant_id: merch.id)
    item3 = create(:item, name: 'pork belly', merchant_id: merch.id)
    item4 = create(:item, name: 'a lot of cheese', merchant_id: merch.id)
   
    get '/api/v1/items/find?name=waffles'

    result = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(result[:message]).to eq("No item containing waffles was found")
  end 

  it 'it can return first item alphabetically that is equal to or greater than a given price' do
    merch = create(:merchant)
    item1 = create(:item, name: 'cheese corp', unit_price: 3.99, merchant_id: merch.id)
    item2 = create(:item, name: 'turkey town', unit_price: 16.88, merchant_id: merch.id)
    item3 = create(:item, name: 'my dog skeeter', unit_price: 4.99, merchant_id: merch.id)
    item4 = create(:item, name: 'Arbys', unit_price: 2.11, merchant_id: merch.id)

    get '/api/v1/items/find?min_price=4.99'
    expect(response).to be_successful
    item = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(item[:attributes][:name]).to eq(item3.name)
  end 
  
  it 'it can return first item alphabetically that is equal to or lesser than a given price' do
    merch = create(:merchant)
    item1 = create(:item, name: 'cheese corp', unit_price: 3.99, merchant_id: merch.id)
    item2 = create(:item, name: 'turkey town', unit_price: 16.88, merchant_id: merch.id)
    item3 = create(:item, name: 'my dog skeeter', unit_price: 4.99, merchant_id: merch.id)
    item4 = create(:item, name: 'Arbys', unit_price: 2.11, merchant_id: merch.id)
    
    get '/api/v1/items/find?max_price=99.99'
    expect(response).to be_successful
    
    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item[:attributes][:name]).to eq(item4.name)
    
  end 

  

end 