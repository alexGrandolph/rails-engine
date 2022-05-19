class Api::V1::MerchantSearchController < ApplicationController

  def show
    if params[:name]
      search_term = params[:name]
      merchant = Merchant.find_one_by_search_term(search_term)
      if merchant.nil? || search_term.empty?
        render json: { data: { message: "No merchant containing #{search_term} was found" } }, status: 400
      else 
        render json: MerchantSerializer.new(merchant)
      end 
    else
      render status: 400
    end 
  end
  

end 