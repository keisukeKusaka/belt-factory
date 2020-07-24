FactoryBot.define do
  factory :product do
    number      {"123456"}
    length      {12.34}
    width       {123}
    client_id   {1}
    material_id {1}
    user_id     {1}

    client
    material
    user
  end
end
