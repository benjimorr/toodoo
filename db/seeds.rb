require 'Faker'

my_user = User.create!(name: "Test User", email: "test@toodoo.com", password: "password", password_confirmation: "password")

5.times do
    Todo.create!(
        title: Faker::Lorem.characters(10),
        category: Faker::Lorem.characters(10),
        user: my_user
    )
end

todos = Todo.where(user_id: my_user.id)

20.times do
    Item.create!(
        name: Faker::Lorem.characters(15),
        complete: false,
        todo: todos.sample
    )
end

p "Seeds finished"
p "#{User.count} users created"
p "#{Todo.count} todo lists created"
p "#{Item.count} todo list items created"
