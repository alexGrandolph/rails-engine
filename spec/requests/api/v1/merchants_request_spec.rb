require 'rails_helper'

RSpec.describe "Merchants API Requests" do

  describe 'Sends a List of Merchants' do
    it 'sends a list of all merchants' do
      create_list(:merchant, 5)

      get '/api/v1/merchants'
      
      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(merchants).to have_key(:data)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a String

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a String
      end 

      expect(merchants[:data].count).to eq(Merchant.all.count)
    end 

    it 'can get one merchant by its id' do
      id = create(:merchant).id 

      get "/api/v1/merchants/#{id}"

      expect(response).to be_successful
      
      merchant = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a String
      
      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq('merchant')

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a String

    end 

  end 

end 