FactoryBot.define do
  factory :production_datum do
    comment     {"コメントテスト"}
    image       {}
    product
    user
  end
end
