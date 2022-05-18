require 'rails_helper'

RSpec.describe "Search/Find Items API Requests" do

  it 'can find a single item that matches a search term' do
    merch = create(:merchant)
    item1 = create(:item, name: 'brisket', merchant_id: merch.id)
    item2 = create(:item, name: 'just some cheese', merchant_id: merch.id)
    item3 = create(:item, name: 'pork belly', merchant_id: merch.id)
    item4 = create(:item, name: 'a lot of cheese', merchant_id: merch.id)
    
    headers = {"CONTENT_TYPE" => "application/json"}
    query_params = {'search': 'cheese'}
    get '/api/v1/items/find', headers: headers, params: JSON.generate(item: query_params)
    
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

end 