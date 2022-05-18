class Api::V1::MerchantSearchController < ApplicationController

  def show
    search_term = params[:name]
    merchant = Merchant.find_one_by_search_term(search_term)
    if merchant.nil?
      render json: { data: { message: "No merchant containing #{search_term} was found" } }
    else 
      render json: MerchantSerializer.new(merchant)
    end 
  end
  

end 