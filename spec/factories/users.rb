FactoryBot.define do
  factory :user do
    name           {"テスト　ユーザー"}
    number         {"123456"}
    password       {"test1234"}
    department_id  {1}

    department
  end
end
