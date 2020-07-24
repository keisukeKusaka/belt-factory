FactoryBot.define do
  factory :user do
    name           {"テスト　ユーザー"}
    number         {"123456"}
    password       {"test1234"}
    department
  end
end
