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

Material.create(name: "Type08", basis_weight: 0.8)
Material.create(name: "Type12", basis_weight: 1.2)
Material.create(name: "Type16", basis_weight: 1.6)

User.create(name: "セイゾウ モノ太郎", number: "010123", password: "manu0123", department_id: 1)
User.create(name: "セイゾウ する代", number: "010456", password: "manu0456", department_id: 1)
User.create(name: "エイギョウ モノ次郎", number: "020123", password: "sale0123", department_id: 2)
User.create(name: "エイギョウ うる代", number: "020456", password: "sale0456", department_id: 2)

Product.create(number: "010001", length: 23.45, width: 345, client_id: 1, material_id: 3, user_id: 3)
Product.create(number: "010002", length: 34.56, width: 400, client_id: 2, material_id: 2, user_id: 4)
