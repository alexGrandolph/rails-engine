class Api::V1::MerchantSearchController < ApplicationController

  def show
    search_term = params[:name]
    merchant = Merchant.find_one_by_search_term(search_term)
  end
  

end 