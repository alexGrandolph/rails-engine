class Api::V1::ItemSearchController < ApplicationController

  def index
    search_term = params[:name]
    found_items = Item.find_all_by_search_term(search_term)
    if found_items.empty?
      render json:  ItemSerializer.new(found_items)
    else
      render json: ItemSerializer.new(found_items)
    end 
  end
 

  def show
    if params[:name]
      search_term = params[:name]
      found_item = Item.find_one_by_search_term(search_term)
      if found_item.nil?
        render json: { data: { message: "No item containing #{search_term} was found" } }
      else 
        render json: ItemSerializer.new(found_item)
      end 
    elsif params[:min_price] 
      price = params[:min_price].to_f 
      items = Item.items_above_price(price)
      if items.empty?
        render status: 404
      else
        render json: ItemSerializer.new(items)
      end 
    

    end 
  end 

end 