# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
r1 = Role.create(name:"Admin", desc: "Can execute all CRUD operations")
r2 = Role.create(name:"Regular", desc: "Limited permissions")

u1= User.create(name:"Lord Urrik", email:"urrik@lord.com", password:"Deathtongue98", password_confirmation:"Deathtongue98", role_id: 1)

o= List.create(name:"Orphans", user_id:u1.id)

6.times do
  l = List.create(date:Faker::Date.forward(30), name:Faker::Lorem.sentence)
  5.times do
    Todo.create(name:Faker::Lorem.sentence, list_id:l.id)
  end
end
