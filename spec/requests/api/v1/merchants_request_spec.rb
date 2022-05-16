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
    end 

  end 

end 