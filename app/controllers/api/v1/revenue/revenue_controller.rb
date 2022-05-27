class Api::V1::Revenue::RevenueController < ApplicationController


  def date_range
    # binding.pry
    start = params[:start]
    last = params[:end]
    revenue = Invoice.range_revenue(start, last)
    render json: RevenueSerializer.ranged_revenue(revenue)
  end 
end