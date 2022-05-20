class Api::V1::MerchantSearchController < ApplicationController

  def index
    search_term = params[:name]
    if search_term.blank?
      render status:400
    else 
      merchants = Merchant.find_all_by_search_term(search_term)
      render json: MerchantSerializer.new(merchants)
    end 
  end 

  def show
    if params[:name]
      search_term = params[:name]
      merchant = Merchant.find_one_by_search_term(search_term)
      if merchant.nil? || search_term.empty?
        # render json: { data:{ message: "No merchant containing #{search_term} was found" } }, status: 400
        render json: { data: {message: 'bad request', error: "No merchant containing #{search_term} was found"} }, status: 400
      else 
        render json: MerchantSerializer.new(merchant)
      end 
    else
      render status: 400
    end 
  end

end 