class Api::V1::ItemSearchController < ApplicationController

  def index
    search_term = params[:name]
    if search_term.blank?
      render status:400
    else 
      found_items = Item.find_all_by_search_term(search_term)
      render json: ItemSerializer.new(found_items)
    end 
  end

  def show
    if  (params[:min_price].present? || params[:max_price].present?) && params[:name].present?
      render status: 400
    elsif min_more_than_max
      render status: 400
    elsif params[:name]
      if params[:name].blank?
        render status:400
      else
        name_params
      end 
    elsif params[:min_price]
      min_price_params 
    elsif params[:max_price]
      max_price_params
    end 
  end 

  private

    def name_params
      search_term = params[:name]
      found_item = Item.find_one_by_search_term(search_term)
      if found_item.nil?
        render json: ErrorSerializer.cant_find_error
        # render json: { data: { message: "No item containing #{search_term} was found" } }
      else 
        render json: ItemSerializer.new(found_item)
      end 
    end

    def min_price_params
      price = params[:min_price].to_f 
      item = Item.items_above_price(price)
      if price <= 0
        # render json: ErrorSerializer.price_error
        render json: { error: 'price less than or equal to zero has no match'}, status: 400
      elsif item.nil?
        render json: ErrorSerializer.cant_find_error
      else
        render json: ItemSerializer.new(item), status: 200
      end 
    end

    def max_price_params
      price = params[:max_price].to_f 
      item = Item.items_under_price(price)
      if price <= 0
        render json: { error: 'price less than or equal to zero has no match' }, status: 400
      else
        render json: ItemSerializer.new(item), status: 200
      end 
    end
    
    def min_more_than_max
      params[:min_price].present? && params[:max_price].present? && params[:min_price].to_f > params[:max_price].to_f
    end
    
end 