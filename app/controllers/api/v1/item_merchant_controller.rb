class Api::V1::ItemMerchantController < ApplicationController

  def index
    if item = Item.find(params[:item_id])
    render json: MerchantSerializer.new(item.merchant)
    else
      render status: 404
    end 
  end
  

end 