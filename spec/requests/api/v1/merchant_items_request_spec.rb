require 'rails_helper'

RSpec.describe "Merchant Items API Requests" do

  it 'returns all items associated with a merchant' do
    merch = create(:merchant)

    items = create_list(:item, 3, merchant_id: merch.id)

    get "/api/v1/merchants/#{merch.id}/items"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(result).to have_key(:relationships)
    items = result[:relationships]
    # binding.pry
  end 
  
end 



# expect(items).to have_key(:data)
# expect(items[:data]).to be_an Array

# expect(items[:data]).to have_key(:id)
# expect(items[:data][:id]).to be_an Integer

# expect(items[:data]).to have_key(:type)
# expect(items[:data][:type]).to eq('item')
