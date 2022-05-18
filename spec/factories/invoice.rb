FactoryBot.define do
  factory :invoice do
    merchant_id {Faker::Number.between(from: 1, to: 10)}
    customer_id {Faker::Number.between(from: 1, to: 10)}
    status { Faker::Color.color_name}
  end
end