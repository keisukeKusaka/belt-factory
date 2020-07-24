FactoryBot.define do
  factory :product do
    number      {"123456"}
    length      {12.34}
    width       {123}
    client
    material
    user
  end
end
