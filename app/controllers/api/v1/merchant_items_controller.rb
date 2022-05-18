class Api::V1::MerchantItemsController < ApplicationController

  def index
    merch_id = params[:merchant_id]    
    if Item.exists?(merchant_id: merch_id)
      render json: ItemSerializer.new(merch.items)
    else
      render status: 404
    end 
  end
  

end 