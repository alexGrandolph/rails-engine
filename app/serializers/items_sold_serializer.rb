class ItemsSoldSerializer
  include JSONAPI::Serializer
  attributes :name
  attributes :count do |merchant|
    merchant.sold_items
  end 
end
