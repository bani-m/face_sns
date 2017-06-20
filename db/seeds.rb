#100.times do |n|
#  email = Faker::Internet.email
#  password = "password"
# User.create!(email: email,
 #              password: password,
  #             password_confirmation: password,
   #            uid: n,
    #           provider: n,
     #          )
#end

#100.times do |t|
 # title = Faker::Book.title
  #content = Faker::Beer.name
  #Topic.create!(title: title,
    #           content: content,
    #          )

#end

100.times do |p|
  content = Faker::LordOfTheRings.character
  Comment.create!(content: content,
                  )
end
#t.integer  "user_id"
 #   t.integer  "topic_id"
  #  t.text     "content"