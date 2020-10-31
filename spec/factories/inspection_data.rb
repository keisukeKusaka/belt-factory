FactoryBot.define do
  factory :inspection_datum do
    length      {30.00}
    width       {400}
    weight      {144.0}
    comment     {"コメントテスト"}
    product
    user
  end
end
