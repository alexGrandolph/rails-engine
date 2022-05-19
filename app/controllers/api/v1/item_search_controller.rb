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
    if  (params[:min_price].present? || params[:max_price].present?) && params[:name].present?
      render status: 400
    elsif min_more_than_max
      render status: 400
    elsif params[:name]
      name_params
    elsif params[:min_price]
      min_price_params 
    elsif params[:max_price]
      max_price_params
    end 
  end 

  private

    def price_and_name_params
      
    end
    

    def name_params
      search_term = params[:name]
      found_item = Item.find_one_by_search_term(search_term)
      if found_item.nil?
        render json: { data: { message: "No item containing #{search_term} was found" } }
      else 
        render json: ItemSerializer.new(found_item)
      end 
    end

    def min_price_params
      # binding.pry
      price = params[:min_price].to_f 
      item = Item.items_above_price(price)
      if price <= 0
        render json: { error: 'some error'}, status: 400
      elsif item.nil?
        render json: { data: {error: 'no match, too high of min price'}}
      else
        render json: ItemSerializer.new(item), status: 200
      end 
    end

    def max_price_params
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
    
    def min_more_than_max
      params[:min_price].present? && params[:max_price].present? && params[:min_price].to_f > params[:max_price].to_f
    end
    
    
    


end 