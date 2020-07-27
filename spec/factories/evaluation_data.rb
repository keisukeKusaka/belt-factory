FactoryBot.define do
  factory :evaluation_datum do
    comment     {"コメントテスト"}
    image       {}
    product
    user
  end
end
