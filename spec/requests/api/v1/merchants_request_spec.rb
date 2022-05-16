require 'rails_helper'

RSpec.describe "Merchants API Requests" do

  describe 'Sends a List of Merchants' do
    it 'sends a list of all merchants' do
      create_list(:merchant, 5)

      get '/api/v1/merchants'

      expect(response).to be_sucessful
    end 

  end 

end 