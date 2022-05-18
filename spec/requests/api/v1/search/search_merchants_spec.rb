require 'rails_helper'

RSpec.describe "Search/Find Merchants API Requests" do

  it 'can find a single merchant that matches a search term' do
    merch1 = create(:merchant, name: 'Turing')
    merch2 = create(:merchant, name: 'Ring World')
    merch3 = create(:merchant, name: 'Turkey Town')

    get '/api/v1/merchants/find?name=Ring'
    
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]
  
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a String
    
    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to eq('merchant')

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a String
    expect(merchant[:attributes][:name]).to eq('Ring World')
  end 

  it 'returns an error if no match for an item was found' do
    merch1 = create(:merchant, name: 'Turing')
    merch2 = create(:merchant, name: 'Ring World')
    merch3 = create(:merchant, name: 'Turkey Town')

    get '/api/v1/merchants/find?name=Purple'
    result = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(result[:message]).to eq("No merchant containing Purple was found")

  end 
end 
