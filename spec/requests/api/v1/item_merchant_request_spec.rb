require 'rails_helper'

RSpec.describe "Item Merchant API Requests" do

  it 'returns merchant associated with an item' do
    merch = create(:merchant)
    item = create(:item, merchant_id: merch.id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(result).to have_key(:id)
    expect(result[:id]).to be_a String
    
    expect(result).to have_key(:type)
    expect(result[:type]).to eq('merchant')

    expect(result[:attributes]).to have_key(:name)
    expect(result[:attributes][:name]).to be_a String

  end 

end 