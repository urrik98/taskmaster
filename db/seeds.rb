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

start = 0
stop = 1

30.times do
  l = List.create(date:Faker::Date.between(start.days.ago, stop.days.ago), name:Faker::Lorem.sentence)
  start += 1
  stop += 1
  pending = Faker::Number.between(1, 7)
  pending.to_i.times do
    Todo.create(name:Faker::Lorem.sentence, list_id:l.id, status:"Pending")
  end
  complete = Faker::Number.between(1, 7)
  complete.to_i.times do
    Todo.create(name:Faker::Lorem.sentence, list_id:l.id, status:"Complete")
  end
  done = BigDecimal.new(l.todos.where(status:"Complete").count)
  total = BigDecimal.new(l.todos.count)
  perc = done/total
  score = BigDecimal(perc * l.todos.where(status:'Complete').count)
  l.update_attributes(completed_percentage:perc, completed_score:score)
end
