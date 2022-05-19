require 'rails_helper'

RSpec.describe Merchant, type: :model do 

  describe 'validation' do
    it { should validate_presence_of :name }
  end 

  describe 'relationships' do
    it { should have_many :items }
  end
  
  describe 'class and instance methods' do
   
    it 'returns a merchant given a search term (case sensitive)' do
      merch1 = create(:merchant, name: 'Turing')
      merch2 = create(:merchant, name: 'Ring World')
      merch3 = create(:merchant, name: 'Turkey Town')

      expect(Merchant.find_one_by_search_term('Ring')).to eq(merch2)
    end

    it 'returns all merchants that match the search term' do
      merch1 = create(:merchant, name: 'Cheese World')
      merch2 = create(:merchant, name: 'Ring World')
      merch3 = create(:merchant, name: 'Turkey Town')
      merch4 = create(:merchant, name: 'Cheese McCheesewizz')
      merch5 = create(:merchant, name: 'some cheese')

      expect(Merchant.find_all_by_search_term('cheese')).to eq([merch1, merch3, merch4, merch5])
    end 

  end 

end 
