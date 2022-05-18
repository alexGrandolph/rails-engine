FactoryBot.define do
  factory :invoice_item do
    item_id {Faker::Number.between(from: 1, to: 10)}
    invoice_id {Faker::Number.between(from: 1, to: 10)}
    quantity { Faker::Number.between(from: 1, to: 15)}
    unit_price {Faker::Number.decimal(l_digits: 2)}
  end
end