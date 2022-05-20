class Api::V1::MerchantItemsController < ApplicationController

  def index
    merch_id = params[:merchant_id]    
    if Item.exists?(merchant_id: merch_id)
      merch = Merchant.find(merch_id)
      render json: ItemSerializer.new(merch.items)
    else
      render json: { message: 'bad request', error: 'no match found' }, status: 404
    end 
  end
  

end 