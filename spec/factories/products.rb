FactoryBot.define do
  factory :product do
    number      {Faker::Number.unique.decimal_part(digits: 6)}
    length      {12.34}
    width       {123}
    client
    material
    user
  end
end
