class Api::V1::ItemSearchController < ApplicationController

  def index
    search_term = params[:term]
    found_items = Item.find_all_by_search_term(search_term)
    render json: ItemSerializer.new(found_item)
  end
  

  def show
    search_term = params[:name]
    found_item = Item.find_one_by_search_term(search_term)
    if found_item.nil?
      render json: { data: { message: "No item containing #{search_term} was found" } }
    else 
      render json: ItemSerializer.new(found_item)
    end 
  end 

end 