class RevenueSerializer
  include JSONAPI::Serializer
  attributes :revenue do |object|
    object.revenue
  end 
  
end 
# def self.ranged_revenue(revenue)
#   # binding.pry
# {
# "data": {
#   # "id": null,
#   "type": 'revenue',
#   "attributes": {
#     "revenue": revenue
#   }
# }
# }

# end