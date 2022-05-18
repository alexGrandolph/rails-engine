class Api::V1::ItemSearchController < ApplicationController

  def show
    search_term = params[:name]
    # binding.pry
    found_item = Item.find_one_by_search_term(search_term)
    if found_item.nil?
      render json: { data: { message: "No item contaning #{search_term} was found" } }
    else 
      render json: ItemSerializer.new(found_item)
    end 
  end 

end 