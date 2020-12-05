# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Department.create(name: "製造部")
Department.create(name: "営業部")

Client.create(campany: "大日本工業")
Client.create(campany: "カントウ産業")
Client.create(campany: "NewTOKYO")

Material.create(name: “汎用ゴム薄”, basis_weight: 0.9)
Material.create(name: “汎用ゴム厚”, basis_weight: 1.4)
Material.create(name: “耐熱ゴム薄”, basis_weight: 1.0)
Material.create(name: “耐熱ゴム厚”, basis_weight: 1.6)
Material.create(name: “耐油ゴム薄”, basis_weight: 1.2)
Material.create(name: “耐油ゴム厚”, basis_weight: 2.0)

User.create(name: “鈴木　太郎“, number: "010123", password: "manu0123", department_id: 1)
User.create(name: “山田　花子”, number: "010456", password: "manu0456", department_id: 1)
User.create(name: “佐藤　一郎“, number: "020123", password: "sale0123", department_id: 2)
User.create(name: “田中　裕美“, number: "020456", password: "sale0456", department_id: 2)

Product.create(number: "010001", length: 23.45, width: 345, client_id: 1, material_id: 3, user_id: 3)
Product.create(number: "010002", length: 34.56, width: 400, client_id: 2, material_id: 2, user_id: 4)
