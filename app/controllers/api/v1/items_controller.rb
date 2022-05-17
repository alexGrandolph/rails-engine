class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end
  
  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    item = Item.create(item_params)
    if item.save
      render json: ItemSerializer.new(item)
    else
      # render json: {status: "error", code: 3000, message: "All Attributes Must Be Submitted"}
      render status: 404
    end 
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    render json: ItemSerializer.new(item)
  end
  
  

  private
    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
  

end 