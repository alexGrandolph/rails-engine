# class MerchantSerializer < ActiveModel::Serializer
#   attributes :id, :name
# end
class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name
end