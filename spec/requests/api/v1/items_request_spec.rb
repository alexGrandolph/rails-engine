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
    end 
  end 
end 