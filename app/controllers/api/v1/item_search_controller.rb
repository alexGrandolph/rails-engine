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
    #  if params[:name] && params[:min_price] || params[:max_price]
    #   render status: 400

  def show
    if params[:name].present? && (params[:min_price].present? || params[:max_price].present?)
      render status: 400
    elsif params[:name]
      search_term = params[:name]
      found_item = Item.find_one_by_search_term(search_term)
      if found_item.nil?
        render json: { data: { message: "No item containing #{search_term} was found" } }
      else 
        render json: ItemSerializer.new(found_item)
      end 
    elsif params[:min_price] 
      price = params[:min_price].to_f 
      item = Item.items_above_price(price)
      if price <= 0
        render json: { error: 'some error'}, status: 400
      elsif item.nil?
        render json: { data: {error: 'no match, too high of min price'}}
      else
        render json: ItemSerializer.new(item), status: 200
      end 
    elsif params[:max_price]
      price = params[:max_price].to_f 
      item = Item.items_under_price(price)
      if price <= 0
        render json: { error: 'some error' }, status: 400
      elsif item.nil?
        render json: ItemSerializer.new(item), status: 404
      else
        render json: ItemSerializer.new(item), status: 200
      end 
    end 
  end 

end 