FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name}
    description { Faker::Space.agency }
    unit_price {Faker::Number.decimal(l_digits: 2)}
    merchant_id {Faker::Number.between(from: 1, to: 10)}
  end
end