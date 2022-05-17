require 'rails_helper'

RSpec.describe "Merchant Items API Requests" do

  it 'returns all items associated with a merchant' do
    merch = create(:merchant)

    items = create_list(:item, 3, merchant_id: merch.id)

    get "/api/v1/merchant/#{merch.id}/items"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(result).to have_key(:relationships)
  end 

end 