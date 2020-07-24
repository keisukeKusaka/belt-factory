FactoryBot.define do
  factory :user do
    name           {"テスト　ユーザー"}
    number         {Faker::Number.unique.decimal_part(digits: 6)}
    password       {"test1234"}
    department
  end
end
