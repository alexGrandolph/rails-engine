require 'rails_helper'

RSpec.describe Merchant, type: :model do 

  describe 'validation' do
    it { should validate_presence_of :name }
  end 

  describe 'relationships' do
    it { should have_many :items }
  end
  
  describe 'class and model' do
   
    it 'returns a merchant given a search term (case sensitive)' do
      merch1 = create(:merchant, name: 'Turing')
      merch2 = create(:merchant, name: 'Ring World')
      merch3 = create(:merchant, name: 'Turkey Town')

      expect(Merchant.find_one_by_search_term('Ring')).to eq(merch2)
    end

  end 

end 
