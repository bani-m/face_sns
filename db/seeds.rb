100.times do |n|
  email = Faker::Internet.email
  password = "password"
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               uid: n,
               provider: n,
               )
end

100.times do |t|
  title = Faker::Book.title
  content = Faker::Coffee.blend_name
  Topic.create!(title: title,
               content: content,
               )

end