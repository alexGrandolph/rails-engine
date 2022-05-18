class Api::V1::ItemSearchController < ApplicationController

  def show
    search_term = params[:name]
    # binding.pry
    found_item = Item.find_one_by_search_term(search_term)
    render json: ItemSerializer.new(found_item)
  end 

end 