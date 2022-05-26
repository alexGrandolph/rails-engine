class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end
  
  def show
    merchant = Merchant.find(params[:id])

    render json: MerchantSerializer.new(merchant)
  end

  def most_items
    quantity = params[:quantity]
    # binding.pry
    merchants = Merchant.items_sold(quantity)
    render json: ItemsSoldSerializer.new(merchants)
  end
  
  
end 